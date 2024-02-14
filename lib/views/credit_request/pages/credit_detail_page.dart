import "dart:convert";

import "package:developer_company/data/implementations/sell_repository_impl.dart";
import "package:developer_company/data/implementations/unit_quotation_repository_impl.dart";
import "package:developer_company/data/models/sell_models.dart";
import "package:developer_company/data/models/unit_quotation_model.dart";
import "package:developer_company/data/providers/sell_provider.dart";
import "package:developer_company/data/providers/unit_quotation_provider.dart";
import "package:developer_company/data/repositories/sell_repository.dart";
import "package:developer_company/data/repositories/unit_quotation_repository.dart";
import "package:developer_company/global_state/providers/user_provider_state.dart";
import "package:developer_company/main.dart";
import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/resources/dimensions.dart";
import "package:developer_company/shared/resources/strings.dart";
import "package:developer_company/shared/routes/router_paths.dart";
import "package:developer_company/shared/services/quetzales_currency.dart";
import "package:developer_company/shared/utils/http_adapter.dart";
import "package:developer_company/views/bank_executive/pages/form_detail_client.dart";
import "package:developer_company/views/credit_request/helpers/handle_balance_to_finance.dart";
import 'package:developer_company/views/credit_request/forms/form_quote.dart';
import "package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart";
import "package:developer_company/widgets/CustomTwoPartsCard.dart";
import "package:developer_company/widgets/app_bar_title.dart";
import "package:developer_company/widgets/custom_button_widget.dart";
import "package:developer_company/widgets/dialog_accept_sell.dart";
import "package:developer_company/widgets/layout.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:get/get.dart";

class CreditDetailPage extends StatefulWidget {
  const CreditDetailPage({Key? key}) : super(key: key);

  @override
  _CreditDetailPageState createState() => _CreditDetailPageState();
}

class _CreditDetailPageState extends State<CreditDetailPage> {
  Quotation? quoteInfo;

  UnitDetailPageController unitDetailPageController =
      Get.put(UnitDetailPageController());

  final UnitQuotationRepository unitQuotationRepository =
      UnitQuotationRepositoryImpl(UnitQuotationProvider());

  final SellRepository sellRepository = SellRepositoryImpl(SellProvider());

  final Map<String, dynamic> arguments = Get.arguments;

  bool hideButtons = false;
  bool isLoadingModal = false;
  final user = container.read(userProvider);

  String? parsedQuoteId;
  String extraDataModalBook = "";
  String extraDataModalDownPayment = "";
  StatusOfPayments statusOfPayments =
      StatusOfPayments(book: false, downPayment: false, monetaryFee: false);

  String defaultInterest = "7";

  retrieveInterest() async {
    HttpAdapter http = HttpAdapter();
    final projectId = user.project.projectId;

    dynamic interestResponse =
        await http.getApi("orders/v1/detallePorcentajeInteres/${projectId}", {});
    final List<dynamic> jsonResponse = jsonDecode(interestResponse.body);
    if (jsonResponse.length > 0) {
      if (int.tryParse(jsonResponse[0]["Porcentaje"]) == null) {
        return EasyLoading.showInfo("INTERÉS NO CONFIGURADO, 7",
            duration: Duration(seconds: 70));
      }
      defaultInterest = jsonResponse[0]["Porcentaje"].toString();
    } else {
      return EasyLoading.showInfo("INTERÉS NO CONFIGURADO, 7",
          duration: Duration(seconds: 70));
    }
  }

  Future<void> start() async {
    EasyLoading.show();
    final quoteId = arguments["quoteId"];
    bool approveStatus =
        arguments["statusId"].toString() == "5"; //unitStatus unit_status

    BookModel responseBook =
        await sellRepository.getBookModel(arguments["quoteId"]);
    MonetaryDownPayment responseDownPayment =
        await sellRepository.getMonetaryDownPayment(arguments["quoteId"]);
    statusOfPayments =
        await sellRepository.getStatusOfPayments(arguments["quoteId"]);

    extraDataModalBook = quetzalesCurrency(responseBook.moneyBook);
    extraDataModalDownPayment =
        quetzalesCurrency(responseDownPayment.downPayment);
    await retrieveInterest();
    setState(() => {});

    if (approveStatus) {
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

  formalizeSell() {
    Get.toNamed(RouterPaths.CREDIT_RESOLUTION_DETAIL_PAGE, arguments: {
      "quoteId": parsedQuoteId,
      "statusId": arguments["statusId"]
    });
  }

  doBookSell() async {
    setState(() {
      isLoadingModal = true;
    });
    statusOfPayments.book =
        await sellRepository.postBookModel(arguments["quoteId"]);
    hideButtons = true;
    setState(() {
      isLoadingModal = false;
    });
  }

  doMonetaryDownSell() async {
    setState(() {
      isLoadingModal = true;
    });
    setState(() {
      isLoadingModal = true;
    });
    statusOfPayments.downPayment =
        await sellRepository.postMonetaryDownPayment(arguments["quoteId"]);
    hideButtons = true;
    setState(() {
      isLoadingModal = false;
    });
  }

  doFirstMonetaryFee() async {
    setState(() {
      isLoadingModal = true;
    });

    statusOfPayments.monetaryFee = await sellRepository.postMonetaryFee(
        arguments["quoteId"], defaultInterest);
    hideButtons = true;
    setState(() {
      isLoadingModal = false;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      start();
    });
  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss();
  }

  HttpAdapter httpAdapter = HttpAdapter();

  @override
  Widget build(BuildContext context) {
    return Layout(
        useScroll: false,
        onBackFunction: () {
          Get.back(closeOverlays: true, result: hideButtons);
        },
        sideBarList: const [],
        appBar:
            const CustomAppBarTitle(title: "Detalle de aplicación a crédito"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () => _showCreditDialog(context),
                  child: CustomTwoPartsCard(
                      height: 80,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.person),
                          SizedBox(width: 10),
                          Text(
                            'Aplicación a crédito',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      bodyText: "Datos personales del cliente."),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _showQuoteDialog(context),
                  child: CustomTwoPartsCard(
                      height: 80,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.document_scanner),
                          SizedBox(width: 10),
                          Text(
                            'Cotización',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      bodyText:
                          "Describe el precio de la unidad y datos básicos."),
                ),
              ],
            ),
            Column(
              children: [
                if (statusOfPayments.monetaryFee)
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (p0) => {},
                      ),
                      Text("Compra")
                    ],
                  ),
                if (statusOfPayments.downPayment)
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (p0) => {},
                      ),
                      Text("Enganche ${extraDataModalDownPayment}")
                    ],
                  ),
                if (statusOfPayments.book)
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (p0) => {},
                      ),
                      Text("Reserva ${extraDataModalBook}")
                    ],
                  ),
              ],
            ),
            Column(children: [
              if (!statusOfPayments.monetaryFee)
                Column(
                  children: [
                    CustomButtonWidget(
                        color: AppColors.softMainColor,
                        text: "Compra",
                        onTap: () {
                          _showModalSell(
                              context,
                              "Solicitud de compra",
                              "la compra",
                              () async => doFirstMonetaryFee(),
                              isLoadingModal,
                              "");
                        }),
                    SizedBox(height: 10),
                  ],
                ),
              if (!statusOfPayments.downPayment)
                Column(
                  children: [
                    CustomButtonWidget(
                        color: AppColors.softMainColor,
                        text: "Enganche",
                        onTap: () {
                          _showModalSell(
                              context,
                              "Solicitud de enganche",
                              "el enganche",
                              () => doMonetaryDownSell(),
                              isLoadingModal,
                              extraDataModalDownPayment);
                        }),
                    SizedBox(height: 10),
                  ],
                ),
              if (!statusOfPayments.book)
                Column(
                  children: [
                    CustomButtonWidget(
                        color: AppColors.softMainColor,
                        text: "Reserva",
                        onTap: () {
                          _showModalSell(
                              context,
                              "Solicitud de reserva",
                              "reserva",
                              () => doBookSell(),
                              isLoadingModal,
                              extraDataModalBook);
                        }),
                    SizedBox(height: 10),
                  ],
                ),
                CustomButtonWidget(
                    color: AppColors.softMainColor,
                    text: "Formalizar Venta",
                    onTap: () => formalizeSell()),
              SizedBox(height: 10),
              CustomButtonWidget(
                  text: Strings.backToPreviousScreen,
                  onTap: () =>
                      Get.back(closeOverlays: true, result: hideButtons)),
            ]),
          ],
        ));
  }

  _showModalSell(BuildContext context, String title, String text,
      Function() onPress, bool isLoading, String extraData) {
    showDialog(
      context: context,
      builder: (context) {
        return PopScope(
          child: DialogAcceptSell(
              extraData: extraData,
              onPressAccept: () async {
                await onPress();
                Navigator.pop(context, false);
              },
              isLoading: isLoading,
              title: title,
              text: "¿Esta seguro de aplicar ${text}?"),
        );
      },
    );
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
