// import "dart:convert";

import "package:developer_company/data/implementations/unit_quotation_repository_impl.dart";
import "package:developer_company/data/models/unit_quotation_model.dart";

import "package:developer_company/data/providers/unit_quotation_provider.dart";

import "package:developer_company/data/repositories/unit_quotation_repository.dart";
import "package:developer_company/shared/resources/colors.dart";

import "package:developer_company/shared/resources/dimensions.dart";
import "package:developer_company/shared/resources/strings.dart";
import "package:developer_company/shared/utils/http_adapter.dart";
import "package:developer_company/shared/validations/not_empty.dart";
import "package:developer_company/views/bank_executive/pages/form_detail_client.dart";
import "package:developer_company/views/credit_request/helpers/handle_balance_to_finance.dart";
import 'package:developer_company/views/credit_request/forms/form_quote.dart';
import "package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart";
import "package:developer_company/widgets/app_bar_title.dart";
import "package:developer_company/widgets/custom_button_widget.dart";
import "package:developer_company/widgets/custom_card.dart";
import "package:developer_company/widgets/custom_input_widget.dart";
import "package:developer_company/widgets/layout.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:get/get.dart";

class AnalystDetailCreditClient extends StatefulWidget {
  const AnalystDetailCreditClient({Key? key}) : super(key: key);

  @override
  _AnalystDetailCreditClientState createState() =>
      _AnalystDetailCreditClientState();
}

class _AnalystDetailCreditClientState extends State<AnalystDetailCreditClient> {
  Quotation? quoteInfo;

  UnitDetailPageController unitDetailPageController =
      Get.put(UnitDetailPageController());

  final UnitQuotationRepository unitQuotationRepository =
      UnitQuotationRepositoryImpl(UnitQuotationProvider());

  final Map<String, dynamic> arguments = Get.arguments;

  bool hideButtons = false;

  String? parsedQuoteId;

  Future<void> start() async {
    final quoteId = arguments["quoteId"];
    bool approveStatus = arguments["statusId"].toString() == "6";
    bool rejectStatus = arguments["statusId"].toString() == "7";

    if (approveStatus || rejectStatus) {
      setState(() {
        hideButtons = true;
      });
    }

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
        appBar:
            const CustomAppBarTitle(title: "Detalle de aplicación a crédito"),
        child: SizedBox(
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
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
                      color: Colors.white,
                      onTap: () => _showCreditDialog(context),
                      child: Container(
                        width: (Get.width),
                        height: 100,
                        alignment: Alignment.center,
                        child: const Text(
                          "Aplicación a crédito",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
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
                                  text: "Aprobar",
                                  onTap: () => _showModalApprove(context))),
                          Expanded(
                              child: CustomButtonWidget(
                                  text: "Rechazar",
                                  onTap: () => _showModalReject(context)))
                        ],
                      ),
                    )
            ],
          ),
        ));
  }

  _showModalApprove(BuildContext context) {
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
                    const Text("¿Desea Aprobar Este crédito?",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Dimensions.extraLargeTextSize,
                          overflow: TextOverflow.ellipsis,
                        )),
                    Row(
                      children: [
                        Expanded(
                            child: CustomButtonWidget(
                                color: AppColors.blueColor,
                                text: "Aprobar",
                                onTap: () async {
                                  final body = {
                                    "idEstado": "7",
                                    "comentario": "null",
                                  };
                                  await httpAdapter.putApi(
                                      "orders/v1/cotizacionUpdEstado/$parsedQuoteId",
                                      body, {});

                                  setState(() {
                                    hideButtons = true;
                                  });

                                  EasyLoading.showSuccess(
                                      "Crédito Aprobado con éxito.");
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

  _showModalReject(BuildContext context) {
    TextEditingController commentController = TextEditingController();
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
                        const Text("¿Desea Rechazar Este crédito?",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Dimensions.extraLargeTextSize,
                              overflow: TextOverflow.ellipsis,
                            )),
                        CustomInputWidget(
                            controller: commentController,
                            validator: (value) => notEmptyFieldValidator(value),
                            label: "Comentarios",
                            hintText: "Agregue un comentario",
                            prefixIcon: Icons.comment),
                        Row(
                          children: [
                            Expanded(
                                child: CustomButtonWidget(
                                    color: AppColors.redColor,
                                    text: "Rechazar",
                                    onTap: () async {
                                      if (_formKeyComments.currentState!
                                          .validate()) {
                                        final body = {
                                          "idEstado": "6",
                                          "comentario": commentController.text,
                                        };
                                        await httpAdapter.putApi(
                                            "orders/v1/cotizacionUpdEstado/$parsedQuoteId",
                                            body, {});
                                        EasyLoading.showSuccess(
                                            "Crédito Rechazado con éxito.");

                                        setState(() {
                                          hideButtons = true;
                                        });
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

  _showCreditDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((BuildContext context) {
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
                    FormDetailClient(
                      loanApplicationId: parsedQuoteId,
                      updateEditMode: (p1, p2) {},
                      isEditMode: false,
                    ),
                    CustomButtonWidget(
                        text: "Cerrar",
                        onTap: () => Navigator.of(context).pop())
                  ],
                ),
              ),
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
                      salePrice: "120000",
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
