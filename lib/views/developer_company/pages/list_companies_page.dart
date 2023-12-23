import 'package:developer_company/data/implementations/company_repository_impl.dart';
import 'package:developer_company/data/models/company_model.dart';
import 'package:developer_company/data/providers/company_provider.dart';
import 'package:developer_company/data/repositories/company_repository.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/widgets/app_bar_sidebar.dart';
import 'package:developer_company/widgets/data_table.dart';
import 'package:developer_company/widgets/delete_company_dialog.dart';
import 'package:developer_company/widgets/filter_box.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ListCompanies extends StatefulWidget {
  const ListCompanies({Key? key}) : super(key: key);

  @override
  _ListCompaniesState createState() => _ListCompaniesState();
}

class _ListCompaniesState extends State<ListCompanies> {
  CompanyRepository companyProvider = CompanyRepositoryImpl(CompanyProvider());
  List<Company> companies = [];
  List<Company> filteredCompanies = [];

  _getCompanies() async {
    EasyLoading.show();
    final tempCompanies = await companyProvider.fetchCompanies();

    setState(() {
      companies = tempCompanies;
      filteredCompanies = tempCompanies;
    });
    EasyLoading.dismiss();
  }

  @override
  void initState() {
    super.initState();
    _getCompanies();
  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss();
  }

  _handleManageCompany(int? companyId) async {
    final needUpdateListCompanies = await Get.toNamed(
        RouterPaths.MANAGE_COMPANY_PAGE,
        arguments: {"companyId": companyId});
    if (needUpdateListCompanies) {
      _getCompanies();
    }
  }

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
                  _handleManageCompany(null);
                })
          ],
        ),
        child: Column(
          children: [
            FilterBox(
              label: "Buscar Empresas",
              hint: "Buscar",
              elements: companies,
              isLoading: false,
              handleFilteredData: (List<Company> data) =>
                  setState(() => filteredCompanies = data),
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
                  elements: filteredCompanies
                      .asMap()
                      .map((index, element) => MapEntry(
                          index,
                          DataRow(
                            cells: [
                              DataCell(Text(element.businessName)),
                              DataCell(ConstrainedBox(
                                  constraints:
                                      BoxConstraints(maxWidth: Get.width / 2),
                                  child: Wrap(
                                    children: [
                                      Text(
                                        element.developer,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ],
                                  ))),
                              DataCell(Text(element.contactPhone)),
                              DataCell(Text("Activo")),
                              DataCell(Row(
                                children: [
                                  IconButton(
                                      onPressed: () => _handleManageCompany(
                                          element.companyId),
                                      icon: Icon(Icons.edit_square)),
                                  IconButton(
                                      onPressed: () => _dialogDeleteCompany(
                                          context, element),
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

  _dialogDeleteCompany(BuildContext context, Company company) {
    showDialog(
      context: context,
      builder: (context) {
        return PopScope(
          child: DeleteCompanyDialog(
            companyName: company.businessName,
            companyId: company.companyId!,
          ),
        );
      },
    ).then((value) {
      if (value == true) {
        _getCompanies();
        return;
      }
    });
  }
}
