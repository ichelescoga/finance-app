import 'package:developer_company/widgets/app_bar_sidebar.dart';
import 'package:developer_company/widgets/data_table.dart';
import 'package:developer_company/widgets/filter_box.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:flutter/material.dart';

class DiscountDetailByQuotePage extends StatefulWidget {
  const DiscountDetailByQuotePage({Key? key}) : super(key: key);

  @override
  _DiscountDetailByQuotePageState createState() =>
      _DiscountDetailByQuotePageState();
}

class _DiscountDetailByQuotePageState extends State<DiscountDetailByQuotePage> {
  @override
  Widget build(BuildContext context) {
    return Layout(
        sideBarList: const [],
        appBar: CustomAppBarSideBar(title: "Descuentos"),
        child: Column(
          children: [
            FilterBox(
                elements: [],
                handleFilteredData: (data) => {},
                isLoading: false,
                hint: "hint",
                label: "label"),
            CustomDataTable(columns: ["asd", ":"], elements: [])
          ],
        ));
  }
}
