import 'package:developer_company/data/implementations/discount_repository_impl.dart';
import 'package:developer_company/data/implementations/unit_quotation_repository_impl.dart';
import 'package:developer_company/data/models/unit_quotation_model.dart';
import 'package:developer_company/data/providers/discount_provider.dart';
import 'package:developer_company/data/providers/unit_quotation_provider.dart';
import 'package:developer_company/data/repositories/discount_repository.dart';
import 'package:developer_company/data/repositories/unit_quotation_repository.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/shared/utils/discount_status_text.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';
import 'package:developer_company/views/credit_request/forms/form_quote.dart';
import 'package:developer_company/views/credit_request/helpers/handle_balance_to_finance.dart';
import 'package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart';
// import 'package:developer_company/widgets/app_bar_sidebar.dart';
import 'package:developer_company/widgets/app_bar_title.dart';
import 'package:developer_company/widgets/custom_button_widget.dart';
import 'package:developer_company/widgets/custom_card.dart';
import 'package:developer_company/widgets/custom_input_widget.dart';
// import 'package:developer_company/widgets/data_table.dart';
// import 'package:developer_company/widgets/filter_box.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class DiscountDetailByQuotePage extends StatefulWidget {
  const DiscountDetailByQuotePage({Key? key}) : super(key: key);

  @override
  _DiscountDetailByQuotePageState createState() =>
      _DiscountDetailByQuotePageState();
}

class _DiscountDetailByQuotePageState extends State<DiscountDetailByQuotePage> {
  Quotation? quoteInfo;

  UnitDetailPageController unitDetailPageController =
      Get.put(UnitDetailPageController());
  bool isLoading = false;

  final UnitQuotationRepository unitQuotationRepository =
      UnitQuotationRepositoryImpl(UnitQuotationProvider());

  final DiscountRepository discountRepository =
      DiscountRepositoryImpl(DiscountProvider());

  final Map<String, dynamic> arguments = Get.arguments;

  bool hideButtons = false;

  String? parsedQuoteId;

  Future<void> start() async {
    final quoteId = arguments["quoteId"];

    try {
      EasyLoading.show(status: Strings.loading);
      if (quoteId == null) return;
      parsedQuoteId = quoteId.toString();
      quoteInfo =
          await unitQuotationRepository.fetchQuotationById(quoteId.toString());

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

      unitDetailPageController.unit.text = arguments["unitName"];
      unitDetailPageController.salePrice.text = arguments["sellPrice"];
      unitDetailPageController.finalSellPrice.text = arguments["finalPrice"];
      unitDetailPageController.isPayedTotal =
          quoteInfo?.cashPrice == 1 ? true : false;

      final startMoney = quoteInfo?.downPayment;
      unitDetailPageController.balanceToFinance.text =
          handleBalanceToFinance(arguments["finalPrice"], startMoney!);

      setState(() {
        hideButtons = quoteInfo?.resolutionDiscount == "1";
      });
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

  HttpAdapter httpAdapter = HttpAdapter();

  @override
  Widget build(BuildContext context) {
    return Layout(
        onBackFunction: () {
          Get.back(closeOverlays: true, result: hideButtons);
        },
        sideBarList: const [],
        appBar: const CustomAppBarTitle(title: "Detalle del descuento"),
        child: SizedBox(
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "Estado del ${getTextStatusDiscount(unitDetailPageController.statusDiscount, unitDetailPageController.resolutionDiscount, unitDetailPageController.extraDiscount.text)}",
                    style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w800,
                        fontSize: Dimensions.extraLargeTextSize),
                  ),
                  CustomCard(
                      color: Colors.white,
                      onTap: () => _showQuoteDialog(context),
                      child: Container(
                        width: (Get.width),
                        height: 100,
                        alignment: Alignment.center,
                        child: const Text(
                          "Cotización",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                  CustomCard(
                    onTap: () {},
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(children: [
                        CustomInputWidget(
                            enabled: false,
                            controller: unitDetailPageController.unit,
                            label: "Unidad",
                            hintText: "Unidad",
                            prefixIcon: Icons.person_outline),
                        CustomInputWidget(
                            enabled: false,
                            controller: unitDetailPageController.clientName,
                            label: "Cliente",
                            hintText: "Cliente",
                            prefixIcon: Icons.person_outline),
                        CustomInputWidget(
                            enabled: (isApprovedDiscount(
                                unitDetailPageController.statusDiscount,
                                unitDetailPageController.resolutionDiscount)),
                            controller: unitDetailPageController.extraDiscount,
                            label: "Descuento solicitado",
                            hintText: "Descuento solicitado",
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (int.tryParse(value!) == null) {
                                return "El porcentaje no es valido";
                              }

                              if (int.tryParse(value)! >= 100) {
                                return "El porcentaje de descuento no puede ser mayor o igual a 100";
                              }

                              return null;
                            },
                            prefixIcon: Icons.percent),
                      ]),
                    ),
                  )
                ],
              ),
              hideButtons
                  ? CustomButtonWidget(
                      text: "Regresar",
                      onTap: () =>
                          Get.back(closeOverlays: true, result: hideButtons))
                  : SizedBox(
                      height: Get.height / 6,
                      child: Row(
                        children: [
                          Expanded(
                              child: CustomButtonWidget(
                                  isLoading: isLoading,
                                  text: "Aprobar",
                                  onTap: () async {
                                    _showModalResolution(context, true);
                                  })),
                          Expanded(
                              child: CustomButtonWidget(
                                  color: AppColors.redColor,
                                  isLoading: isLoading,
                                  text: "Rechazar",
                                  onTap: () async {
                                    _showModalResolution(context, false);
                                  }))
                        ],
                      ),
                    )
            ],
          ),
        ));
  }

  _showModalResolution(BuildContext context, bool isApproving) {
    return showDialog(
        context: context,
        builder: ((BuildContext context) {
          return Center(
            child: Container(
              color: Colors.white,
              height: Get.height / 4,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                        "¿Desea ${isApproving ? "aprobar" : "rechazar"} este descuento?",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Dimensions.extraLargeTextSize,
                          overflow: TextOverflow.ellipsis,
                        )),
                    Row(
                      children: [
                        Expanded(
                            child: CustomButtonWidget(
                                color: isApproving
                                    ? AppColors.blueColor
                                    : AppColors.redColor,
                                text: isApproving ? "Aprobar" : "Rechazar",
                                onTap: () async {
                                  try {
                                    setState(() => isLoading = true);
                                    if (isApproving) {
                                      await discountRepository.acceptDiscount(
                                          arguments["quoteId"].toString());
                                    } else {
                                      await discountRepository.rejectDiscount(
                                          arguments["quoteId"].toString());
                                    }
                                    setState(() {
                                      unitDetailPageController
                                              .resolutionDiscount =
                                          isApproving ? "1" : "0";
                                      hideButtons = true;
                                    });
                                  } finally {
                                    setState(() => isLoading = false);
                                  }

                                  EasyLoading.showSuccess(
                                      "Descuento ${isApproving ? "aprobado" : "rechazado"}");
                                  Navigator.of(context).pop();
                                })),
                        Expanded(
                            child: CustomButtonWidget(
                                text: "Regresar",
                                onTap: () => Navigator.of(context).pop()))
                      ],
                    )
                  ]),
            ),
          );
        }));
  }

  _showQuoteDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Text(
                      "Información de la cotización",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w800,
                          fontSize: Dimensions.extraLargeTextSize),
                    ),
                    const FormQuote(
                      salePrice: "",
                      quoteEdit: false,
                    ),
                    CustomButtonWidget(
                        text: "Cerrar",
                        onTap: () => Navigator.of(context).pop())
                  ],
                ),
              ),
            ),
          );
        });
  }
}
