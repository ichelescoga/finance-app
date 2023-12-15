import 'package:developer_company/data/implementations/unit_quotation_repository_impl.dart';
import 'package:developer_company/data/models/unit_quotation_model.dart';
import 'package:developer_company/data/providers/unit_quotation_provider.dart';
import 'package:developer_company/data/repositories/unit_quotation_repository.dart';
import 'package:developer_company/global_state/providers/user_provider_state.dart';
import 'package:developer_company/main.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/shared/services/quetzales_currency.dart';
import 'package:developer_company/shared/utils/unit_status.dart';
import 'package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/widgets/app_bar_title.dart';
import 'package:developer_company/widgets/custom_input_widget.dart';
import 'package:developer_company/widgets/data_table.dart';
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
  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Map<String, dynamic> arguments = Get.arguments;
  final user = container.read(userProvider);
  final appColors = AppColors();

  UnitDetailPageController unitDetailPageController =
      Get.put(UnitDetailPageController());

  final UnitQuotationRepository unitQuotationRepository =
      UnitQuotationRepositoryImpl(UnitQuotationProvider());
  List<UnitQuotation> _unitQuotations = [];

  void _fetchUnitQuotations() async {
    EasyLoading.showToast(Strings.loading);
    try {
      List<UnitQuotation> unitQuotations = await unitQuotationRepository
          .fetchUnitQuotationsForQuotation(int.parse(arguments["unitId"]));

      setState(() {
        _unitQuotations = unitQuotations;
      });
    } catch (e) {
      print(e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  void handleFetchQuoteHistory(isFetchQuote) async {
    if (isFetchQuote != null && isFetchQuote is bool) {
      if (isFetchQuote) {
        _fetchUnitQuotations();
      }
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
      unitDetailPageController.salePrice.text =
          quetzalesCurrency(arguments["salePrice"].toString());
    });
  }

  String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Layout(
      sideBarList: const [],
      appBar: const CustomAppBarTitle(title: "Detalle de unidad"),
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
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: CustomDataTable(
                columns: ["Fecha", "Asesor", "Monto cotizado"],
                elements: _unitQuotations
                    .asMap()
                    .map((index, element) => MapEntry(
                        index,
                        DataRow(
                          onSelectChanged: (value) async {
                            final isFetchQuote = await Get.toNamed(
                                RouterPaths.UNIT_QUOTE_DETAIL_PAGE,
                                arguments: {
                                  'isEditing': true,
                                  "unitName":
                                      unitDetailPageController.unit.text,
                                  'unitStatus': arguments["unitStatus"],
                                  'salePrice': arguments["salePrice"],
                                  'finalSellPrice':
                                      element.quotation.saleDiscount,
                                  'quoteId': element.quotationId,
                                  'unitId': element.unitId,
                                });
                            handleFetchQuoteHistory(isFetchQuote);
                          },
                          cells: [
                            DataCell(Container(
                              width: (Get.width / 5),
                              child: Text(element.createdAt),
                            )),
                            DataCell(Container(
                              width: (Get.width / 3) - 20,
                              child: Text(user.name),
                            )),
                            DataCell(Container(
                              width: (Get.width / 3) - 20,
                              child: Text(
                                  element.quotation.saleDiscount.toString()),
                            )),
                          ],
                          color: appColors.dataRowColors(index),
                        )))
                    .values
                    .toList(),
              )),
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
