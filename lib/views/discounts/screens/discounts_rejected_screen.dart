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


class DiscountsRejectedScreen extends StatefulWidget {
  const DiscountsRejectedScreen({Key? key}) : super(key: key);

  @override
  _DiscountsRejectedScreenState createState() =>
      _DiscountsRejectedScreenState();
}

class _DiscountsRejectedScreenState extends State<DiscountsRejectedScreen> {
  final user = container.read(userProvider);
  bool isLoading = false;

  AppColors appColors = AppColors();

  DiscountRepository discountRepository =
      DiscountRepositoryImpl(DiscountProvider());

  List<RequestedDiscount> discountsRejected = [];

  fetchApprovedDiscounts() async {
    final projectId = user.project.projectId;
    try {
      setState(() => isLoading = true);
      EasyLoading.show();
      List<RequestedDiscount> listDiscounts =
          await discountRepository.getDiscountByResolution(false, projectId);
      setState(() {
        discountsRejected = listDiscounts;
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
          elements: discountsRejected,
          handleFilteredData: ((List<RequestedDiscount> data) =>
              setState(() => discountsRejected = data)),
        ),
        CustomDataTable(
          columns: ["Nombre unidad", "Cliente", "Descuento\nSolicitado"],
          elements: discountsRejected
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
