import "package:developer_company/data/models/loan_simulation_model.dart";
import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/resources/dimensions.dart";
import "package:developer_company/shared/routes/router_paths.dart";
import "package:developer_company/shared/utils/responsive.dart";
import "package:developer_company/widgets/app_bar_title.dart";
import "package:developer_company/widgets/custom_button_widget.dart";
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
    Responsive responsive = Responsive.of(context);

    return Layout(
      sideBarList: const [],
      appBar: const CustomAppBarTitle(title: "Programación de Pagos"),
      child: Column(children: [
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            child: DataTable(
                showCheckboxColumn: false,
                headingRowHeight: responsive.hp(6),
                headingRowColor: MaterialStateProperty.all<Color>(
                    AppColors.secondaryMainColor),
                columns: const <DataColumn>[
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Mes',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Interés',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Capital',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Cuota',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Saldo',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ],
                rows: simulation
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
                              width: (Get.width / 5) - 10,
                              child: Text(double.tryParse(
                                      element.monthlyInterest.toString())!
                                  .toStringAsFixed(2)),
                            )),
                            DataCell(Container(
                              width: (Get.width / 4) - 10,
                              child: Text(element.monthlyCapitalPayment),
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
                          color: index % 2 == 0
                              ? MaterialStateProperty.all<Color>(
                                  AppColors.lightColor)
                              : MaterialStateProperty.all<Color>(
                                  AppColors.lightSecondaryColor),
                        )))
                    .values
                    .toList()),
          ),
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
