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
  double totalPayment = 0;
  String? quoteId;

  @override
  void initState() {
    super.initState();
    payments = arguments["payments"] as List<ClientPaymentModel>;
    quoteId = arguments["quoteId"];
    leftRightAnimationScrollView(_scrollController, 2);
    checkboxes = List.generate(payments.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        sideBarList: [],
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // actionButton: totalPayment == 0
        //     ? null
        //     : FloatingActionButton(
        //         backgroundColor: AppColors.softMainColor,
        //         tooltip: 'Subir comprobante',
        //         onPressed: () {
        //           _paymentDialog(context, totalPayment, "");
        //         },
        //         child: const Icon(Icons.receipt,
        //             color: AppColors.officialWhite, size: 28),
        //       ),
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
                  // CustomCheckbox(  //! COMMENTED because in the future the client would be multiple payments
                  //   selectedColor: AppColors.secondaryMainColor,
                  //   unSelectedColor: AppColors.officialWhite,
                  //   checkColor: AppColors.officialWhite,
                  //   value: checkboxes.every((value) => value == true),
                  //   onChanged: (value) {
                  //     checkboxes = List.generate(checkboxes.length, (index) {
                  //       if (!value == true) {
                  //         totalPayment = double.parse(payments[index].amount) +
                  //             totalPayment;
                  //       } else {
                  //         totalPayment = 0;
                  //       }
                  //       return !value;
                  //     });

                  //     setState(() {});
                  //   },
                  // ),
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
                            // DataCell(CheckBoxPayments( //! COMMENTED because in the future the client would be multiple payments
                            //   isMarkCheck: checkboxes[index],
                            //   onChanged: (value) {
                            //     setState(() {
                            //       if (!value == true) {
                            //         totalPayment =
                            //             double.parse(element.amount) +
                            //                 totalPayment;
                            //       } else {
                            //         totalPayment = totalPayment -
                            //             double.parse(element.amount);
                            //       }
                            //       checkboxes[index] = !value;
                            //     });
                            //   },
                            // )),
                            DataCell(Text(element.type)),
                            DataCell(Text(element.status)),
                            DataCell(Text(element.amount)),
                            DataCell(IconButton(
                              icon: Icon(Icons.receipt),
                              onPressed: () => {
                                _paymentDialog(context,
                                    double.parse(element.amount), quoteId!)
                              },
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

  _paymentDialog(BuildContext context, double paymentAmount, String quoteId) {
    return showDialog(
        context: context,
        builder: (context) {
          return PopScope(
              canPop: false,
              child: PaymentDialog(
                quoteId: quoteId,
                payment: paymentAmount,
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
