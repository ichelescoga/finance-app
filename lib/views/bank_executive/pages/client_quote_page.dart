import 'dart:convert';

import 'package:developer_company/data/implementations/loan_application_repository_impl.dart';
import 'package:developer_company/data/implementations/upload_image_impl.dart';
import 'package:developer_company/data/models/image_model.dart';
import 'package:developer_company/data/models/loan_application_model.dart';
import 'package:developer_company/data/providers/loan_application_provider.dart';
import 'package:developer_company/data/providers/upload_image.provider.dart';
import 'package:developer_company/data/repositories/loan_application_repository.dart';
import 'package:developer_company/data/repositories/upload_image_repository.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';
import 'package:developer_company/shared/validations/not_empty.dart';
// import 'package:developer_company/shared/validations/image_button_validator.dart';
import 'package:developer_company/views/bank_executive/pages/form_detail_client.dart';
import 'package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/widgets/app_bar_title.dart';
import 'package:developer_company/widgets/custom_button_widget.dart';
import 'package:developer_company/widgets/custom_input_widget.dart';

import 'package:developer_company/widgets/layout.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientQuotePage extends StatefulWidget {
  const ClientQuotePage({Key? key}) : super(key: key);

  @override
  State<ClientQuotePage> createState() => _ClientQuotePageState();
}

class _ClientQuotePageState extends State<ClientQuotePage> {
  final GlobalKey<FormState> _formKeyApplyQuote = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UnitDetailPageController unitDetailPageController =
      Get.put(UnitDetailPageController());
  final Map<String, dynamic> arguments = Get.arguments;
  bool isEditMode = true;
  bool isFirstTime = true;
  String? _applicationId;
  int actualYear = DateTime.now().year;

  UploadImageRepository uploadImageRepository =
      UploadImageRepositoryImpl(UploadImageProvider());

  LoanApplicationRepository loanApplicationRepository =
      LoanApplicationRepositoryImpl(LoanApplicationProvider());

  HttpAdapter httpAdapter = HttpAdapter();

  void updateParentVariable(bool firstTime, String? appId) {
    final quoteStatus = arguments["quoteState"];

    if ((quoteStatus == 3 || quoteStatus == 6 || quoteStatus == 7)) {
      setState(() {
        isEditMode = false;
        isFirstTime = false;
        _applicationId = appId;
      });
    } else {
      setState(() {
        isEditMode = true;
        isFirstTime = true;
        _applicationId = appId;
      });
    }
  }

  // void start() {
  //   final quoteStatus = arguments["quoteState"];
  //   if (quoteStatus == 3 || quoteStatus == 6 || quoteStatus == 7) {
  //     setState(() {
  //       isEditMode = false;
  //       isFirstTime = false;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // start();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      actionButton: _applicationId != null
          ? FloatingActionButton(
              onPressed: () {
                _showModalSendWhatsApp(context);
              },
              child: const Icon(Icons.picture_as_pdf),
              backgroundColor: AppColors.softMainColor,
            )
          : null,
      sideBarList: const [],
      appBar: const CustomAppBarTitle(title: 'Detalle de cotización'),
      child: Form(
        key: _formKeyApplyQuote,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormDetailClient(
              loanApplicationId: arguments["quoteId"].toString(),
              updateEditMode: updateParentVariable,
              isEditMode: isEditMode,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButtonWidget(
                      text: "Aplicar a crédito",
                      onTap: () async {
                        if (_formKeyApplyQuote.currentState!.validate()) {
                          final dpiValue =
                              unitDetailPageController.detailDpi.text;

                          final quoteId = arguments["quoteId"];
                          final frontDpiBase64 =
                              unitDetailPageController.frontDpi.base64;
                          final needUpdateFrontDpi =
                              unitDetailPageController.frontDpi.needUpdate;

                          if (frontDpiBase64 != null && needUpdateFrontDpi) {
                            final UploadImage frontDpiRequestImage =
                                UploadImage(
                                    file: frontDpiBase64,
                                    fileName: "$dpiValue-front-$quoteId",
                                    transactionType: "frontDpiUpload");

                            ImageToUpload responseImage =
                                await uploadImageRepository
                                    .postImage(frontDpiRequestImage);
                            final link = responseImage.link;
                            unitDetailPageController.frontDpi.updateLink(link!);
                          }

                          final reverseDpiBase64 =
                              unitDetailPageController.reverseDpi.base64;
                          final needUpdateReverseDpi =
                              unitDetailPageController.reverseDpi.needUpdate;

                          if (reverseDpiBase64 != null &&
                              needUpdateReverseDpi) {
                            final UploadImage reverseDpiRequestImage =
                                UploadImage(
                                    file: reverseDpiBase64,
                                    fileName: "$dpiValue-reverse-$quoteId",
                                    transactionType: "reverseDpiUpload");

                            ImageToUpload responseImage =
                                await uploadImageRepository
                                    .postImage(reverseDpiRequestImage);
                            final link = responseImage.link;
                            unitDetailPageController.reverseDpi
                                .updateLink(link!);
                          }

                          LoanApplication loanApplication = LoanApplication(
                            idCotizacion: arguments['quoteId'].toString(),
                            fotoDpiEnfrente:
                                unitDetailPageController.frontDpi.link!,
                            fotoDpiReverso:
                                unitDetailPageController.reverseDpi.link!,
                            estado: 2, //Estado inicializada
                            empresa:
                                unitDetailPageController.detailCompany.text,
                            sueldo: unitDetailPageController.detailIncomes.text,
                            fechaIngreso:
                                unitDetailPageController.detailJobInDate.text,
                            dpi: unitDetailPageController.detailDpi.text,
                            nit: unitDetailPageController.detailNit.text,
                          );

                          try {
                            EasyLoading.showToast(Strings.loading);
                            if (isFirstTime) {
                              await loanApplicationRepository
                                  .submitLoanApplication(loanApplication);
                            } else {
                              await loanApplicationRepository
                                  .updateLoanApplication(loanApplication,
                                      _applicationId.toString());
                            }

                            final body = {
                              "idEstado": "2",
                              "comentario": "",
                            };
                            await httpAdapter.putApi(
                                "orders/v1/cotizacionUpdEstado/${arguments['quoteId'].toString()}",
                                body, {});

                            unitDetailPageController.cleanController();
                            EasyLoading.showSuccess(
                                "Aplicación a crédito exitosa.");
                            Get.toNamed(RouterPaths.DASHBOARD_PAGE);
                          } catch (e) {
                            EasyLoading.showError(Strings.pleaseVerifyInputs);
                          } finally {
                            EasyLoading.dismiss();
                          }
                        } else {
                          EasyLoading.showError(Strings.pleaseVerifyInputs);
                        }
                      }),
                ),
                Expanded(
                  child: CustomButtonWidget(
                      text: Strings.goBack,
                      onTap: () {
                        Get.back(closeOverlays: true);
                      }),
                )
              ],
            ),
            const SizedBox(height: Dimensions.heightSize * 3),
          ],
        ),
      ),
    );
  }

  _showModalSendWhatsApp(BuildContext context) {
    TextEditingController commentController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    final _formKeyComments = GlobalKey<FormState>();

    return showDialog(
        context: context,
        builder: ((BuildContext context) {
          return Center(
            child: Container(
              color: Colors.white,
              height: Get.height / 3,
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
                                      if (_formKeyComments.currentState!
                                          .validate()) {
                                        print('FAB pressed $_applicationId');

                                        final response = await httpAdapter.postApi(
                                            "orders/v1/cotizacionPdf/$_applicationId",
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
        }));
  }
}
