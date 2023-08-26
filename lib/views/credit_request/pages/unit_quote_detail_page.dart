import 'dart:convert';
import 'dart:io';

import 'package:developer_company/data/implementations/loan_simulation_repository_impl.dart';
import 'package:developer_company/data/implementations/unit_quotation_repository_impl.dart';
import 'package:developer_company/data/models/loan_simulation_model.dart';
import 'package:developer_company/data/models/unit_quotation_model.dart';
import 'package:developer_company/data/providers/loan_simulation_provider.dart';
import 'package:developer_company/data/providers/unit_quotation_provider.dart';
import 'package:developer_company/data/repositories/loan_simulation_repository.dart';
import 'package:developer_company/data/repositories/unit_quotation_repository.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';
import 'package:developer_company/shared/validations/not_empty.dart';
import 'package:developer_company/views/credit_request/helpers/calculate_sell_price_discount.dart';
import 'package:developer_company/views/credit_request/helpers/handle_balance_to_finance.dart';
import 'package:developer_company/views/credit_request/pages/form_quote.dart';
import 'package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart';

import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/widgets/app_bar_two_images.dart';
import 'package:developer_company/widgets/custom_button_widget.dart';
import 'package:developer_company/widgets/custom_input_widget.dart';

import 'package:developer_company/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UnitQuoteDetailPage extends StatefulWidget {
  const UnitQuoteDetailPage({Key? key}) : super(key: key);

  @override
  State<UnitQuoteDetailPage> createState() => _UnitQuoteDetailPageState();
}

class _UnitQuoteDetailPageState extends State<UnitQuoteDetailPage> {
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
            quoteInfo?.discount.toString(),
            quoteInfo?.downPayment.toString(),
            quoteInfo?.termMonths.toString(),
            quoteInfo?.clientData?.email.toString(),
            quoteInfo?.clientData?.name.toString(),
            quoteInfo?.clientData?.phone.toString(),
            quoteInfo?.cashPrice == 1 ? true : false);
        setState(() {
          _isAguinaldoSwitched = quoteInfo?.aguinaldo == 1 ? true : false;
          _isBonoSwitched = quoteInfo?.bonusCatorce == 1 ? true : false;
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
              statusQuoteById == 7);
        });
      }

      unitDetailPageController.unit.text = arguments["unitName"];
      unitDetailPageController.salePrice.text = arguments["salePrice"];
      unitDetailPageController.finalSellPrice.text =
          arguments["finalSellPrice"].toString();
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      start();
    });
  }

  @override
  Widget build(BuildContext context) {
    unitDetailPageController.finalSellPrice.addListener(handleBalanceToFinance);
    unitDetailPageController.startMoney.addListener(handleBalanceToFinance);

    return Layout(
      sideBarList: const [],
      actionButton: quoteId != null
          ? FloatingActionButton(
              onPressed: () {
                _showModalSendWhatsApp(context);
              },
              child: const Icon(Icons.picture_as_pdf),
              backgroundColor: AppColors.softMainColor,
            )
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
            FormQuote(salePrice: arguments["salePrice"], quoteEdit: _quoteEdit),
            Column(
              children: <Widget>[
                CustomButtonWidget(
                  text: "Programación de pagos",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      final unitId = arguments["unitId"];
                      const year = 12;
                      DateTime now = DateTime.now();
                      int currentMonth = now.month;
                      int? months = int.tryParse(
                              unitDetailPageController.paymentMonths.text) ??
                          0 + currentMonth;
                      double years = months / year;
                      int yearOfEnd = years.floor();

                      int monthOfEnd = months % year;

                      // String finalSellPrice = calculateSellPriceDiscount(
                      //     unitDetailPageController.discount.text);

                      String finalSellPrice = calculateSellPriceDiscount(
                          unitDetailPageController.discount.text,
                          unitDetailPageController,
                          arguments["salePrice"]);

                      final body = {
                        "idPlanFinanciero": null,
                        "anioInicio": "2023",
                        "anioFin": (2023 + yearOfEnd).toString(),
                        "ventaDescuento": finalSellPrice,
                        "enganche": unitDetailPageController.startMoney.text,
                        "mesesPlazo": months.toString(),
                        "mesInicio": currentMonth.toString(),
                        "mesFin": monthOfEnd.toString(),
                        "descuento": unitDetailPageController.discount.text,
                        "precioContado":
                            unitDetailPageController.isPayedTotal ? "1" : "0",
                        "aguinaldo": _isBonoSwitched ? "1" : "0",
                        "bonoCatorce": _isAguinaldoSwitched ? "1" : "0",
                        "idUnidad": unitId.toString(),
                        "ingresoMensual": "0",
                        "cliente": {
                          "primerNombre":
                              unitDetailPageController.clientName.text,
                          "fechaNacimiento": "",
                          "oficio": "",
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

                          final responseData = json.decode(response.body)
                              as Map<String, dynamic>;
                          final quoteIdResponse =
                              responseData['idCotizacion'] as int?;

                          if (quoteIdResponse != null) {
                            setState(() {
                              quoteId = quoteIdResponse;
                            });
                          }
                        } else {
                          //EDIT QUOTE
                          await httpAdapter.putApi(
                              "orders/v1/actualizarCotizacion/$quoteId",
                              json.encode(body), {});
                        }
                        setState(() {
                          isFetchQuote = true;
                        });
                        //? SHOULD BE GET PAYMENT SCHEDULE

                        final anualPayments = double.tryParse(
                                unitDetailPageController.paymentMonths.text)! /
                            12;
                        double creditValue = double.tryParse(
                            unitDetailPageController.finalSellPrice.text)!;

                        LoanSimulationRequest loanSimulationRequest =
                            LoanSimulationRequest(
                                annualInterest: 6.2,
                                annualPayments: anualPayments,
                                totalCreditValue: creditValue,
                                cashPrice:
                                    unitDetailPageController.isPayedTotal);

                        List<LoanSimulationResponse?> simulation =
                            await loanSimulationRepository
                                .simulateLoan(loanSimulationRequest);

                        if (simulation.contains(null)) {
                          simulation = [];
                        }

                        final quoteStatus = quoteInfo!.estadoId;

                        await Get.toNamed(
                            RouterPaths.CLIENT_CREDIT_SCHEDULE_PAYMENTS_PAGE,
                            arguments: {
                              'quoteId': quoteId,
                              'simulationSchedule': simulation,
                              "quoteState": quoteStatus ?? 2
                            });
                      } catch (e) {
                        print(e);
                        EasyLoading.showError(Strings.pleaseVerifyInputs);
                      } finally {
                        EasyLoading.dismiss();
                      }
                    } else {
                      EasyLoading.showError(Strings.pleaseVerifyInputs);
                    }
                  },
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

  _showModalSendWhatsApp(BuildContext context) {
    TextEditingController commentController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    final _formKeyComments = GlobalKey<FormState>();

    return showDialog(
        context: context,
        builder: ((BuildContext context) {
          return Center(
            child: Container(
              color: Colors.white,
              height: Get.height / 3,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formKeyComments,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("¿Enviar Cotización de crédito?",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Dimensions.extraLargeTextSize,
                              overflow: TextOverflow.ellipsis,
                            )),
                        CustomInputWidget(
                            controller: phoneController,
                            validator: (value) {
                              if (value!.length != 8) {
                                return "Teléfono no valido";
                              }
                              return null;
                            },
                            label: "Teléfono",
                            hintText: "Teléfono",
                            keyboardType: TextInputType.number,
                            prefixIcon: Icons.comment),
                        CustomInputWidget(
                            controller: commentController,
                            validator: (value) => notEmptyFieldValidator(value),
                            label: "Comentarios Extra",
                            hintText: "Comentarios Extra",
                            prefixIcon: Icons.comment),
                        Row(
                          children: [
                            Expanded(
                                child: CustomButtonWidget(
                                    color: AppColors.blueColor,
                                    text: "Enviar",
                                    onTap: () async {
                                      if (_formKeyComments.currentState!
                                          .validate()) {
                                        print('FAB pressed $quoteId');

                                        final response = await httpAdapter.postApi(
                                            "orders/v1/cotizacionPdf/$quoteId",
                                            {},
                                            {});

                                        if (response.statusCode != 200) {
                                          EasyLoading.showError(
                                              "Cotización no pudo ser generada.");
                                          return;
                                        }

                                        final responseBody =
                                            json.decode(response.body);
                                        final url = responseBody['body'];
                                        String phoneNumber = "+502${phoneController.text}";
                                        String text =
                                            "${commentController.text} \n $url";

                                        final whatsAppURlAndroid =
                                            "whatsapp://send?phone=" +
                                                phoneNumber +
                                                "&text=$text";
                                        await launchUrl(
                                            Uri.parse(whatsAppURlAndroid));

                                        EasyLoading.showSuccess(
                                            "Cotización Enviada con éxito");

                                        Navigator.of(context).pop();
                                      }
                                    })),
                            Expanded(
                                child: CustomButtonWidget(
                                    text: "Regresar",
                                    onTap: () => Navigator.of(context).pop()))
                          ],
                        )
                      ]),
                ),
              ),
            ),
          );
        }));
  }
}
