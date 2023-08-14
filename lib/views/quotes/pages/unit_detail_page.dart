import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/custom_style.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:developer_company/widgets/app_bar_title.dart';
import 'package:developer_company/widgets/custom_input_widget.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UnitDetailPage extends StatefulWidget {
  const UnitDetailPage({Key? key}) : super(key: key);

  @override
  State<UnitDetailPage> createState() => _UnitDetailPageState();
}

class _UnitDetailPageState extends State<UnitDetailPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UnitDetailPageController unitDetailPageController =
      Get.put(UnitDetailPageController());

  @override
  void initState() {
    super.initState();
    unitDetailPageController.startController();
  }

  String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    return Layout(
      sideBarList: const [],
      appBar: CustomAppBarTitle(title: "Detalle de unidad"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: Dimensions.heightSize),
          CustomInputWidget(
              controller: unitDetailPageController.unit,
              label: "Unidad",
              hintText: "Unidad",
              prefixIcon: Icons.business_outlined),
          CustomInputWidget(
              controller: unitDetailPageController.salePrice,
              label: "Precio de venta",
              hintText: "Precio de venta",
              prefixIcon: Icons.monetization_on_outlined),
          CustomInputWidget(
              controller: unitDetailPageController.unit,
              label: "Estado de la unidad",
              hintText: "Estado de la unidad",
              prefixIcon: Icons.business_outlined),

          // const Text(
          //   "Unidad",
          //   style: TextStyle(color: Colors.black),
          // ),
          // const SizedBox(
          //   height: Dimensions.heightSize * 0.5,
          // ),
          // TextFormField(
          //   style: CustomStyle.textStyle,
          //   controller: unitDetailPageController.unit,
          //   keyboardType: TextInputType.name,
          //   validator: (String? value) {
          //     if (value!.isEmpty) {
          //       return Strings.pleaseFillOutTheField;
          //     } else {
          //       return null;
          //     }
          //   },
          //   decoration: InputDecoration(
          //     hintText: "Unidad",
          //     contentPadding:
          //         const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          //     labelStyle: CustomStyle.textStyle,
          //     filled: true,
          //     fillColor: AppColors.lightColor,
          //     hintStyle: CustomStyle.textStyle,
          //     focusedBorder: CustomStyle.focusBorder,
          //     enabledBorder: CustomStyle.focusErrorBorder,
          //     focusedErrorBorder: CustomStyle.focusErrorBorder,
          //     errorBorder: CustomStyle.focusErrorBorder,
          //     prefixIcon: const Icon(Icons.person_outline),
          //   ),
          // ),
          // const SizedBox(height: Dimensions.heightSize),
          // const Text(
          //   "Precio de venta",
          //   style: TextStyle(color: Colors.black),
          // ),
          // const SizedBox(
          //   height: Dimensions.heightSize * 0.5,
          // ),
          // TextFormField(
          //   style: CustomStyle.textStyle,
          //   controller: unitDetailPageController.salePrice,
          //   keyboardType: TextInputType.name,
          //   validator: (String? value) {
          //     if (value!.isEmpty) {
          //       return Strings.pleaseFillOutTheField;
          //     } else {
          //       return null;
          //     }
          //   },
          //   decoration: InputDecoration(
          //     hintText: "Precio de venta",
          //     contentPadding:
          //         const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          //     labelStyle: CustomStyle.textStyle,
          //     filled: true,
          //     fillColor: AppColors.lightColor,
          //     hintStyle: CustomStyle.textStyle,
          //     focusedBorder: CustomStyle.focusBorder,
          //     enabledBorder: CustomStyle.focusErrorBorder,
          //     focusedErrorBorder: CustomStyle.focusErrorBorder,
          //     errorBorder: CustomStyle.focusErrorBorder,
          //     prefixIcon: const Icon(Icons.person_outline),
          //   ),
          // ),
          // const SizedBox(height: Dimensions.heightSize),
          // const Text(
          //   "Estado de la unidad",
          //   style: TextStyle(color: Colors.black),
          // ),
          // const SizedBox(
          //   height: Dimensions.heightSize * 0.5,
          // ),
          // TextFormField(
          //   style: CustomStyle.textStyle,
          //   controller: unitDetailPageController.unitStatus,
          //   keyboardType: TextInputType.name,
          //   validator: (String? value) {
          //     if (value!.isEmpty) {
          //       return Strings.pleaseFillOutTheField;
          //     } else {
          //       return null;
          //     }
          //   },
          //   decoration: InputDecoration(
          //     hintText: "Estado de la unidad",
          //     contentPadding:
          //         const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          //     labelStyle: CustomStyle.textStyle,
          //     filled: true,
          //     fillColor: AppColors.lightColor,
          //     hintStyle: CustomStyle.textStyle,
          //     focusedBorder: CustomStyle.focusBorder,
          //     enabledBorder: CustomStyle.focusErrorBorder,
          //     focusedErrorBorder: CustomStyle.focusErrorBorder,
          //     errorBorder: CustomStyle.focusErrorBorder,
          //     prefixIcon: const Icon(Icons.person_outline),
          //   ),
          // ),
          // const SizedBox(height: Dimensions.heightSize),
          const Text(
            "Historial de cotizaciones",
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: Dimensions.heightSize * 0.5,
          ),
          DataTable(
            showCheckboxColumn: false,
            headingRowHeight: responsive.hp(6),
            headingRowColor:
                MaterialStateProperty.all<Color>(AppColors.secondaryMainColor),
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Fecha',
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
                    'Asesor',
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
                    'Monto cotizado',
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
            rows: List.generate(4, (index) {
              return DataRow(
                  onSelectChanged: (value) {
                    print("$value ${index + 1}");
                    Get.toNamed(RouterPaths.UNIT_QUOTE_DETAIL_PAGE, arguments: {
                      'isEditing': true,
                      'idQuote': index + 1,
                      'anotherParamList': [1, 2, 3, 4, 5],
                      'paramObject': {"key": "name", 'key2': "name2"}
                    });
                  },
                  cells: [
                    DataCell(Container(
                      width: (Get.width / 5),
                      child: Text('$formattedDate'),
                    )),
                    DataCell(Container(
                      width: (Get.width / 5) - 20,
                      child: Text(''),
                    )),
                    DataCell(Container(
                      width: (Get.width / 5) - 20,
                      child: Text(''),
                    )),
                  ],
                  color: index % 2 == 0
                      ? MaterialStateProperty.all<Color>(AppColors.lightColor)
                      : MaterialStateProperty.all<Color>(
                          AppColors.lightSecondaryColor));
            }),
          ),
          // const SizedBox(height: Dimensions.heightSize),
          // const Text(
          //   "Historial por ofertas de banco",
          //   style: TextStyle(color: Colors.black),
          // ),
          // const SizedBox(
          //   height: Dimensions.heightSize * 0.5,
          // ),
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: DataTable(
          //     showCheckboxColumn: false,
          //     headingRowHeight: 50,
          //     headingRowColor:
          //     MaterialStateProperty.all<Color>(AppColors.secondaryMainColor),
          //     columns: const <DataColumn>[
          //       DataColumn(
          //         label: Expanded(
          //           child: Text(
          //             'Fecha',
          //             style: TextStyle(
          //               fontWeight: FontWeight.w600,
          //               fontSize: 17,
          //               color: Colors.white,
          //               overflow: TextOverflow.ellipsis,
          //             ),
          //             textAlign: TextAlign.center,
          //             maxLines: 2,
          //           ),
          //         ),
          //       ),
          //       DataColumn(
          //         label: Expanded(
          //           child: Text(
          //             'Ejecutivo banco',
          //             style: TextStyle(
          //               fontWeight: FontWeight.w600,
          //               fontSize: 17,
          //               color: Colors.white,
          //               overflow: TextOverflow.ellipsis,
          //             ),
          //             textAlign: TextAlign.center,
          //             maxLines: 2,
          //           ),
          //         ),
          //       ),
          //       DataColumn(
          //         label: Expanded(
          //           child: Text(
          //             'Monto prestamo',
          //             style: TextStyle(
          //               fontWeight: FontWeight.w600,
          //               fontSize: 17,
          //               color: Colors.white,
          //               overflow: TextOverflow.ellipsis,
          //             ),
          //             textAlign: TextAlign.center,
          //             maxLines: 2,
          //           ),
          //         ),
          //       ),
          //       DataColumn(
          //         label: Expanded(
          //           child: Text(
          //             'Tasa',
          //             style: TextStyle(
          //               fontWeight: FontWeight.w600,
          //               fontSize: 17,
          //               color: Colors.white,
          //               overflow: TextOverflow.ellipsis,
          //             ),
          //             textAlign: TextAlign.center,
          //             maxLines: 2,
          //           ),
          //         ),
          //       ),
          //     ],
          //     rows: List.generate(2, (index) {
          //       return DataRow(
          //         onSelectChanged: (value) {},
          //         cells: [
          //           DataCell(Container(
          //             width: 100,
          //             child: Text('$formattedDate'),
          //           )),
          //           DataCell(Container(
          //             width: 100,
          //             child: Text(''),
          //           )),
          //           DataCell(Container(
          //             width: 100,
          //             child: Text(''),
          //           )),
          //           DataCell(Container(
          //             width: 100,
          //             child: Text(''),
          //           )),
          //         ],
          //         color: index % 2 == 0
          //             ? MaterialStateProperty.all<Color>(AppColors.lightColor)
          //             : MaterialStateProperty.all<Color>(
          //             AppColors.lightSecondaryColor),
          //       );
          //     }),
          //   ),
          // ),
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
              child: const Center(
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
        ],
      ),
    );
  }
}
