import 'package:developer_company/data/implementations/discount_repository_impl.dart';
import 'package:developer_company/data/models/discount_model.dart';
import 'package:developer_company/data/providers/discount_provider.dart';
import 'package:developer_company/data/repositories/discount_repository.dart';
import 'package:developer_company/global_state/providers/user_provider_state.dart';
import 'package:developer_company/main.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/widgets/data_table.dart';
import 'package:developer_company/widgets/filter_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DiscountsApprovedScreen extends StatefulWidget {
  const DiscountsApprovedScreen({Key? key}) : super(key: key);

  @override
  _DiscountsApprovedScreenState createState() =>
      _DiscountsApprovedScreenState();
}

class _DiscountsApprovedScreenState extends State<DiscountsApprovedScreen> {
  final user = container.read(userProvider);
  bool isLoading = false;

  AppColors appColors = AppColors();

  DiscountRepository discountRepository =
      DiscountRepositoryImpl(DiscountProvider());

  List<RequestedDiscount> discountsApproved = [];
  List<RequestedDiscount> filteredDiscountsApproved = [];

  fetchApprovedDiscounts() async {
    final projectId = user.project.projectId;
    try {
      setState(() => isLoading = true);
      EasyLoading.show();
      List<RequestedDiscount> listDiscounts =
          await discountRepository.getDiscountByResolution(true, projectId);
      setState(() {
        discountsApproved = listDiscounts;
        filteredDiscountsApproved = listDiscounts;
      });
    } finally {
      EasyLoading.dismiss();
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchApprovedDiscounts();
  }

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors();

    return Column(
      children: [
        FilterBox(
          hint: "Buscar",
          label: "Buscar",
          isLoading: isLoading,
          elements: discountsApproved,
          handleFilteredData: ((List<RequestedDiscount> data) =>
              setState(() => filteredDiscountsApproved = data)),
        ),
        CustomDataTable(
          columns: ["Nombre unidad", "Cliente", "Descuento\nSolicitado"],
          elements: filteredDiscountsApproved
              .asMap()
              .map((index, element) => MapEntry(
                  index,
                  DataRow(
                    onSelectChanged: (value) async {},
                    cells: [
                      DataCell(Text(element.unitName)),
                      DataCell(Text(element.clientName)),
                      DataCell(Text("% ${element.extraDiscount}")),
                    ],
                    color: appColors.dataRowColors(index),
                  )))
              .values
              .toList(),
        )
      ],
    );
  }
}
