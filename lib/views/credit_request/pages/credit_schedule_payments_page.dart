import "package:developer_company/data/models/loan_simulation_model.dart";
import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/resources/dimensions.dart";
import "package:developer_company/shared/routes/router_paths.dart";
import "package:developer_company/widgets/app_bar_title.dart";
import "package:developer_company/widgets/custom_button_widget.dart";
import "package:developer_company/widgets/data_table.dart";
import "package:developer_company/widgets/layout.dart";
import "package:flutter/material.dart";
import 'package:get/get.dart';

class CreditSchedulePaymentsPage extends StatefulWidget {
  const CreditSchedulePaymentsPage({Key? key}) : super(key: key);

  @override
  _CreditSchedulePaymentsPageState createState() =>
      _CreditSchedulePaymentsPageState();
}

class _CreditSchedulePaymentsPageState
    extends State<CreditSchedulePaymentsPage> {
  final _scrollController = ScrollController();
  final Map<String, dynamic> arguments = Get.arguments;

  List<LoanSimulationResponse> simulation = [];
  AppColors appColors = AppColors();

  void loadListOfSimulation() {
    setState(() {
      simulation = arguments['simulationSchedule'];
    });
  }

  @override
  void initState() {
    super.initState();
    loadListOfSimulation();
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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      sideBarList: const [],
      appBar: const CustomAppBarTitle(title: "Programación de Pagos"),
      child: Column(children: [
        Center(
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: CustomDataTable(
                columns: ["Mes", "Cuota", "Saldo"],
                elements: simulation
                    .asMap()
                    .map((index, element) => MapEntry(
                        index,
                        DataRow(
                          cells: [
                            DataCell(Container(
                              width: (Get.width / 5) - 10,
                              child: Text('Mes ${index + 1}'),
                            )),
                            DataCell(Container(
                              width: (Get.width / 4) - 10,
                              child: Text(element.monthlyTotalPayment),
                            )),
                            DataCell(Container(
                              width: (Get.width / 4) - 10,
                              child: Text(element.creditTotalBalance),
                            )),
                          ],
                          color: appColors.dataRowColors(index),
                        )))
                    .values
                    .toList(),
              )),
        ),
        const SizedBox(height: Dimensions.heightSize),
        Row(
          children: <Widget>[
            Expanded(
              child: CustomButtonWidget(
                text: "Aplicar a crédito",
                onTap: () {
                  Get.toNamed(RouterPaths.CLIENT_QUOTE_PAGE, arguments: {
                    'quoteId': arguments['quoteId'],
                    "quoteState": arguments["quoteState"],
                    "unitStatus": arguments["unitStatus"]
                  });
                },
              ),
            ),
            Expanded(
              child: CustomButtonWidget(
                text: "Regresar",
                onTap: () {
                  Get.back(closeOverlays: true);
                },
              ),
            )
          ],
        ),
        const SizedBox(height: Dimensions.heightSize),
      ]),
    );
  }
}
