import 'dart:convert';

import 'package:developer_company/data/implementations/loan_simulation_repository_impl.dart';
import 'package:developer_company/data/implementations/unit_quotation_repository_impl.dart';
import 'package:developer_company/data/models/loan_simulation_model.dart';
import 'package:developer_company/data/models/unit_quotation_model.dart';
import 'package:developer_company/data/providers/loan_simulation_provider.dart';
import 'package:developer_company/data/providers/unit_quotation_provider.dart';
import 'package:developer_company/data/repositories/loan_simulation_repository.dart';
import 'package:developer_company/data/repositories/unit_quotation_repository.dart';
import 'package:developer_company/global_state/providers/client_provider_state.dart';

import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/shared/services/quetzales_currency.dart';
import 'package:developer_company/shared/utils/discount_status_text.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';

import 'package:developer_company/views/credit_request/helpers/handle_balance_to_finance.dart';

import 'package:developer_company/views/credit_request/forms/form_quote.dart';
import 'package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart';

import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/widgets/app_bar_two_images.dart';
import 'package:developer_company/widgets/custom_button_widget.dart';

import 'package:developer_company/widgets/layout.dart';
import 'package:developer_company/widgets/share_quote_action_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get/get.dart';

class UnitQuoteDetailPage extends ConsumerStatefulWidget {
  const UnitQuoteDetailPage({Key? key}) : super(key: key);

  @override
  ConsumerState<UnitQuoteDetailPage> createState() =>
      _UnitQuoteDetailPageState();
}

class _UnitQuoteDetailPageState extends ConsumerState<UnitQuoteDetailPage> {
  final httpAdapter = HttpAdapter();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UnitDetailPageController unitDetailPageController =
      Get.put(UnitDetailPageController());
  bool _isAguinaldoSwitched = false;
  bool _isBonoSwitched = false;
  bool _quoteEdit = true;
  int? quoteId;
  Quotation? quoteInfo;
  bool isFetchQuote = false;

  final UnitQuotationRepository unitQuotationRepository =
      UnitQuotationRepositoryImpl(UnitQuotationProvider());

  LoanSimulationRepository loanSimulationRepository =
      LoanSimulationRepositoryImpl(LoanSimulationProvider());

  final Map<String, dynamic> arguments = Get.arguments;

  Future<void> start() async {
    quoteId = arguments["quoteId"];

    try {
      EasyLoading.show(status: Strings.loading);
      if (quoteId != null) {
        quoteInfo = await unitQuotationRepository
            .fetchQuotationById(quoteId.toString());
        unitDetailPageController.updateController(
          quoteInfo?.extraDiscount.toString(),
          quoteInfo?.statusDiscount,
          quoteInfo?.resolutionDiscount.toString(),
          quoteInfo?.downPayment.toString(),
          quoteInfo?.termMonths.toString(),
          quoteInfo?.clientData?.email.toString(),
          quoteInfo?.clientData?.name.toString(),
          quoteInfo?.clientData?.phone.toString(),
        );

        setState(() {
          _isAguinaldoSwitched = quoteInfo?.aguinaldo == 1 ? true : false;
          _isBonoSwitched = quoteInfo?.bonusCatorce == 1 ? true : false;
          unitDetailPageController.isPayedTotal =
              quoteInfo?.cashPrice == 1 ? true : false;
        });
      }
      //TODO: STUB ENHANCE LOGIC unit_status unitStatus
      // _quoteEdit = !(arguments["unitStatus"] == 3 ||
      //     arguments["unitStatus"] == 6 ||
      //     arguments["unitStatus"] == 7);
      final statusQuoteById = quoteInfo?.estadoId;
      if (statusQuoteById != null) {
        setState(() {
          _quoteEdit = !(statusQuoteById == 3 ||
              statusQuoteById == 6 ||
              statusQuoteById == 7 ||
              arguments["unitStatus"] == 3 ||
              arguments["unitStatus"] == 5); //unitStatus unit_status
        });
      } else {
        setState(() {
          _quoteEdit =
              !(arguments["unitStatus"] == 3 || arguments["unitStatus"] == 5);
        });
      }

      setState(() {
        unitDetailPageController.unit.text = arguments["unitName"];
        unitDetailPageController.salePrice.text = arguments["salePrice"];
        unitDetailPageController.finalSellPrice.text =
            quetzalesCurrency(arguments["finalSellPrice"].toString());
        unitDetailPageController.balanceToFinance.text = handleBalanceToFinance(
            unitDetailPageController.finalSellPrice.text,
            unitDetailPageController.startMoney.text);
      });
      // final balance =
      // unitDetailPageController.balanceToFinance.text = balance;
    } finally {
      EasyLoading.dismiss();
    }
  }

  void _handleSubmitForm() async {
    if (_formKey.currentState!.validate()) {
      final unitId = arguments["unitId"];
      const year = 12;
      DateTime now = DateTime.now();
      int currentMonth = now.month;
      int? months = int.tryParse(unitDetailPageController.paymentMonths.text) ??
          0 + currentMonth;
      double years = months / year;
      int yearOfEnd = years.floor();

      int monthOfEnd = months % year;

      double discountValue =
          double.tryParse(unitDetailPageController.extraDiscount.text)!;

      final body = {
        "idPlanFinanciero": null,
        "anioInicio": "2023",
        "anioFin": (2023 + yearOfEnd).toString(),
        "ventaDescuento": unitDetailPageController.salePrice.text,
        "enganche": extractNumber(unitDetailPageController.startMoney.text),
        "mesesPlazo": months.toString(),
        "mesInicio": currentMonth.toString(),
        "mesFin": monthOfEnd.toString(),
        "descuento": "0",
        "precioContado": unitDetailPageController.isPayedTotal ? true : false,
        "aguinaldo": _isBonoSwitched ? "1" : "0",
        "bonoCatorce": _isAguinaldoSwitched ? "1" : "0",
        "idUnidad": unitId.toString(),
        "ingresoMensual": "0",
        "comentario": null,
        "montoDescuentSolicitado": unitDetailPageController.applyDefaultDiscount
            ? discountValue.toInt() == 0
                ? int.tryParse(unitDetailPageController.seasonDiscount.text)
                : discountValue.toInt()
            : "0",
        "solicitudDescuent":
            unitDetailPageController.applyDefaultDiscount ? "0" : null,
        "clienteId": unitDetailPageController.clientId.text.length > 0 ? unitDetailPageController.clientId.text : null,
        "cliente": unitDetailPageController.clientId.text.length > 0 ? null : {
          "primerNombre": unitDetailPageController.clientName.text,
          "telefono": unitDetailPageController.clientPhone.text,
          "correo": unitDetailPageController.email.text,
          "idNacionalidad": "1"
        }
      };

      try {
        EasyLoading.showToast(Strings.loading);
        if (quoteId == null) {
          //CREATE QUOTE FIRST TIME

          final response = await httpAdapter.postApi(
              "orders/v1/createCotizacion",
              json.encode(body),
              {'Content-Type': 'application/json'});

          final responseData =
              json.decode(response.body) as Map<String, dynamic>;
          final quoteIdResponse = responseData['idCotizacion'] as int?;

          if (quoteIdResponse != null) {
            setState(() {
              quoteId = quoteIdResponse;
            });
          }
        } else {
          //EDIT QUOTE
          if (!isApprovedDiscount(unitDetailPageController.statusDiscount,
              unitDetailPageController.resolutionDiscount)) {
            final bodyDiscount = {
              "montoDescuento": unitDetailPageController.applyDefaultDiscount
                  ? discountValue.toInt() == 0
                      ? int.tryParse(
                          unitDetailPageController.seasonDiscount.text)
                      : discountValue.toInt()
                  : "0"
            };
            await httpAdapter.putApi(
                "orders/v1/solicitudDescuento/$quoteId",
                json.encode(bodyDiscount),
                {'Content-Type': 'application/json'});
          }

          await httpAdapter.putApi(
              "orders/v1/actualizarCotizacion/$quoteId", json.encode(body), {});
        }
        setState(() {
          isFetchQuote = true;
        });
        //? SHOULD BE GET PAYMENT SCHEDULE

        final anualPayments =
            double.tryParse(unitDetailPageController.paymentMonths.text)! / 12;
        double creditValue = double.tryParse(
            extractNumber(unitDetailPageController.finalSellPrice.text)!)!;

        LoanSimulationRequest loanSimulationRequest = LoanSimulationRequest(
            annualInterest: 16,
            annualPayments: anualPayments,
            totalCreditValue: creditValue,
            cashPrice: unitDetailPageController.isPayedTotal);

        List<LoanSimulationResponse?> simulation =
            await loanSimulationRepository.simulateLoan(loanSimulationRequest);

        if (simulation.contains(null)) {
          simulation = [];
        }

        final quoteStatus = quoteInfo?.estadoId ?? 2;

        await Get.toNamed(RouterPaths.CLIENT_CREDIT_SCHEDULE_PAYMENTS_PAGE,
            arguments: {
              'quoteId': quoteId,
              'simulationSchedule': simulation,
              "quoteState": quoteStatus,
              "unitStatus": arguments["unitStatus"]
            });
      } catch (e) {
        print("ERROR: 🤖🤖🤖 $e");
        EasyLoading.showError(Strings.pleaseVerifyInputs);
      } finally {
        EasyLoading.dismiss();
      }
    } else {
      EasyLoading.showError(Strings.pleaseVerifyInputs);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      start();
    });

    final selectedContactToClient =
        ref.read(selectedContactToClientProviderState);
    if (selectedContactToClient != null) {
      unitDetailPageController.updateClientInfo(selectedContactToClient);
    }
  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    unitDetailPageController.finalSellPrice.addListener(() =>
        unitDetailPageController.balanceToFinance.text = handleBalanceToFinance(
            unitDetailPageController.finalSellPrice.text,
            unitDetailPageController.startMoney.text));

    unitDetailPageController.startMoney.addListener(() {
      unitDetailPageController.balanceToFinance.text = handleBalanceToFinance(
          unitDetailPageController.finalSellPrice.text,
          unitDetailPageController.startMoney.text);
    });

    return Layout(
      sideBarList: const [],
      actionButton: quoteId != null
          ? ShareQuoteActionButtons(quoteId: quoteId.toString())
          : null,
      appBar: CustomAppBarTwoImages(
          title: 'Cotización',
          leftImage: 'assets/logo_test.png',
          rightImage: 'assets/logo_test.png'),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormQuote(salePrice: arguments["salePrice"], quoteEdit: _quoteEdit, isEditing: false),
            Column(
              children: <Widget>[
                CustomButtonWidget(
                  text: "Programación de pagos",
                  onTap: () => _handleSubmitForm(),
                ),
                const SizedBox(height: Dimensions.heightSize),
                CustomButtonWidget(
                  text: "Regresar",
                  onTap: () {
                    Get.back(closeOverlays: true, result: isFetchQuote);
                    isFetchQuote = false;
                  },
                )
              ],
            ),
            const SizedBox(height: Dimensions.heightSize),
          ],
        ),
      ),
    );
  }
}
