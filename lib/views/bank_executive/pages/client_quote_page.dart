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
import 'package:developer_company/shared/services/quetzales_currency.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';
import 'package:developer_company/views/bank_executive/pages/form_detail_client.dart';
import 'package:developer_company/views/credit_request/helpers/download_pdf.dart';
import 'package:developer_company/views/quotes/controllers/unit_detail_page_controller.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/widgets/app_bar_title.dart';
import 'package:developer_company/widgets/custom_button_widget.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:developer_company/widgets/send_email_quote_dart.dart';
import 'package:developer_company/widgets/send_whatssap_quote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

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
  String quoteId = "";

  void updateParentVariable(bool firstTime, String? appId) {
    final quoteStatus = arguments["quoteState"];

    if ((quoteStatus == 3 || quoteStatus == 6 || quoteStatus == 7)) {
      //unitStatus unit_status
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

  void _applyCredit() async {
    {
      if (_formKeyApplyQuote.currentState!.validate()) {
        final dpiValue = unitDetailPageController.detailDpi.text;

        final quoteId = arguments["quoteId"];
        final frontDpiBase64 = unitDetailPageController.frontDpi.base64;
        final needUpdateFrontDpi = unitDetailPageController.frontDpi.needUpdate;

        if (frontDpiBase64 != null && needUpdateFrontDpi) {
          final UploadImage frontDpiRequestImage = UploadImage(
              file: frontDpiBase64,
              fileName: "$dpiValue-front-$quoteId",
              transactionType: "frontDpiUpload");

          ImageToUpload responseImage =
              await uploadImageRepository.postImage(frontDpiRequestImage);
          final link = responseImage.link;
          unitDetailPageController.frontDpi.updateLink(link!);
        }

        final reverseDpiBase64 = unitDetailPageController.reverseDpi.base64;
        final needUpdateReverseDpi =
            unitDetailPageController.reverseDpi.needUpdate;

        if (reverseDpiBase64 != null && needUpdateReverseDpi) {
          final UploadImage reverseDpiRequestImage = UploadImage(
              file: reverseDpiBase64,
              fileName: "$dpiValue-reverse-$quoteId",
              transactionType: "reverseDpiUpload");

          ImageToUpload responseImage =
              await uploadImageRepository.postImage(reverseDpiRequestImage);
          final link = responseImage.link;
          unitDetailPageController.reverseDpi.updateLink(link!);
        }

        LoanApplication loanApplication = LoanApplication(
            idCotizacion: arguments['quoteId'].toString(),
            fotoDpiEnfrente: unitDetailPageController.frontDpi.link!,
            fotoDpiReverso: unitDetailPageController.reverseDpi.link!,
            estado: 2, //Estado inicializada
            empresa: unitDetailPageController.detailCompany.text,
            sueldo: extractNumber(unitDetailPageController.detailIncomes.text)!,
            fechaIngreso: unitDetailPageController.detailJobInDate.text,
            dpi: unitDetailPageController.detailDpi.text,
            nit: unitDetailPageController.detailNit.text,
            puesto: unitDetailPageController.detailKindJob.text,
            fechaNacimiento: unitDetailPageController.detailBirthday.text);

        try {
          EasyLoading.showToast(Strings.loading);
          if (isFirstTime) {
            await loanApplicationRepository
                .submitLoanApplication(loanApplication);
          } else {
            await loanApplicationRepository.updateLoanApplication(
                loanApplication, _applicationId.toString());
          }

          final body = {
            "idEstado": "2",
            "comentario": "",
          };
          await httpAdapter.putApi(
              "orders/v1/cotizacionUpdEstado/${arguments['quoteId'].toString()}",
              body, {});

          unitDetailPageController.cleanController();
          EasyLoading.showSuccess("Aplicación a crédito exitosa.");
          Get.toNamed(RouterPaths.DASHBOARD_PAGE);
        } catch (e) {
          EasyLoading.showError(Strings.pleaseVerifyInputs);
        } finally {
          EasyLoading.dismiss();
        }
      } else {
        EasyLoading.showError(Strings.pleaseVerifyInputs);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    quoteId = arguments["quoteId"].toString();
    // start();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      actionButton: _applicationId != null
          ? SpeedDial(
              animatedIcon: AnimatedIcons.menu_close,
              animatedIconTheme: IconThemeData(size: 22),
              backgroundColor: AppColors.blueColor,
              visible: true,
              curve: Curves.bounceIn,
              direction: SpeedDialDirection.left,
              children: [
                // FAB 1
                SpeedDialChild(
                    child: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    backgroundColor: AppColors.blueColor,
                    onTap: () => _showModalEmail(context),
                    labelBackgroundColor: AppColors.blueColor),
                // FAB 2
                SpeedDialChild(
                    child: Icon(
                      Icons.picture_as_pdf,
                      color: Colors.white,
                    ),
                    backgroundColor: AppColors.blueColor,
                    onTap: () => downloadPdf(quoteId),
                    labelBackgroundColor: AppColors.blueColor),
                SpeedDialChild(
                    child: Icon(Icons.message, color: Colors.white),
                    backgroundColor: AppColors.blueColor,
                    onTap: () => _showWhatsAppModal(context),
                    labelBackgroundColor: AppColors.blueColor)
              ],
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
              loanApplicationId: quoteId,
              updateEditMode: updateParentVariable,
              isEditMode: isEditMode,
            ),
            Row(
              children: [
                isEditMode
                    ? Expanded(
                        child: CustomButtonWidget(
                            text: "Aplicar a crédito",
                            onTap: () => _applyCredit()),
                      )
                    : Expanded(
                        child: CustomButtonWidget(
                        text: "Ir al Inicio",
                        onTap: () {
                          Get.offAllNamed(RouterPaths.DASHBOARD_PAGE);
                        },
                      )),
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

  _showWhatsAppModal(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((BuildContext context) {
          return SendWhatssapQuote(applicationId: quoteId.toString());
        }));
  }

  _showModalEmail(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((BuildContext context) {
          return SendEmailQuoteDart(quoteId: quoteId.toString());
        }));
  }
}
