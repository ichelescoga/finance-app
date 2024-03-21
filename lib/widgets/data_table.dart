import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/custom_style.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:flutter/material.dart';

class CustomDataTable<T> extends StatelessWidget {
  final List<String> columns;
  final List<DataRow> elements;
  final bool isHeaderWidgets;
  final List<Widget> headerWidgets;

  CustomDataTable({
    required this.columns,
    required this.elements,
    this.isHeaderWidgets = false,
    this.headerWidgets = const [],
  });

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);

    return DataTable(
        columnSpacing: 30.0,
        dataRowMinHeight: 40,
        dataRowMaxHeight: double.infinity,
        showCheckboxColumn: false,
        headingRowHeight: responsive.hp(6),
        headingRowColor:
            MaterialStateProperty.all<Color>(AppColors.secondaryMainColor),
        columns: isHeaderWidgets
            ? List.generate(headerWidgets.length,
                (index) => DataColumn(label: headerWidgets[index]))
            : List.generate(
                columns.length,
                (index) => DataColumn(
                  label: Expanded(
                    child: Text(
                      columns[index],
                      style: CustomStyle.tableHeader,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                    ),
                  ),
                ),
              ),
        rows: elements);
  }
}
