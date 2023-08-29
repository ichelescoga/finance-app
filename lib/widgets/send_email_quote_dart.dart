import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/resources/dimensions.dart";
import "package:developer_company/shared/validations/email_validator.dart";
import "package:developer_company/shared/validations/not_empty.dart";
import "package:developer_company/views/credit_request/helpers/send_email.dart";
import "package:developer_company/widgets/custom_button_widget.dart";
import "package:developer_company/widgets/custom_input_widget.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class SendEmailQuoteDart extends StatefulWidget {
  final String quoteId;
  const SendEmailQuoteDart({Key? key, required this.quoteId}) : super(key: key);

  @override
  State<SendEmailQuoteDart> createState() => _SendEmailQuoteDartState();
}

class _SendEmailQuoteDartState extends State<SendEmailQuoteDart> {
  TextEditingController commentController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  final _formKeyComments = GlobalKey<FormState>();

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
                      controller: subjectController,
                      validator: (value) => emailValidator(value),
                      label: "Correo Electrónico",
                      hintText: "Correo Electrónico",
                      keyboardType: TextInputType.emailAddress,
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
                              onTap: () {
                                if (_formKeyComments.currentState!.validate()) {
                                  sendEmail(
                                      commentController.text,
                                      subjectController.text,
                                      widget.quoteId,
                                      context);
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
