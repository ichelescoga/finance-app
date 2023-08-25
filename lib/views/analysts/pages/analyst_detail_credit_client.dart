import "package:developer_company/data/implementations/unit_quotation_repository_impl.dart";
import "package:developer_company/data/models/unit_quotation_model.dart";

import "package:developer_company/data/providers/unit_quotation_provider.dart";

import "package:developer_company/data/repositories/unit_quotation_repository.dart";
import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/resources/dimensions.dart";
import "package:developer_company/shared/resources/strings.dart";
import "package:developer_company/views/bank_executive/pages/form_detail_client.dart";
import "package:developer_company/views/credit_request/pages/form_quote.dart";
import "package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart";
import "package:developer_company/widgets/app_bar_title.dart";
import "package:developer_company/widgets/custom_button_widget.dart";
import "package:developer_company/widgets/custom_card.dart";
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

  Future<void> start() async {
    final quoteId = "1";

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
      }

      unitDetailPageController.unit.text =
          "Casa Blanca"; // arguments["unitName"];
      unitDetailPageController.salePrice.text = "350000";
      unitDetailPageController.finalSellPrice.text =
          "350000"; //arguments["finalSellPrice"].toString();
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
        appBar:
            const CustomAppBarTitle(title: "Detalle de Aplicación A Crédito"),
        child: Column(
          children: [
            CustomCard(
                onTap: () => _showQuoteDialog(context),
                child: Container(
                  width: (Get.width),
                  height: 100,
                  alignment: Alignment.center,
                  child: const Text(
                    "Cotización",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            CustomCard(
                onTap: () => _showCreditDialog(context),
                child: Container(
                  width: (Get.width),
                  height: 100,
                  alignment: Alignment.center,
                  child: const Text(
                    "Aplicación a crédito",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            Row(
              children: [
                Expanded(
                    child: CustomButtonWidget(text: "Aprobar", onTap: () {})),
                Expanded(
                    child: CustomButtonWidget(text: "Rechazar", onTap: () {}))
              ],
            ),
            const SizedBox(height: Dimensions.buttonHeight),
          ],
        ));
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
                      loanApplicationId: "7",
                      updateEditMode: (p0, p1, p2) {},
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
