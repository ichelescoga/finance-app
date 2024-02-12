import "package:developer_company/data/implementations/credits_approved_reserved_impl.dart";
import "package:developer_company/data/models/credits_approved_reserved_model.dart";
import "package:developer_company/data/providers/credits_approved_reserved_provider.dart";
import "package:developer_company/data/repositories/credits_approved_reserved_repository.dart";
import "package:developer_company/shared/routes/router_paths.dart";
import "package:developer_company/shared/utils/unit_status.dart";
import "package:developer_company/widgets/app_bar_sidebar.dart";
import "package:developer_company/widgets/data_table.dart";
import "package:developer_company/widgets/layout.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class CreditsReservedApproved extends StatefulWidget {
  const CreditsReservedApproved({Key? key}) : super(key: key);

  @override
  _CreditsReservedApprovedState createState() =>
      _CreditsReservedApprovedState();
}

class _CreditsReservedApprovedState extends State<CreditsReservedApproved> {
  CreditsApprovedReservedRepository creditsApprovedReserved =
      CreditsApprovedReservedImpl(CreditsApprovedReservedProvider());

  // final AnalystRepository analystRepository =
  //   AnalystRepositoryImpl(AnalystProvider());
  List<CreditsApprovedReserved> credits = [];

  void _fetchCreditsApprovedReserved() async {
    final approvedReservers =
        await creditsApprovedReserved.fetchCreditsApprovedReserved();

    setState(() {
      credits = approvedReservers;
    });
  }

  void _handleUpdateCredits(isFetchQuote) {
    if (isFetchQuote != null && isFetchQuote is bool) {
      if (isFetchQuote) {
        _fetchCreditsApprovedReserved();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCreditsApprovedReserved();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        sideBarList: const [],
        appBar: CustomAppBarSideBar(title: "Aprobaciones de crédito"),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: CustomDataTable(
            columns: [
              "Cliente",
              "Unidad",
              "Estado Cotización",
              "Estado Unidad",
              "Precio de Venta",
              "Saldo a Financiar",
            ],
            elements: credits
                .asMap()
                .map((index, element) {
                  return MapEntry(
                      index,
                      DataRow(
                          onSelectChanged: (value) async {
                            // if(element.unitStatusId == )

                            final isQuoteUpdate = await Get.toNamed(
                                RouterPaths.CREDIT_DETAIL_PAGE,
                                arguments: {
                                  "quoteId": element.quoteId.toString(),
                                  "statusId": element.statusId.toString(),
                                  "unitStatusId": element.unitStatusId.toString(),
                                  "unitName": element.unitName,
                                  "sellPrice": element.sellPrice,
                                  "finalPrice": element.sellToFinance
                                });
                            _handleUpdateCredits(isQuoteUpdate);
                          },
                          cells: [
                            DataCell(Container(
                              constraints:
                                  BoxConstraints(maxWidth: Get.width / 3),
                              child: Text(element.clientName),
                            )),
                            DataCell(Container(
                              constraints:
                                  BoxConstraints(maxWidth: Get.width / 3),
                              child: Text(element.unitName),
                            )),
                            DataCell(Container(
                              constraints:
                                  BoxConstraints(maxWidth: Get.width / 3),
                              child: Text(unitStatus[element.statusId].toString() ),
                            )),
                            DataCell(Container(
                              constraints:
                                  BoxConstraints(maxWidth: Get.width / 3),
                              child:
                                  Text(getUnitStatus(element.unitStatusId)),
                            )),
                            DataCell(Container(
                              constraints:
                                  BoxConstraints(maxWidth: Get.width / 3),
                              child: Text(element.sellPrice),
                            )),
                            DataCell(Container(
                              constraints:
                                  BoxConstraints(maxWidth: Get.width / 3),
                              child: Text(element.sellToFinance),
                            ))
                          ]));
                })
                .values
                .toList(),
          ),
        ));
  }
}
