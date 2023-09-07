import 'package:developer_company/data/models/unit_quotation_model.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/shared/services/quetzales_currency.dart';
import 'package:developer_company/shared/validations/email_validator.dart';
import 'package:developer_company/shared/validations/grater_than_number_validator.dart';
import 'package:developer_company/shared/validations/lower_than_number_validator%20copy.dart';
import 'package:developer_company/shared/validations/not_empty.dart';
import 'package:developer_company/shared/validations/string_length_validator.dart';
import 'package:developer_company/shared/validations/percentage_validator.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/views/credit_request/helpers/calculate_sell_price_discount.dart';
import 'package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart';
import 'package:developer_company/widgets/admin_permission_modal.dart';
import 'package:developer_company/widgets/custom_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class FormQuote extends StatefulWidget {
  final bool quoteEdit;
  final bool canEditDiscount;
  final String salePrice;

  const FormQuote(
      {Key? key,
      this.quoteEdit = true,
      required this.salePrice,
      this.canEditDiscount = false})
      : super(key: key);

  @override
  _FormQuoteState createState() => _FormQuoteState();
}

class _FormQuoteState extends State<FormQuote> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UnitDetailPageController unitDetailPageController =
      Get.put(UnitDetailPageController());
  bool _canEditDiscount = false;
  int? quoteId;

  Quotation? quoteInfo;
  bool isFetchQuote = false;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            controller: TextEditingController(
                text:
                    quetzalesCurrency(unitDetailPageController.salePrice.text)),
            keyboardType: TextInputType.number,
            label: "Precio de venta",
            hintText: "precio de venta",
            prefixIcon: Icons.person_outline),
        CustomInputWidget(
            enabled: widget.quoteEdit,
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
                  calculateSellPriceDiscount(
                      value, unitDetailPageController, unitDetailPageController.salePrice.text);
            },
            validator: (value) {
              if (value == "0") return null;
              final percentageIsValid = percentageValidator(value);
              if (!percentageIsValid) {
                return "Valor debe de ser entre 0 y 25";
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
            enabled: widget.quoteEdit,
            controller: unitDetailPageController.clientName,
            label: "Nombre de Cliente",
            hintText: "Nombre de Cliente",
            prefixIcon: Icons.person_outline),
        CustomInputWidget(
            validator: (value) => stringLengthValidator(value, 8, 8)
                ? null
                : '${Strings.numberPhoneNotValid}, dígitos ${value?.length}',
            enabled: widget.quoteEdit,
            controller: unitDetailPageController.clientPhone,
            label: "Teléfono",
            hintText: "Teléfono",
            keyboardType: TextInputType.phone,
            prefixIcon: Icons.person_outline),
        CustomInputWidget(
            validator: (value) => emailValidator(value),
            enabled: widget.quoteEdit,
            controller: unitDetailPageController.email,
            keyboardType: TextInputType.emailAddress,
            label: "Correo",
            hintText: "Correo",
            prefixIcon: Icons.person_outline),
        CustomInputWidget(
            onFocusChangeInput: (hasFocus) {
              if (!hasFocus) {
                unitDetailPageController.startMoney.text =
                    quetzalesCurrency(unitDetailPageController.startMoney.text);
              } 
            },
            validator: (value) {
              final enganche = extractNumber(value!);
              if (enganche == null) {
                return "Verifique que el valor sea correcto";
              }

              final isValidMinMonths = graterThanNumberValidator(enganche, 1);
              final finalSellPrice =
                  extractNumber(unitDetailPageController.finalSellPrice.text);

              if (finalSellPrice != null) {
                double priceWithDiscount = double.parse(finalSellPrice);
                final isValidMaxMonths =
                    double.parse(enganche) <= priceWithDiscount;

                if (!isValidMinMonths) return 'El Enganche debe ser mayor 0';
                if (isValidMaxMonths) return null;
                return 'El Enganche debe ser menor a ${unitDetailPageController.finalSellPrice.text}';
              }
              return "Algo salio mal valide campos.";
            },
            enabled: widget.quoteEdit,
            controller: unitDetailPageController.startMoney,
            label: "Enganche",
            hintText: "Enganche",
            keyboardType: TextInputType.number,
            prefixIcon: Icons.person_outline),
        CustomInputWidget(
            onChange: (value) {
              if (value.isEmpty) return;
              final termMonths = int.tryParse(value);
              if (termMonths! > 12) {
                setState(() {
                  unitDetailPageController.isPayedTotal = false;
                });
              }
            },
            validator: (value) {
              final isValidMinMonths = graterThanNumberValidator(value, 1);
              final isValidMaxMonths = lowerThanNumberValidator(value, 240);
              if (!isValidMinMonths) return '${Strings.termInMonthsMin} 0';
              if (isValidMaxMonths) return null;
              return '${Strings.termInMonthsMax} 240';
            },
            enabled: widget.quoteEdit,
            controller: unitDetailPageController.paymentMonths,
            label: "Plazo en meses",
            hintText: "Plazo en meses",
            keyboardType: TextInputType.number,
            prefixIcon: Icons.person_outline),
        CustomInputWidget(
            enabled: false,
            controller: unitDetailPageController.balanceToFinance,
            label: "Saldo a financiar",
            hintText: "Saldo a financiar",
            prefixIcon: Icons.monetization_on),
        SwitchListTile(
          title: const Text('Precio al contado',
              style: TextStyle(color: Colors.black)),
          value: unitDetailPageController.isPayedTotal,
          onChanged: (bool value) {
            if (unitDetailPageController.paymentMonths.text.isEmpty) {
              EasyLoading.showInfo(Strings.termOfMonthsMin);
              return;
            }
            final termMonths =
                int.tryParse(unitDetailPageController.paymentMonths.text)!;

            if (termMonths <= 12) {
              setState(() {
                unitDetailPageController.isPayedTotal = value;
              });
            } else {
              EasyLoading.showInfo(Strings.termOfMonthsMin);
            }
          },
          activeColor: AppColors.secondaryMainColor,
        ),
        const SizedBox(height: Dimensions.heightSize),
      ],
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
