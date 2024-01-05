import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/resources/dimensions.dart";
import "package:developer_company/shared/routes/router_paths.dart";
import "package:developer_company/widgets/app_bar_sidebar.dart";
import "package:developer_company/widgets/data_table.dart";
import "package:developer_company/widgets/filter_box.dart";
import "package:developer_company/widgets/layout.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class listProjectsPage extends StatefulWidget {
  const listProjectsPage({Key? key}) : super(key: key);

  @override
  _listProjectsPageState createState() => _listProjectsPageState();
}

class _listProjectsPageState extends State<listProjectsPage> {
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
                onPressed: () => Get.toNamed(
                    RouterPaths.ASSIGN_PROJECT_TO_COMPANY_PAGE))
          ],
        ),
        child: Column(
          children: [
            FilterBox(
              label: "Buscar Empresas",
              hint: "Buscar",
              elements: [],
              isLoading: false,
              handleFilteredData: (p0) {},
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: CustomDataTable(
                  columns: [
                    "Nombre",
                    "Desarrolladora",
                    "Contacto",
                    "Estado",
                    ""
                  ],
                  elements: [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
                      .asMap()
                      .map((index, element) => MapEntry(
                          index,
                          DataRow(
                            cells: [
                              DataCell(Text("element.businessName")),
                              DataCell(ConstrainedBox(
                                  constraints:
                                      BoxConstraints(maxWidth: Get.width / 2),
                                  child: Wrap(
                                    children: [
                                      Text(
                                        "element.developer",
                                        overflow: TextOverflow.clip,
                                      ),
                                    ],
                                  ))),
                              DataCell(Text("element.contactPhone")),
                              DataCell(Text("Activo")),
                              DataCell(Row(
                                children: [
                                  IconButton(
                                      onPressed: () => Get.toNamed(RouterPaths
                                          .ASSIGN_PROJECT_TO_COMPANY_PAGE),
                                      icon: Icon(Icons.edit_square)),
                                  IconButton(
                                      onPressed: () {
                                        // TODO Disabled Project.
                                      },
                                      icon: Icon(Icons.delete))
                                ],
                              ))
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
          ],
        ));
  }
}
