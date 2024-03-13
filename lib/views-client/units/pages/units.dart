import 'package:developer_company/client_rest_api/api/client_api.dart';
import 'package:developer_company/client_rest_api/models/units/client_units_model.dart';
import 'package:developer_company/global_state/providers/user_provider_state.dart';
import 'package:developer_company/main.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/widgets/app_bar_title.dart';
import 'package:developer_company/widgets/data_table.dart';
import 'package:developer_company/widgets/filter_box.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class Units extends StatefulWidget {
  const Units({Key? key}) : super(key: key);

  @override
  _UnitsState createState() => _UnitsState();
}

class _UnitsState extends State<Units> {
  List<ClientUnitsModel> units = [];
  List<ClientUnitsModel> tempUnits = [];
  final userClient = container.read(userClientProvider);
  final AppColors appColors = AppColors();
  ClientUnitProvider _clientUnitProvider = ClientUnitProvider();

  _fetchUnits() async {
    tempUnits.clear();
    units.clear();
    EasyLoading.show();
    tempUnits = await _clientUnitProvider.fetchUnits(userClient.userProfileId);

    setState(() {
      units = tempUnits;
    });

    EasyLoading.dismiss();
  }

  @override
  void initState() {
    print(userClient);
    _fetchUnits();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        sideBarList: [],
        appBar: CustomAppBarTitle(title: "Unidades"),
        child: Column(
          children: [
            FilterBox(
                elements: [],
                handleFilteredData: (p0) => {},
                isLoading: false,
                hint: "Buscar",
                label: "Buscar"),
            CustomDataTable(
              columns: ["Nombre", ""],
              elements: units
                  .asMap()
                  .map((index, element) => MapEntry(
                      index,
                      DataRow(
                        cells: [
                          DataCell(Container(
                              width: (Get.width - 150),
                              child: Text(element.name))),
                          DataCell(IconButton(
                            icon: Icon(Icons.article_outlined),
                            onPressed: () {},
                          ))
                        ],
                        color: appColors.dataRowColors(index),
                      )))
                  .values
                  .toList(),
            )
          ],
        ));
  }
}
