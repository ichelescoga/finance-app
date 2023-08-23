import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/widgets/app_bar_title.dart";
import "package:developer_company/widgets/data_table.dart";
import "package:developer_company/widgets/layout.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class Simulation {
  final String client;
  final String unit;
  final double sellPrice;
  final double priceToPay;
  final String executive;

  Simulation({
    required this.client,
    required this.unit,
    required this.sellPrice,
    required this.priceToPay,
    required this.executive,
  });
} //! TEMP REMOVE WHEN DATA REAL PLEASE

class AnalystListCredits extends StatefulWidget {
  const AnalystListCredits({Key? key}) : super(key: key);

  @override
  _AnalystListCreditsState createState() => _AnalystListCreditsState();
}

class _AnalystListCreditsState extends State<AnalystListCredits> {
  final appColors = AppColors();
  final _scrollController = ScrollController();

  final List<Simulation> simulations = [
    Simulation(
      client: 'Jose Perez',
      unit: "Apartamento 4",
      sellPrice: 200000.0,
      priceToPay: 180000.0,
      executive: "Juan Carlos",
    ),
    Simulation(
      client: 'Ana Quinoleo',
      unit: "Apartamento 5",
      sellPrice: 300000.0,
      priceToPay: 250000.0,
      executive: "Pedro Quinoa",
    ),
    // Add more Simulation instances as needed
  ];

  void _onRowTap(Simulation simulation) {
    print('Selected simulation: ${simulation.executive}');
    // You can perform further actions using the selected Simulation object
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController
          .animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOut,
      )
          .then((_) {
        _scrollController.animateTo(
          0,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        sideBarList: const [],
        appBar:
            const CustomAppBarTitle(title: "Listado de aplicaciones a crédito"),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          child: CustomDataTable<Simulation>(
            columns: const [
              'Cliente',
              'Unidad',
              'Precio de venta',
              'Total Saldo A financiar',
              'Ejecutivo'
            ],
            elements: simulations
                .asMap()
                .map((index, element) => MapEntry(
                    index,
                    DataRow(
                      onSelectChanged: (value) {
                        // print(element.month);
                        // print(element.creditTotalBalance);
                      },
                      cells: [
                        DataCell(Container(
                          constraints: BoxConstraints(maxWidth: Get.width / 3),
                          child: Text(element.client),
                        )),
                        DataCell(Container(
                          constraints: BoxConstraints(maxWidth: Get.width / 3),
                          child: Text(element.unit),
                        )),
                        DataCell(Container(
                          constraints: BoxConstraints(maxWidth: Get.width / 3),
                          child: Text(element.sellPrice.toString()),
                        )),
                        DataCell(Container(
                          constraints: BoxConstraints(maxWidth: Get.width / 3),
                          child: Text(element.priceToPay.toString()),
                        )),
                        DataCell(Container(
                          constraints: BoxConstraints(maxWidth: Get.width / 3),
                          child: Text(element.executive),
                        )),
                      ],
                      color: appColors.dataRowColors(index),
                    )))
                .values
                .toList(),
          ),
        ));
  }
}
