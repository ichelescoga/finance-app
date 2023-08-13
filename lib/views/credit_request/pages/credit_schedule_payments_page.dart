import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/utils/responsive.dart";
import "package:developer_company/widgets/app_bar_title.dart";
import "package:developer_company/widgets/layout.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class CreditSchedulePaymentsPage extends StatefulWidget {
  const CreditSchedulePaymentsPage({Key? key}) : super(key: key);

  @override
  _CreditSchedulePaymentsPageState createState() =>
      _CreditSchedulePaymentsPageState();
}

class _CreditSchedulePaymentsPageState
    extends State<CreditSchedulePaymentsPage> {
  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);

    @override
    void initState() {
      super.initState();
      print("SHOULD BE RETRIEVE PAYMENTS CALC");
    }

    return Layout(
      sideBarList: [],
      appBar: const CustomAppBarTitle(title: "Programación de Pagos"),
      child: Column(children: [
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
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
                      'Interes',
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
              rows: List.generate(8, (index) {
                return DataRow(
                  cells: [
                    DataCell(Container(
                      width: (Get.width / 5) - 10,
                      child: Text('Mes ${index + 1}'),
                    )),
                    DataCell(Container(
                      width: (Get.width / 5) - 10,
                      child: Text('${1 + index}'),
                    )),
                    DataCell(Container(
                      width: (Get.width / 5) - 10,
                      child: Text('${1 + index}'),
                    )),
                    DataCell(Container(
                      width: (Get.width / 5) - 10,
                      child: Text('${1 + index}'),
                    )),
                    DataCell(Container(
                      width: (Get.width / 5) - 10,
                      child: Text('${1 + index}'),
                    )),
                  ],
                  color: index % 2 == 0
                      ? MaterialStateProperty.all<Color>(AppColors.lightColor)
                      : MaterialStateProperty.all<Color>(
                          AppColors.lightSecondaryColor),
                );
              }),
            ),
          ),
        ),
      ]),
    );
  }
}
