import "dart:convert";

import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/resources/dimensions.dart";
import "package:developer_company/shared/utils/http_adapter.dart";
import "package:developer_company/shared/validations/not_empty.dart";
import "package:developer_company/widgets/custom_button_widget.dart";
import "package:developer_company/widgets/custom_input_widget.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:get/get.dart";
import "package:url_launcher/url_launcher.dart";

class SendWhatssapQuote extends StatefulWidget {
  final String applicationId;
  const SendWhatssapQuote({Key? key, required this.applicationId})
      : super(key: key);

  @override
  _SendWhatssapQuoteState createState() => _SendWhatssapQuoteState();
}

class _SendWhatssapQuoteState extends State<SendWhatssapQuote> {
  TextEditingController commentController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final _formKeyComments = GlobalKey<FormState>();

  HttpAdapter httpAdapter = HttpAdapter();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        height: Get.height / 2.5,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKeyComments,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("¿Enviar Cotización de crédito?",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: Dimensions.extraLargeTextSize,
                        overflow: TextOverflow.ellipsis,
                      )),
                  CustomInputWidget(
                      controller: phoneController,
                      validator: (value) {
                        if (value!.length != 8) {
                          return "Teléfono no valido";
                        }
                        return null;
                      },
                      label: "Teléfono",
                      hintText: "Teléfono",
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.comment),
                  CustomInputWidget(
                      controller: commentController,
                      validator: (value) => notEmptyFieldValidator(value),
                      label: "Comentarios Extra",
                      hintText: "Comentarios Extra",
                      prefixIcon: Icons.comment),
                  Row(
                    children: [
                      Expanded(
                          child: CustomButtonWidget(
                              color: AppColors.blueColor,
                              text: "Enviar",
                              onTap: () async {
                                if (_formKeyComments.currentState!.validate()) {
                                  final response = await httpAdapter.postApi(
                                      "orders/v1/cotizacionPdf/${widget.applicationId}",
                                      {},
                                      {});

                                  if (response.statusCode != 200) {
                                    EasyLoading.showError(
                                        "Cotización no pudo ser generada.");
                                    return;
                                  }

                                  final responseBody =
                                      json.decode(response.body);
                                  final url = responseBody['body'];
                                  String phoneNumber =
                                      "+502${phoneController.text}";
                                  String text =
                                      "${commentController.text} \n $url";

                                  final whatsAppURlAndroid =
                                      "whatsapp://send?phone=" +
                                          phoneNumber +
                                          "&text=$text";
                                  await launchUrl(
                                      Uri.parse(whatsAppURlAndroid));

                                  EasyLoading.showSuccess(
                                      "Cotización Enviada con éxito");

                                  Navigator.of(context).pop();
                                }
                              })),
                      Expanded(
                          child: CustomButtonWidget(
                              text: "Regresar",
                              onTap: () => Navigator.of(context).pop()))
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
