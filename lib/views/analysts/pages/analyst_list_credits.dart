import "package:developer_company/data/implementations/analyst_repository_impl.dart";
import "package:developer_company/data/models/analyst_model.dart";
import "package:developer_company/data/providers/analyst_provider.dart";
import "package:developer_company/data/repositories/analyst_repository.dart";
import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/routes/router_paths.dart";
import "package:developer_company/shared/utils/unit_status.dart";
import "package:developer_company/widgets/app_bar_title.dart";
import "package:developer_company/widgets/data_table.dart";
import "package:developer_company/widgets/layout.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:get/get.dart";

// class Simulation {
//   final String client;
//   final String unit;
//   final double sellPrice;
//   final double priceToPay;
//   final String executive;

//   Simulation({
//     required this.client,
//     required this.unit,
//     required this.sellPrice,
//     required this.priceToPay,
//     required this.executive,
//   });
// } //! TEMP REMOVE WHEN DATA REAL PLEASE

class AnalystListCredits extends StatefulWidget {
  const AnalystListCredits({Key? key}) : super(key: key);

  @override
  _AnalystListCreditsState createState() => _AnalystListCreditsState();
}

class _AnalystListCreditsState extends State<AnalystListCredits> {
  final appColors = AppColors();
  final _scrollController = ScrollController();

  final AnalystRepository analystRepository =
      AnalystRepositoryImpl(AnalystProvider());

  void _onRowTap(AnalystQuotation simulation) {
    // print('Selected simulation: ${simulation.executive}');
    // You can perform further actions using the selected Simulation object
  }
  List<AnalystQuotation> quotationsByClient = [];

  void retrieveQuotationApplied() async {
    try {
      List<AnalystQuotation> listClients =
          await analystRepository.fetchAllQuotesForAnalyst();

      setState(() {
        quotationsByClient = listClients;
      });
    } catch (e) {
      EasyLoading.showError("Algo salio mal");
    }
  }

  void handleUpdateQuote(isFetchQuote) async {
    if (isFetchQuote != null && isFetchQuote is bool) {
      if (isFetchQuote) {
        retrieveQuotationApplied();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    retrieveQuotationApplied();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController
          .animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOut,
      )
          .then((_) {
        _scrollController.animateTo(
          0,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        sideBarList: const [],
        appBar:
            const CustomAppBarTitle(title: "Listado de aplicaciones a crédito"),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          child: CustomDataTable<Simulation>(
            columns: const [
              'Cliente',
              'Unidad',
              "Estado",
              'Precio de venta',
              'Total Saldo A financiar',
              'Ejecutivo'
            ],
            elements: quotationsByClient
                .asMap()
                .map((index, element) => MapEntry(
                    index,
                    DataRow(
                      onSelectChanged: (value) async {
                        final isQuoteUpdate = await Get.toNamed(
                            RouterPaths.ANALYST_DETAIL_CREDIT_PAGE,
                            arguments: {
                              "quoteId": element.id,
                              "statusId": element.statusId,
                              "unitName": element.unitName,
                              "sellPrice": element.sellPrice,
                              "finalPrice": element.buyPrice
                            });
                        handleUpdateQuote(isQuoteUpdate);
                      },
                      cells: [
                        DataCell(Container(
                          constraints: BoxConstraints(maxWidth: Get.width / 3),
                          child: Text(element.clientName),
                        )),
                        DataCell(Container(
                          constraints: BoxConstraints(maxWidth: Get.width / 3),
                          child: Text(element.unitName),
                        )),
                        DataCell(Container(
                          constraints: BoxConstraints(maxWidth: Get.width / 3),
                          child: Text(unitStatus[element.statusId]!),
                        )),
                        DataCell(Container(
                          constraints: BoxConstraints(maxWidth: Get.width / 3),
                          child: Text(element.sellPrice.toString()),
                        )),
                        DataCell(Container(
                          constraints: BoxConstraints(maxWidth: Get.width / 3),
                          child: Text(element.buyPrice.toString()),
                        )),
                        DataCell(Container(
                          constraints: BoxConstraints(maxWidth: Get.width / 3),
                          child: Text(element.executive),
                        )),
                      ],
                      color: appColors.dataRowColors(index),
                    )))
                .values
                .toList(),
          ),
        ));
  }
}
