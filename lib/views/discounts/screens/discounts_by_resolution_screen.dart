import 'package:developer_company/data/implementations/discount_repository_impl.dart';
import 'package:developer_company/data/models/discount_model.dart';
import 'package:developer_company/data/providers/discount_provider.dart';
import 'package:developer_company/data/repositories/discount_repository.dart';
import 'package:developer_company/global_state/providers/user_provider_state.dart';
import 'package:developer_company/main.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/widgets/data_table.dart';
import 'package:developer_company/widgets/filter_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class DiscountsByResolutionScreen extends StatefulWidget {
  const DiscountsByResolutionScreen({ Key? key }) : super(key: key);

  @override
  _DiscountsByResolutionScreenState createState() => _DiscountsByResolutionScreenState();
}

class _DiscountsByResolutionScreenState extends State<DiscountsByResolutionScreen> {
  final user = container.read(userProvider);
  bool isLoading = false;

  AppColors appColors = AppColors();

  DiscountRepository discountRepository =
      DiscountRepositoryImpl(DiscountProvider());

  List<RequestedDiscount> requestDiscounts = [];
  List<RequestedDiscount> filteredRequestDiscounts = [];


  fetchRequestedDiscounts() async {
    final projectId = user.project.projectId;
    try {
      setState(() => isLoading = true);
      EasyLoading.show();
      List<RequestedDiscount> listDiscounts =
          await discountRepository.getRequestDiscounts(projectId);
      setState(() {
        requestDiscounts = listDiscounts;
        filteredRequestDiscounts = listDiscounts;
      });
    } finally {
      EasyLoading.dismiss();
      setState(() => isLoading = false);
    }
  }

    @override
  void initState() {
    super.initState();
    fetchRequestedDiscounts();

  }

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
          FilterBox(
              hint: "Buscar",
              label: "Buscar",
              isLoading: isLoading,
              elements: requestDiscounts,
              handleFilteredData: ((List<RequestedDiscount> data) =>
                  setState(() => filteredRequestDiscounts = data)),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: CustomDataTable(
                columns: ["Nombre unidad", "Cliente", "Descuento\nSolicitado"],
                elements: filteredRequestDiscounts
                    .asMap()
                    .map((index, element) => MapEntry(
                        index,
                        DataRow(
                          onSelectChanged: (value) async {
                            final result = await Get.toNamed(
                                RouterPaths.DISCOUNT_DETAIL_BY_QUOTE_PAGE,
                                arguments: {
                                  "quoteId": element.quotationId,
                                  "statusId": element.statusId,
                                  "unitName": element.unitName,
                                  "sellPrice": element.sellPrice,
                                  "finalPrice": element.buyPrice
                                });

                            if (result == true) {
                              fetchRequestedDiscounts();
                            }
                          },
                          cells: [
                            DataCell(Text(element.unitName)),
                            DataCell(Text(element.clientName)),
                            DataCell(Text("% ${element.extraDiscount}")),
                          ],
                          color: appColors.dataRowColors(index),
                        )))
                    .values
                    .toList(),
              ),
            )
          ],
        );
  }
}