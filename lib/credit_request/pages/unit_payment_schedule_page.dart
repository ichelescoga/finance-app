import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnitPaymentSchedulePage extends StatefulWidget {
  const UnitPaymentSchedulePage({Key? key}) : super(key: key);

  @override
  State<UnitPaymentSchedulePage> createState() => _UnitPaymentSchedulePageState();
}

class _UnitPaymentSchedulePageState extends State<UnitPaymentSchedulePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    return WillPopScope(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: AppColors.BACKGROUND,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: 0.25,
            backgroundColor: AppColors.BACKGROUND,
            title: Text(
              'Programación de pagos',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(left: responsive.wp(5), right: responsive.wp(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: Dimensions.heightSize),
                  Center(
                    child: DataTable(
                      showCheckboxColumn: false,
                      headingRowHeight: responsive.hp(6),
                      headingRowColor: MaterialStateProperty.all<Color>(AppColors.secondaryMainColor),
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
                                width: (Get.width/5) - 10,
                                child: Text('Mes ${index + 1 }'),
                              )),
                              DataCell(Container(
                                width: (Get.width/5) - 10,
                                child: Text(''),
                              )),
                              DataCell(Container(
                                width: (Get.width/5) - 10,
                                child: Text(''),
                              )),
                            ],
                            color: index % 2 == 0 ? MaterialStateProperty.all<Color>(AppColors.lightColor) : MaterialStateProperty.all<Color>(AppColors.lightSecondaryColor)

                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: Dimensions.heightSize),
                  const SizedBox(height: Dimensions.heightSize),
                  GestureDetector(
                    child: Container(
                      height: 50.0,
                      width: Get.width,
                      decoration: const BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                          BorderRadius.all(Radius.circular(Dimensions.radius))),
                      child: Center(
                        child: Text(
                          "Regresar",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.largeTextSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.back(closeOverlays: true);
                    },
                  ),
                  const SizedBox(height: Dimensions.heightSize),

                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          Get.back(closeOverlays: true);
          return false;
        });
  }
}
