import 'dart:convert';

import 'package:developer_company/data/implementations/loan_simulation_repository_impl.dart';
import 'package:developer_company/data/implementations/unit_quotation_repository_impl.dart';
import 'package:developer_company/data/models/loan_simulation_model.dart';
import 'package:developer_company/data/models/unit_quotation_model.dart';
import 'package:developer_company/data/providers/loan_simulation_provider.dart';
import 'package:developer_company/data/providers/unit_quotation_provider.dart';
import 'package:developer_company/data/repositories/loan_simulation_repository.dart';
import 'package:developer_company/data/repositories/unit_quotation_repository.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';
import 'package:developer_company/shared/validations/email_validator.dart';
import 'package:developer_company/shared/validations/grater_than_number_validator.dart';
import 'package:developer_company/shared/validations/lower_than_number_validator%20copy.dart';
import 'package:developer_company/shared/validations/not_empty.dart';
import 'package:developer_company/shared/validations/number_length_validator.dart';
import 'package:developer_company/shared/validations/percentage_validator.dart';
import 'package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/widgets/admin_permission_modal.dart';
import 'package:developer_company/widgets/app_bar_two_images.dart';
import 'package:developer_company/widgets/custom_button_widget.dart';
import 'package:developer_company/widgets/custom_input_widget.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

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
  bool _isPayedTotal = false;
  bool _quoteEdit = true;
  int? quoteId;
  bool _canEditDiscount = false;
  Quotation? quoteInfo;
  bool isFetchQuote = false;

  final UnitQuotationRepository unitQuotationRepository =
      UnitQuotationRepositoryImpl(UnitQuotationProvider());

  LoanSimulationRepository loanSimulationRepository =
      LoanSimulationRepositoryImpl(LoanSimulationProvider());

  final Map<String, dynamic> arguments = Get.arguments;

  String calculateFinalSellPrice(value) {
    if (value == null) {
      return unitDetailPageController.finalSellPrice.text =
          unitDetailPageController.salePrice.text;
    }
    final salePrice = double.tryParse(arguments["salePrice"]);
    final discountPercentage = int.tryParse(value);
    if (discountPercentage != null && !percentageValidator(value)) {
      return salePrice.toString();
    } else if (salePrice != null && discountPercentage != null) {
      final discountAmount = salePrice * (discountPercentage / 100);
      return (salePrice - discountAmount).toString();
    } else {
      return salePrice.toString();
    }
  }

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
        );
        setState(() {
          _isPayedTotal = quoteInfo?.cashPrice == 1 ? true : false;
          _isAguinaldoSwitched = quoteInfo?.aguinaldo == 1 ? true : false;
          _isBonoSwitched = quoteInfo?.bonusCatorce == 1 ? true : false;
        });
      }
      _quoteEdit = arguments["unitStatus"] != 3;
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
    return Layout(
      sideBarList: const [],
      appBar: CustomAppBarTwoImages(
          title: 'Cotización',
          leftImage: 'assets/logo_test.png',
          rightImage: 'assets/logo_test.png'),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimensions.heightSize),
            CustomInputWidget(
                enabled: false,
                controller: unitDetailPageController.unit,
                label: "Unidad",
                hintText: "Unidad",
                prefixIcon: Icons.person_outline),
            CustomInputWidget(
                enabled: false,
                controller: unitDetailPageController.salePrice,
                label: "Precio de venta",
                hintText: "precio de venta",
                prefixIcon: Icons.person_outline),
            CustomInputWidget(
                enabled: _quoteEdit,
                readOnly: !_canEditDiscount,
                onTapOutside: (p0) {
                  setState(() {
                    _canEditDiscount = false;
                  });
                },
                onTap: () {
                  _showPermissionDialog(context);
                },
                onChange: (value) {
                  unitDetailPageController.finalSellPrice.text =
                      calculateFinalSellPrice(value);
                },
                validator: (value) {
                  if (value == "0") return null;
                  final percentageIsValid = percentageValidator(value);
                  if (!percentageIsValid) {
                    return "Valor debe de ser entre 0 y 100";
                  }
                  return null;
                },
                controller: unitDetailPageController.discount,
                label: "Descuento",
                hintText: "Descuento",
                keyboardType: TextInputType.number,
                prefixIcon: Icons.percent),
            CustomInputWidget(
                validator: (value) => notEmptyFieldValidator(value),
                enabled: false,
                controller: unitDetailPageController.finalSellPrice,
                label: "Precio con descuento",
                hintText: "Precio con descuento",
                prefixIcon: Icons.person_outline),
            CustomInputWidget(
                validator: (value) => notEmptyFieldValidator(value),
                enabled: _quoteEdit,
                controller: unitDetailPageController.clientName,
                label: "Nombre de Cliente",
                hintText: "Nombre de Cliente",
                prefixIcon: Icons.person_outline),
            CustomInputWidget(
                validator: (value) => numberLengthValidator(value, 8, 8)
                    ? null
                    : '${Strings.numberPhoneNotValid}, dígitos ${value?.length}',
                enabled: _quoteEdit,
                controller: unitDetailPageController.clientPhone,
                label: "Teléfono",
                hintText: "Teléfono",
                keyboardType: TextInputType.phone,
                prefixIcon: Icons.person_outline),
            CustomInputWidget(
                validator: (value) => emailValidator(value),
                enabled: _quoteEdit,
                controller: unitDetailPageController.email,
                label: "Correo",
                hintText: "Correo",
                prefixIcon: Icons.person_outline),
            CustomInputWidget(
                validator: (value) => notEmptyFieldValidator(value),
                enabled: _quoteEdit,
                controller: unitDetailPageController.startMoney,
                label: "Enganche",
                hintText: "Enganche",
                keyboardType: TextInputType.number,
                prefixIcon: Icons.person_outline),
            CustomInputWidget(
                validator: (value) {
                  final isValidMinMonths = graterThanNumberValidator(value, 1);
                  final isValidMaxMonths = lowerThanNumberValidator(value, 240);
                  if(!isValidMinMonths) return '${Strings.termInMonthsMin} 0';
                  
                  if (isValidMaxMonths) return null;
                  return '${Strings.termInMonthsMax} 240';
                },
                enabled: _quoteEdit,
                controller: unitDetailPageController.paymentMonths,
                label: "Plazo en meses",
                hintText: "Plazo en meses",
                keyboardType: TextInputType.number,
                prefixIcon: Icons.person_outline),
            SwitchListTile(
              title: const Text(
                'Precio al contado',
                style: TextStyle(color: Colors.black),
              ),
              value: _isPayedTotal,
              onChanged: (bool value) {
                setState(() {
                  _isPayedTotal = value;
                });
              },
              activeColor: AppColors.secondaryMainColor,
            ),
            const SizedBox(height: Dimensions.heightSize),
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

                      String finalSellPrice = calculateFinalSellPrice(
                          unitDetailPageController.discount.text);

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
                        "precioContado": _isPayedTotal ? "1" : "0",
                        "aguinaldo": _isBonoSwitched ? "1" : "0",
                        "bonoCatorce": _isAguinaldoSwitched ? "1" : "0",
                        "idUnidad": unitId.toString(),
                        "ingresoMensual": "0",
                        "cliente": {
                          "primerNombre":
                              unitDetailPageController.clientName.text,
                          "fechaNacimiento": "",
                          "oficio": "",
                          "nit": "",
                          "dpi": "",
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
                                totalCreditValue: creditValue);

                        List<LoanSimulationResponse?> simulation =
                            await loanSimulationRepository
                                .simulateLoan(loanSimulationRequest);

                        if (simulation.contains(null)) {
                          simulation = [];
                        }

                        print(simulation);

                        await await Get.toNamed(
                            RouterPaths.CLIENT_CREDIT_SCHEDULE_PAYMENTS_PAGE,
                            arguments: {
                              'quoteId': quoteId,
                              'simulationSchedule': simulation
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

  _showPermissionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return PermissionAdminModal(
            alertHeight: 180,
            alertWidth: 200,
            onTapFunction: () {
              setState(() {
                _canEditDiscount = true;
              });
            },
          );
        });
  }
}
