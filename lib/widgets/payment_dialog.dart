import 'package:developer_company/client-controllers/payment_controller.dart';
import 'package:developer_company/client_rest_api/api/payment_resources_api.dart';
// import 'package:developer_company/client_rest_api/models/payments/resources_payment_model.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/validations/image_button_validator.dart';
// import 'package:developer_company/shared/validations/not_empty.dart';
import 'package:developer_company/widgets/autocomplete_dropdown.dart';
import 'package:developer_company/widgets/custom_dropdownv2_widget.dart';
import 'package:developer_company/widgets/custom_input_widget.dart';
import 'package:developer_company/widgets/custom_label_widget.dart';
import 'package:developer_company/widgets/elevated_custom_button.dart';
import 'package:developer_company/widgets/upload_button_widget.dart';
// import "package:developer_company/widgets/custom_dropdown_widget.dart";

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentDialog extends StatefulWidget {
  final ClientPaymentController paymentController;
  PaymentDialog({
    required this.paymentController,
    Key? key,
  }) : super(key: key);

  @override
  _PaymentDialogState createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  final _form = GlobalKey<FormState>();
  final PaymentResourcesAPI _paymentResource = PaymentResourcesAPI();
  List<DropDownOption> banks = [];
  List<DropDownOption> paymentTypes = [];
  bool isLoading = false;

  retrieveResources() async {
    final banksFetch = await _paymentResource.fetchBanks();
    final paymentTypesFetch = await _paymentResource.fetchPaymentTypes();

    banks = banksFetch
        .map((b) => DropDownOption(id: b.id.toString(), label: b.name))
        .toList();
    paymentTypes = paymentTypesFetch
        .map((p) => DropDownOption(id: p.id, label: p.name))
        .toList();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    retrieveResources();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.officialWhite,
      title: Text("Agregar pago"),
      content: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          child: Form(
            key: _form,
            child: Column(
              children: [
                CustomInputWidget(
                    controller: widget.paymentController.reference,
                    label: "Referencia",
                    hintText: "Ref13434",
                    prefixIcon: Icons.numbers),
                CustomDropdownV2Widget(
                  labelText: 'Seleccione uno',
                  hintText: 'Escoja uno',
                  items: banks,
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor escoja uno';
                    }
                    return null;
                  },
                  prefixIcon: const Icon(Icons.account_balance),
                  textEditingController:
                      widget.paymentController.bank, // Pass the controller here
                  onValueChanged: (value) {
                    setState(() {
                      // selectedValue = value;
                    });
                  },
                ),
                CustomDropdownV2Widget(
                  labelText: 'Seleccione uno',
                  hintText: 'Escoja uno',
                  items: paymentTypes,
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor escoja uno';
                    }
                    return null;
                  },
                  prefixIcon: const Icon(Icons.attach_money),
                  textEditingController: widget.paymentController
                      .paymentType, // Pass the controller here
                  onValueChanged: (value) {
                    setState(() {
                      // selectedValue = value;
                    });
                  },
                ),
                LogoUploadWidget(
                    icon: Icon(
                      Icons.receipt,
                      color: Colors.white,
                    ),
                    uploadImageController: widget.paymentController.evidenceUrl,
                    text: "Imagen",
                    validator: (value) => imageButtonValidator(value,
                        validationText: "Imagen es requerida.")),
                CustomLabelWidget(
                  title: "Monto a pagar",
                  label: "Q.90000.00",
                  prefixIcon: Icons.monetization_on,
                )
              ],
            ),
          ),
        ),
      ),
      actions: [
        ElevatedCustomButton(
          color: AppColors.softMainColor,
          text: "Guardar",
          isLoading: false,
          onPress: () {
            // IMPLEMENT PAYMENT SERVICE POST
            //     final linkResponse = await saveImage(value);

            print(widget.paymentController.bank.text);
            print(widget.paymentController.paymentType.text);
          },
        ),
        ElevatedCustomButton(
          color: AppColors.secondaryMainColor,
          text: "Cerrar",
          isLoading: false,
          onPress: () => Navigator.pop(context, false),
        )
      ],
    );
  }
}
