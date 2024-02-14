import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:flutter/material.dart';

class CustomDataTable<T> extends StatelessWidget {
  final List<String> columns;
  final List<DataRow> elements;
  

  CustomDataTable({
    required this.columns,
    required this.elements,
   
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
        columns: List.generate(
          columns.length,
          (index) => DataColumn(
            label: Expanded(
              child: Text(
                columns[index],
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
                textAlign: TextAlign.left,
                maxLines: 2,
              ),
            ),
          ),
        ),
        rows: elements);
  }
}
