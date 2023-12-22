import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/widgets/app_bar_sidebar.dart';
import 'package:developer_company/widgets/data_table.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListCompanies extends StatefulWidget {
  const ListCompanies({Key? key}) : super(key: key);

  @override
  _ListCompaniesState createState() => _ListCompaniesState();
}

class _ListCompaniesState extends State<ListCompanies> {
  @override
  Widget build(BuildContext context) {
    return Layout(
        sideBarList: [],
        appBar: CustomAppBarSideBar(
          title: "Empresas",
          rightActions: [
            IconButton(
                icon: Icon(
                  Icons.add_circle_sharp,
                  color: AppColors.softMainColor,
                  size: Dimensions.topIconSizeH,
                ),
                onPressed: () {
                  Get.toNamed(RouterPaths.MANAGE_COMPANY_PAGE);
                })
          ],
        ),
        child: Container(
            child: Center(
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: CustomDataTable(
                columns: ["Nombre", "Descripción", "Estado"],
                elements: [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
                    .asMap()
                    .map((index, element) => MapEntry(
                        index,
                        DataRow(
                          onSelectChanged: (value) {
                            Get.toNamed(RouterPaths.MANAGE_COMPANY_PAGE);
                          },
                          cells: [
                            DataCell(Text("Precision Craftworks")),
                            DataCell(ConstrainedBox(
                                constraints:
                                    BoxConstraints(maxWidth: Get.width / 2),
                                child: Wrap(
                                  children: [
                                    Text(
                                      "Creación de productos artesanales con precisión y calidad " ,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ],
                                ))),
                            DataCell(Text("Activo")),
                          ],
                          color: index % 2 == 0
                              ? MaterialStateProperty.all<Color>(
                                  AppColors.lightColor)
                              : MaterialStateProperty.all<Color>(
                                  AppColors.lightSecondaryColor),
                        )))
                    .values
                    .toList(),
              )),
        )));
  }
}
