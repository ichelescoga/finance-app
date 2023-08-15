import 'dart:convert';

import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';
import 'package:developer_company/shared/validations/email_validator.dart';
import 'package:developer_company/shared/validations/not_empty.dart';
import 'package:developer_company/shared/validations/percentage_validator.dart';
import 'package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
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

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      quoteId = arguments["unitId"];

      if (quoteId != null) {
        final discount = arguments['discount'].toString();
        final clientName = arguments['clientName'].toString();
        final clientPhone = arguments['clientPhone'].toString();
        final email = arguments['email'].toString();
        final startMoney = arguments['startMoney'].toString();
        final paymentMonths = arguments['paymentMonths'].toString();

        unitDetailPageController.updateController(
          discount,
          clientName,
          clientPhone,
          email,
          startMoney,
          paymentMonths,
        );
        setState(() {
          _isPayedTotal = arguments["cashPrice"] == 1 ? true : false;
          _isAguinaldoSwitched = arguments["aguinaldo"] == 1 ? true : false;
          _isBonoSwitched = arguments["bonusCatorce"] == 1 ? true : false;
        });
      }

      unitDetailPageController.discount.text = "0";
      unitDetailPageController.unit.text = arguments["unitName"];
      unitDetailPageController.salePrice.text = arguments["salePrice"];
      unitDetailPageController.finalSellPrice.text =
          arguments["finalSellPrice"];
      _quoteEdit = arguments["unitStatus"] != 4;
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
                onTap: () {
                  //! should be ask for administrator;
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
                enabled: _quoteEdit,
                controller: unitDetailPageController.discount,
                label: "Descuento",
                hintText: "Descuento",
                prefixIcon: Icons.person_outline),
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
                validator: (value) => notEmptyFieldValidator(value),
                enabled: _quoteEdit,
                controller: unitDetailPageController.clientPhone,
                label: "Teléfono",
                hintText: "Teléfono",
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
                prefixIcon: Icons.person_outline),
            CustomInputWidget(
                validator: (value) => notEmptyFieldValidator(value),
                enabled: _quoteEdit,
                controller: unitDetailPageController.paymentMonths,
                label: "Plazo en meses",
                hintText: "Plazo en meses",
                prefixIcon: Icons.person_outline),
            SwitchListTile(
              title: const Text(
                'Aguinaldo',
                style: TextStyle(color: Colors.black),
              ),
              value: _isAguinaldoSwitched,
              onChanged: (bool value) {
                setState(() {
                  _isAguinaldoSwitched = value;
                });
              },
              activeColor: AppColors.secondaryMainColor,
            ),
            const SizedBox(height: Dimensions.heightSize),
            SwitchListTile(
              title: const Text(
                'Bono 14',
                style: TextStyle(color: Colors.black),
              ),
              value: _isBonoSwitched,
              onChanged: (bool value) {
                setState(() {
                  _isBonoSwitched = value;
                });
              },
              activeColor: AppColors.secondaryMainColor,
            ),
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
                        "anioInicio": "2023",
                        "anioFin": (2023 + yearOfEnd).toString(),
                        "ventaDescuento": finalSellPrice,
                        "enganche": unitDetailPageController.startMoney.text,
                        "mesesPlazo": months.toString(),
                        "mesInicio": currentMonth.toString(),
                        "mesFin": monthOfEnd.toString(),
                        "descuento": unitDetailPageController.discount.text,
                        "precioContado": _isAguinaldoSwitched ? "1" : "0",
                        "aguinaldo": _isBonoSwitched ? "1" : "0",
                        "bonoCatorce": _isPayedTotal ? "1" : "0",
                        "idUnidad": unitId.toString(),
                      };
                      try {
                        EasyLoading.showToast(Strings.loading);
                        if (quoteId == null) {
                          //CREATE QUOTE FIRST TIME
                          final response = await httpAdapter
                              .postApi("orders/v1/createCotizacion", body, {});

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
                              body, {});
                        }

                        Get.toNamed(
                            RouterPaths.CLIENT_CREDIT_SCHEDULE_PAYMENTS_PAGE);
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
                    Get.back(closeOverlays: true);
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
