import 'package:developer_company/data/implementations/discount_repository_impl.dart';
import 'package:developer_company/data/implementations/improve_client_contact_repository_impl.dart';
import 'package:developer_company/data/models/client_model.dart';
import 'package:developer_company/data/models/unit_quotation_model.dart';
import 'package:developer_company/data/providers/discount_provider.dart';
import 'package:developer_company/data/providers/improve_client_contact_provider.dart';
import 'package:developer_company/data/repositories/discount_repository.dart';
import 'package:developer_company/data/repositories/improve_client_contact_repository.dart';
// import 'package:developer_company/global_state/providers/client_provider_state.dart';
import 'package:developer_company/global_state/providers/user_provider_state.dart';
import 'package:developer_company/main.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/shared/services/quetzales_currency.dart';
import 'package:developer_company/shared/utils/discount_status_text.dart';
import 'package:developer_company/shared/validations/email_validator.dart';
import 'package:developer_company/shared/validations/grater_than_number_validator.dart';
import 'package:developer_company/shared/validations/lower_than_number_validator%20copy.dart';
import 'package:developer_company/shared/validations/not_empty.dart';
import 'package:developer_company/shared/validations/string_length_validator.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/views/credit_request/helpers/calculate_sell_price_discount.dart';
import 'package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart';
import 'package:developer_company/widgets/autocomplete_dropdown.dart';
import 'package:developer_company/widgets/custom_input_widget.dart';
import 'package:developer_company/widgets/elevated_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class FormQuote extends StatefulWidget {
  final bool quoteEdit;
  final bool canEditDiscount;
  final String salePrice;
  final bool isEditing;

  const FormQuote({
    Key? key,
    this.quoteEdit = true,
    required this.salePrice,
    this.canEditDiscount = false,
    this.isEditing = true,
  }) : super(key: key);

  @override
  _FormQuoteState createState() => _FormQuoteState();
}

class _FormQuoteState extends State<FormQuote> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UnitDetailPageController unitDetailPageController =
      Get.put(UnitDetailPageController());

  final user = container.read(userProvider);

  DiscountRepository _discountRepository =
      DiscountRepositoryImpl(DiscountProvider());

  ImproveClientContactRepository contactClientRepository =
      ImproveClientContactRepositoryImpl(ImproveClientContactProvider());

  // bool _canEditDiscount = false;
  int? quoteId;

  Quotation? quoteInfo;
  bool isFetchQuote = false;
  List<ClientModel> dropdownClients = [];
  List<DropDownOption> clientOptions = []; //! use as temp dropdown.

  retrieveDefaultDiscount() async {
    final projectId = user.project.projectId;
    final _defaultDiscountData =
        await _discountRepository.getSeasonDiscount(projectId);
    unitDetailPageController.seasonDiscount.text =
        _defaultDiscountData.percentage;
  }

  Future<List<DropDownOption>> _handleSearchClients(String text) async {
    if (text.length < 1) return clientOptions;

    List<ClientModel> clients =
        await contactClientRepository.getClientsByKeyword(text, text);
    List<DropDownOption> newClientOptions = clients
        .map((client) =>
            DropDownOption(id: client.id.toString(), label: client.name!))
        .toList();

    dropdownClients = clients;
    clientOptions = newClientOptions;

    return newClientOptions;
  }

  @override
  void initState() {
    super.initState();
    retrieveDefaultDiscount();
  }

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
        SwitchListTile(
          title: const Text('Aplicar Descuento',
              style: TextStyle(color: Colors.black)),
          value: unitDetailPageController.applyDefaultDiscount,
          onChanged: (bool value) {
            if (!widget.quoteEdit) return;
            if (value) {
              unitDetailPageController.finalSellPrice.text =
                  calculateSellPriceDiscount(
                      unitDetailPageController.seasonDiscount.text,
                      unitDetailPageController,
                      unitDetailPageController.salePrice.text);
            } else {
              unitDetailPageController.finalSellPrice.text =
                  unitDetailPageController.salePrice.text;
            }

            setState(
                () => unitDetailPageController.applyDefaultDiscount = value);
          },
          activeColor: AppColors.secondaryMainColor,
        ),
        if (unitDetailPageController.applyDefaultDiscount)
          Column(
            children: [
              CustomInputWidget(
                  enabled: false,
                  controller: unitDetailPageController.seasonDiscount,
                  label: "Descuento de temporada",
                  hintText: "Descuento de temporada",
                  prefixIcon: Icons.percent),
              if (unitDetailPageController.statusDiscount != null ||
                  !widget.quoteEdit)
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      getTextStatusDiscount(
                          unitDetailPageController.statusDiscount,
                          unitDetailPageController.resolutionDiscount,
                          unitDetailPageController.extraDiscount.text),
                    )),
              CustomInputWidget(
                  enabled: (widget.quoteEdit &&
                      !isApprovedDiscount(
                          unitDetailPageController.statusDiscount,
                          unitDetailPageController.resolutionDiscount)),
                  controller: unitDetailPageController.extraDiscount,
                  label: "Solicitar descuento extra",
                  hintText: "Solicitar descuento extra",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null) return "Ingrese un numero valido";
                    if (double.tryParse(value) == null)
                      return "Numero no valido";

                    if (int.tryParse(value) != null &&
                        int.tryParse(value)! >= 100) {
                      return "El porcentaje de descuento no puede ser mayor o igual a 100";
                    }

                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(Icons.question_mark_outlined),
                    onPressed: () => _showInfoExtraDiscount(context),
                  ),
                  prefixIcon: Icons.percent),
            ],
          ),
        CustomInputWidget(
            validator: (value) => notEmptyFieldValidator(value),
            enabled: false,
            controller: unitDetailPageController.finalSellPrice,
            label: "Precio con descuento",
            hintText: "Precio con descuento",
            prefixIcon: Icons.person_outline),
        if (!widget.isEditing)
          AutocompleteDropdownWidget(
              listItems: [],
              onSelected: (selected) {
                final selectedClientDropdown = dropdownClients.firstWhere(
                    (element) => element.id == int.parse(selected.id));
                unitDetailPageController
                    .updateClientInfo(selectedClientDropdown);
              },
              label: "Búsqueda de clientes",
              hintText: "Escriba para buscar",
              onFocusChange: (p0) {},
              onTextChange: (value) async {
                return Future.delayed(
                    Duration(seconds: 1), () => _handleSearchClients(value));
              }),
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
            if (!widget.quoteEdit) return;
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

  _showInfoExtraDiscount(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.officialWhite,
            title: Text("Solicitud de descuento"),
            content: Text(
              "Es un porcentaje descuento enviado a un analista para su revisión y resolución, la cual se reflejará en este apartado y en el campo de precio con descuento",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              ElevatedCustomButton(
                color: AppColors.secondaryMainColor,
                text: "Entendido",
                isLoading: false,
                onPress: () => Navigator.pop(context, false),
              )
            ],
          );
        });
  }
}
