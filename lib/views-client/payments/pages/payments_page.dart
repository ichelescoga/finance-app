import 'package:developer_company/client-controllers/payment_controller.dart';
import 'package:developer_company/client_rest_api/models/payments/client_payment_model.dart';
import 'package:developer_company/shared/animations/left_rigth_animation_scrollView.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/custom_style.dart';
import 'package:developer_company/widgets/app_bar_title.dart';
import 'package:developer_company/widgets/custom_checkBox_widget.dart';
import 'package:developer_company/widgets/data_table.dart';
import 'package:developer_company/widgets/filter_box.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:developer_company/widgets/payment_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({Key? key}) : super(key: key);

  @override
  _PaymentsPageState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  List<ClientPaymentModel> payments = [];
  final Map<String, dynamic> arguments = Get.arguments;
  AppColors appColors = AppColors();
  final _scrollController = ScrollController();
  bool markAll = false;
  ClientPaymentController paymentController = ClientPaymentController();
  List<bool> checkboxes = [];

  @override
  void initState() {
    super.initState();
    payments = arguments["payments"] as List<ClientPaymentModel>;
    leftRightAnimationScrollView(_scrollController, 2);
    checkboxes = List.generate(payments.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        sideBarList: [],
        appBar: CustomAppBarTitle(
          title: "Pagos",
        ),
        child: Column(
          children: [
            FilterBox(
                elements: [],
                handleFilteredData: (p0) => {},
                isLoading: false,
                hint: "Buscar",
                label: "Buscar"),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: CustomDataTable(
                columns: [],
                isHeaderWidgets: true,
                headerWidgets: [
                  CustomCheckbox(
                    selectedColor: AppColors.secondaryMainColor,
                    unSelectedColor: AppColors.officialWhite,
                    checkColor: AppColors.officialWhite,
                    value: checkboxes.every((value) => value == true),
                    onChanged: (value) {
                      print(value);
                      checkboxes =
                          List.generate(checkboxes.length, (index) => !value);
                      setState(() {});
                    },
                  ),
                  Text("Tipo", style: CustomStyle.tableHeader),
                  Text("Estado", style: CustomStyle.tableHeader),
                  Text("Monto", style: CustomStyle.tableHeader),
                  Text("")
                ],
                elements: payments
                    .asMap()
                    .map((index, element) => MapEntry(
                        index,
                        DataRow(
                          cells: [
                            DataCell(CheckBoxPayments(
                              isMarkCheck: checkboxes[index],
                              onChanged: (value) {
                                setState(() {
                                  checkboxes[index] = !value;
                                });
                              },
                            )),
                            DataCell(Text(element.type)),
                            DataCell(Text(element.status)),
                            DataCell(Text(element.amount)),
                            DataCell(IconButton(
                              icon: Icon(Icons.abc_rounded),
                              onPressed: () => {_paymentDialog(context)},
                            ))
                          ],
                          color: appColors.dataRowColors(index),
                        )))
                    .values
                    .toList(),
              ),
            )
          ],
        ));
  }

  _paymentDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return PopScope(
              canPop: false,
              child: PaymentDialog(
                paymentController: paymentController,
              ));
        }).then((result) {
      if (result == true) {
        return;
      }
    });
  }
}

class CheckBoxPayments extends StatefulWidget {
  final bool isMarkCheck;
  final ValueChanged<bool>? onChanged;

  const CheckBoxPayments({
    required this.isMarkCheck,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  _CheckBoxPayments createState() => _CheckBoxPayments();
}

class _CheckBoxPayments extends State<CheckBoxPayments> {
  @override
  Widget build(BuildContext context) {
    return CustomCheckbox(
      selectedColor: AppColors.secondaryMainColor,
      unSelectedColor: AppColors.secondaryMainColor,
      checkColor: AppColors.secondaryMainColor,
      value: widget.isMarkCheck,
      onChanged: widget.onChanged,
    );
  }
}
