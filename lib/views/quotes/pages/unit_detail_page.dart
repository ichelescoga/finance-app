import 'package:developer_company/data/implementations/unit_quotation_repository_impl.dart';
import 'package:developer_company/data/models/unit_quotation_model.dart';
import 'package:developer_company/data/providers/unit_quotation_provider.dart';
import 'package:developer_company/data/repositories/unit_quotation_repository.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/shared/utils/unit_status.dart';
import 'package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:developer_company/widgets/app_bar_title.dart';
import 'package:developer_company/widgets/custom_input_widget.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UnitDetailPage extends StatefulWidget {
  const UnitDetailPage({Key? key}) : super(key: key);

  @override
  State<UnitDetailPage> createState() => _UnitDetailPageState();
}

class _UnitDetailPageState extends State<UnitDetailPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Map<String, dynamic> arguments = Get.arguments;

  UnitDetailPageController unitDetailPageController =
      Get.put(UnitDetailPageController());

  final UnitQuotationRepository unitQuotationRepository =
      UnitQuotationRepositoryImpl(UnitQuotationProvider());
  List<UnitQuotation> _unitQuotations = [];

  void _fetchUnitQuotations() async {
    print(arguments["unitId"]);
    EasyLoading.showToast(Strings.loading);
    try {
      List<UnitQuotation> unitQuotations = await unitQuotationRepository
          .fetchUnitQuotationsForQuotation(arguments["unitId"]);

      print(unitQuotations);
      setState(() {
        _unitQuotations = unitQuotations;
      });
    } catch (e) {
      print(e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUnitQuotations();

    Future.delayed(const Duration(milliseconds: 200), () {
      unitDetailPageController.unit.text = arguments["unitName"];
      unitDetailPageController.unitStatus.text =
          unitStatus[arguments["unitStatus"]]!;
      unitDetailPageController.salePrice.text = arguments["salePrice"];
    });
  }

  String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    return Layout(
      sideBarList: const [],
      appBar:const CustomAppBarTitle(title: "Detalle de unidad"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: Dimensions.heightSize),
          CustomInputWidget(
              enabled: false,
              controller: unitDetailPageController.unit,
              label: "Unidad",
              hintText: "Unidad",
              prefixIcon: Icons.business_outlined),
          CustomInputWidget(
              enabled: false,
              controller: unitDetailPageController.salePrice,
              label: "Precio de venta",
              hintText: "Precio de venta",
              prefixIcon: Icons.monetization_on_outlined),
          CustomInputWidget(
              enabled: false,
              controller: unitDetailPageController.unitStatus,
              label: "Estado de la unidad",
              hintText: "Estado de la unidad",
              prefixIcon: Icons.business_outlined),
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
              headingRowColor: MaterialStateProperty.all<Color>(
                  AppColors.secondaryMainColor),
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
              rows: _unitQuotations
                  .asMap()
                  .map((index, element) => MapEntry(
                      index,
                      DataRow(
                          onSelectChanged: (value) {

                              // 'isEditing': false,
                              //         'idQuote': null,
                              //         'projectId': element.projectId,
                              //         'unitId': element.unitId,
                              //         'unitName': element.unitName,
                              //         'unitStatus': element.estadoId,
                              //         'salePrice': element.salePrice,
                              //         'finalSellPrice': element.salePrice
                            Get.toNamed(RouterPaths.UNIT_QUOTE_DETAIL_PAGE,
                                arguments: {
                                  'isEditing': true,
                                  "unitName": unitDetailPageController.unit.text,
                                  'unitStatus': arguments["unitStatus"],
                                  'salePrice': arguments["salePrice"],
                                  'finalSellPrice': element.quotation.saleDiscount,
                                  
                                  'quoteId': element.quotationId,
                                  'unitId': element.unitId,
                                  'discount': element.quotation.discount,
                                  'clientName': "",
                                  'clientPhone': "",
                                  'email': "",
                                  'startMoney': element.quotation.downPayment,
                                  'paymentMonths': element.quotation.termMonths,
                                  'cashPrice': element.quotation.cashPrice ,
                                  'aguinaldo': element.quotation.aguinaldo ,
                                  'bonusCatorce': element.quotation.bonusCatorce ,
                                  
                                });
                          },
                          cells: [
                            DataCell(Container(
                              width: (Get.width / 5),
                              child: Text(element.createdAt),
                            )),
                            DataCell(Container(
                              width: (Get.width / 5) - 20,
                              child: Text(element.quotation.detailAdvisorId.toString()),
                            )),
                            DataCell(Container(
                              width: (Get.width / 5) - 20,
                              child: Text(element.quotation.saleDiscount.toString()),
                            )),
                          ],
                          color: index % 2 == 0
                              ? MaterialStateProperty.all<Color>(
                                  AppColors.lightColor)
                              : MaterialStateProperty.all<Color>(
                                  AppColors.lightSecondaryColor))))
                  .values
                  .toList()),
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
