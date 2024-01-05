import 'package:developer_company/widgets/app_bar_title.dart';
import 'package:developer_company/widgets/autocomplete_dropdown.dart';
import 'package:developer_company/widgets/custom_dropdown_widget.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class createAssignProjectToCompanyPage extends StatefulWidget {
  const createAssignProjectToCompanyPage({Key? key}) : super(key: key);

  @override
  _createAssignProjectToCompanyPageState createState() =>
      _createAssignProjectToCompanyPageState();
}

class _createAssignProjectToCompanyPageState
    extends State<createAssignProjectToCompanyPage> {
  final url =
      "https://bkt-finance-app.s3.us-east-2.amazonaws.com/dpiupload/https%3A//bkt-finance-app.s3.us-east-2.amazonaws.com/dpiupload/Serenity%2520Homes-a147f2a0-a1ba-11ee-8201-d9a7f246635b..jpg";

  List<DropDownOption> companies = [
    DropDownOption(id: "1", label: "Hogar Selecto Realty"),
    DropDownOption(id: "2", label: "Urban Estates Group"),
    DropDownOption(id: "3", label: "Skyline Properties"),
    DropDownOption(id: "4", label: "Golden Gate Realty"),
    DropDownOption(id: "5", label: "Prime Living Investments"),
    DropDownOption(id: "6", label: "Cityscape Homes LLC"),
    DropDownOption(id: "7", label: "Metroplex Realty Solutions"),
    DropDownOption(id: "8", label: "Harborview Real Estate"),
    DropDownOption(id: "9", label: "Elite Residences Inc."),
    DropDownOption(id: "10", label: "ProFound Properties Group")
  ];

  @override
  Widget build(BuildContext context) {
    return Layout(
        sideBarList: [],
        appBar: CustomAppBarTitle(
          title: "Proyecto",
          rightActions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.add_circle))
          ],
        ),
        child: Column(
          children: [
            Center(
              child: Image.network(
                url,
                height: Get.height / 3,
              ),
            ),
            AutocompleteDropdownWidget(
              listItems: companies,
              onSelected: (p0) {},
              label: "Empresas",
              hintText: "Buscar Empresas",
              onFocusChange: ((p0) {}),
              onTextChange: (p0) async {
                return companies
                    .where((element) =>
                        element.label.toLowerCase().contains(p0.toLowerCase()))
                    .toList();
              },
            ),
          ],
        ));
  }
}
