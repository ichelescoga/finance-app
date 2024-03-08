import 'package:developer_company/data/implementations/loan_simulation_repository_impl.dart';
import 'package:developer_company/data/implementations/unit_quotation_repository_impl.dart';
import 'package:developer_company/data/models/unit_quotation_model.dart';
import 'package:developer_company/data/providers/loan_simulation_provider.dart';
import 'package:developer_company/data/providers/unit_quotation_provider.dart';
import 'package:developer_company/data/repositories/loan_simulation_repository.dart';
import 'package:developer_company/data/repositories/unit_quotation_repository.dart';

import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/shared/services/quetzales_currency.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';
import 'package:developer_company/shared/validations/grater_than_number_validator.dart';
import 'package:developer_company/shared/validations/lower_than_number_validator%20copy.dart';
import 'package:developer_company/shared/validations/not_empty.dart';

import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/views/express_request/controller/express_quote_detail_controller.dart';
import 'package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart';
import 'package:developer_company/widgets/app_bar_two_images.dart';
import 'package:developer_company/widgets/custom_button_widget.dart';
import 'package:developer_company/widgets/custom_input_widget.dart';

import 'package:developer_company/widgets/layout.dart';
import 'package:developer_company/widgets/share_quote_action_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get/get.dart';

class ExpressQuoteDetailPage extends ConsumerStatefulWidget {
  const ExpressQuoteDetailPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ExpressQuoteDetailPage> createState() =>
      _UnitQuoteDetailPageState();
}

class _UnitQuoteDetailPageState extends ConsumerState<ExpressQuoteDetailPage> {
  final Map args = Get.arguments;
  final httpAdapter = HttpAdapter();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late ExpressQuoteDetailController controller;

  UnitDetailPageController unitDetailPageController =
      Get.put(UnitDetailPageController());

  int? projectId;
  Quotation? quoteInfo;
  bool isFetchQuote = false;

  final UnitQuotationRepository unitQuotationRepository =
      UnitQuotationRepositoryImpl(UnitQuotationProvider());

  LoanSimulationRepository loanSimulationRepository =
      LoanSimulationRepositoryImpl(LoanSimulationProvider());

  final Map<String, dynamic> arguments = Get.arguments;

  void _handleSubmitForm() {
    if (_formKey.currentState!.validate()) {
      EasyLoading.showToast(Strings.loading);
      final anualPayments =
          double.tryParse(unitDetailPageController.paymentMonths.text)! / 12;
      double creditValue = double.tryParse(
          extractNumber(unitDetailPageController.finalSellPrice.text)!)!;
      controller.getSimulation(anualPayments, creditValue);
    }
  }

  Future<void> start() async {
    projectId = args['projectId'];
    print(args);
    try {
      if (projectId != null) {
        quoteInfo = await unitQuotationRepository
            .fetchQuotationById(projectId.toString());
        controller.unitController.text = args['unitName'];
        controller.priceController.text =
            quetzalesCurrency(args['salePrice'].toString());
      } else {
        print("args: ");
      }
    } catch (error) {}
  }

  @override
  void initState() {
    super.initState();
    controller =
        Get.put(ExpressQuoteDetailController(projectId ?? 0, arguments));
    start();
  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      sideBarList: const [],
      actionButton: projectId != null
          ? ShareQuoteActionButtons(quoteId: projectId.toString())
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
            CustomInputWidget(
              controller: controller.unitController,
              label: "Unidad",
              hintText: "",
              prefixIcon: Icons.maps_home_work,
              enabled: false,
            ),
            CustomInputWidget(
              controller: controller.priceController,
              label: "Precio de venta",
              hintText: "",
              prefixIcon: Icons.monetization_on,
              enabled: false,
              onFocusChangeInput: (hasFocus) {
                if (!hasFocus) {
                  controller.priceController.text =
                      quetzalesCurrency(controller.priceController.text);
                }
              },
            ),
            CustomInputWidget(
                onFocusChangeInput: (hasFocus) {
                  if (!hasFocus) {
                    controller.startMoney.text =
                        quetzalesCurrency(controller.startMoney.text);
                  }
                },
                onChange: (String value) {
                  double finalSellPrice = (double.parse(
                          extractNumber(controller.priceController.text) ??
                              "0") -
                      double.parse(value));
                  controller.finalSellPrice.text =
                      quetzalesCurrency(finalSellPrice.toString());
                  setState(() {});
                },
                validator: (value) {
                  final enganche = extractNumber(value!);
                  if (enganche == null) {
                    return "Verifique que el valor sea correcto";
                  }

                  final isValidMinMonths =
                      graterThanNumberValidator(enganche, 1);
                  final finalSellPrice =
                      extractNumber(controller.finalSellPrice.text);

                  if (finalSellPrice != null) {
                    double priceWithDiscount = double.parse(finalSellPrice);
                    final isValidMaxMonths =
                        double.parse(enganche) <= priceWithDiscount;

                    if (!isValidMinMonths)
                      return 'El Enganche debe ser mayor 0';
                    if (isValidMaxMonths) return null;
                    return 'El Enganche debe ser menor a ${controller.finalSellPrice.text}';
                  }
                  return "Algo salio mal valide campos.";
                },
                controller: controller.startMoney,
                label: "Enganche",
                hintText: "Enganche",
                keyboardType: TextInputType.number,
                prefixIcon: Icons.monetization_on),
            CustomInputWidget(
                onChange: (value) {
                  if (value.isEmpty) return;
                  final termMonths = int.tryParse(value);
                  unitDetailPageController.paymentMonths.text = value;
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
                controller: controller.quoteController,
                label: "Plazo en meses",
                hintText: "Plazo en meses",
                keyboardType: TextInputType.number,
                prefixIcon: Icons.calendar_month),
            CustomInputWidget(
              enabled: false,
              controller: controller.finalSellPrice,
              label: "Saldo a financiar",
              hintText: "Saldo a financiar",
              prefixIcon: Icons.monetization_on,
            ),
            CustomInputWidget(
              controller: controller.nameController,
              label: "Nombre",
              hintText: "Tu nombre",
              prefixIcon: Icons.person,
              validator: (value) {
                return notEmptyFieldValidator(value);
              },
            ),
            Column(
              children: <Widget>[
                CustomButtonWidget(
                  text: "Descargar cotización",
                  onTap: () => controller.openShareFile(),
                ),
                const SizedBox(height: Dimensions.heightSize),
                CustomButtonWidget(
                  text: "Programación de pagos",
                  onTap: _handleSubmitForm,
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
