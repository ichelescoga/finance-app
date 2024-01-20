import 'package:developer_company/controllers/manage_company_page_controller.dart';
import 'package:developer_company/data/implementations/CDI/cdi_repository_impl.dart';
import 'package:developer_company/data/implementations/company_repository_impl.dart';
import 'package:developer_company/data/implementations/upload_image_impl.dart';
// import 'package:developer_company/data/models/company_model.dart';
import 'package:developer_company/data/models/image_model.dart';
import 'package:developer_company/data/providers/CDI/cdi_provider.dart';
import 'package:developer_company/data/providers/company_provider.dart';
import 'package:developer_company/data/providers/upload_image.provider.dart';
import 'package:developer_company/data/repositories/CDI/cdi_repository.dart';
import 'package:developer_company/data/repositories/company_repository.dart';
import 'package:developer_company/data/repositories/upload_image_repository.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/utils/handle_upload_image.dart';
// import 'package:developer_company/utils/cdi_components.dart';
import 'package:developer_company/utils/retrieve_form_list_controllers.dart';
import 'package:developer_company/views/developer_company/forms/manage_company_form.dart';
import 'package:developer_company/widgets/app_bar_title.dart';
import 'package:developer_company/widgets/custom_button_widget.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CreateCompanyPage extends StatefulWidget {
  const CreateCompanyPage({Key? key}) : super(key: key);

  @override
  State<CreateCompanyPage> createState() => _CreateCompanyPageState();
}

class _CreateCompanyPageState extends State<CreateCompanyPage> {
  var uuid = Uuid();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  CreateCompanyPageController createCompanyPageController =
      Get.put(CreateCompanyPageController());
  final GlobalKey<FormState> manageCompanyFormKey = GlobalKey<FormState>();

  final CompanyRepository companyProvider =
      CompanyRepositoryImpl(CompanyProvider());
  UploadImageRepository uploadImageRepository =
      UploadImageRepositoryImpl(UploadImageProvider());
  final Map<String, dynamic> arguments = Get.arguments;

  Map<String, TextEditingController> formControllers = {};
  Map<String, ImageToUpload> imageControllers = {};

  CDIRepository cdiRepository = CDIRepositoryImpl(CDIProvider());

  List<dynamic> formWidgets = [];

  _getFormCompany() async {
    final result = await cdiRepository.fetchCompanyTable();
    setState(() {
      formWidgets = result;
    });
  }

  int? companyId;
  int activeStep = 0;
  double circleRadius = 20;

  @override
  void initState() {
    super.initState();
    _getFormCompany();
    if (arguments["companyId"] != null) {
      companyId = arguments["companyId"];
    }
  }

  // Future saveImage(ImageToUpload imageController) async {
  //   final uid = uuid.v1();
  //   final developerLogoBase64 =
  //       createCompanyPageController.developerCompanyLogo.base64;
  //   final needUpdateLogo =
  //       createCompanyPageController.developerCompanyLogo.needUpdate;

  //   if (developerLogoBase64 != null && needUpdateLogo) {
  //     String developerName = createCompanyPageController
  //                 .developerCompanyLogo.originalName !=
  //             null
  //         ? createCompanyPageController.developerCompanyLogo.originalName!
  //         : "${createCompanyPageController.developerCompanyName.text}-${uid}${createCompanyPageController.developerCompanyLogo.extension}";

  //     final UploadImage logoRequestImage = UploadImage(
  //         file: developerLogoBase64,
  //         fileName: developerName,
  //         transactionType: "developerLogo");

  //     ImageToUpload responseImage =
  //         await uploadImageRepository.postImage(logoRequestImage);
  //     final link = responseImage.link;
  //     createCompanyPageController.developerCompanyLogo.updateLink(link!);
  //   }
  // }

  _handleSaveCompany(
      Map<String, dynamic> inputValues,
      Map<String, ImageToUpload> imageValues,
      Map<String, dynamic>
          dropdownValues //TODO: should be receive the dynamicInputDropDownValues;

      ) async {
    print("inputValues ${inputValues}");
    print(imageValues);
    handleImagesToUpload(imageValues);

    // EasyLoading.show();
    // await saveImage();
    // if (createCompanyPageController.developerCompanyLogo.link == null) {
    //   EasyLoading.showInfo("Algo salio mal al subir la imagen");
    //   throw new Exception("Something bad wrongs to upload image");
    // }

    // Company companyData = Company(
    //   businessName: createCompanyPageController.developerCompanyName.text,
    //   description: createCompanyPageController.developerCompanyDescription.text,
    //   developer: createCompanyPageController.developerCompanyDeveloper.text,
    //   nit: createCompanyPageController.developerCompanyNit.text,
    //   address: createCompanyPageController.developerCompanyAddress.text,
    //   contact: createCompanyPageController.developerCompanyContactName.text,
    //   contactPhone:
    //       createCompanyPageController.developerCompanyContactPhone.text,
    //   salesManager:
    //       createCompanyPageController.developerCompanySellManager.text,
    //   managerPhone:
    //       createCompanyPageController.developerCompanySellManagerPhone.text,
    //   logo: createCompanyPageController.developerCompanyLogo.link!,
    // );

    // bool result = false;
    // if (companyId != null) {
    //   result = await companyProvider.editCompany(companyId!, companyData);
    // } else {
    //   result = await companyProvider.createCompany(companyData);
    // }
    // if (result) {
    //   Get.back(closeOverlays: true, result: result);
    // }

    // 'nombre': businessName,
    // 'descripcion': description,
    // 'createdby': createdAt.toIso8601String(),
    // "updatedby": updatedAt.toIso8601String(),
    // 'desarrollador': developer,
    // 'nit': nit,
    // 'direccion': address,
    // 'contacto': contact,
    // 'telefonocontacto': contactPhone,
    // 'gerenteventas': salesManager,
    // 'telefonogerenteventas': managerPhone,
    // 'logo': logo,
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        sideBarList: [],
        appBar: CustomAppBarTitle(
          title: "Gestión empresas",
        ),
        child: Form(
          key: manageCompanyFormKey,
          child: Column(
            children: [
              if (!formWidgets.length.isEqual(0))
                ManageCompanyForm(
                    imageControllers: imageControllers,
                    controllers: formControllers,
                    enable: true,
                    companyId: companyId,
                    formCustomWidgets: formWidgets),
              const SizedBox(
                height: Dimensions.heightSize,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CustomButtonWidget(
                        padding: EdgeInsets.zero,
                        text: "Atrás",
                        onTap: () => Navigator.pop(context, false)),
                  ),
                  const SizedBox(width: Dimensions.formSpaceBetweenButtons),
                  Expanded(
                      child: CustomButtonWidget(
                    padding: EdgeInsets.zero,
                    color: AppColors.blueColor,
                    text: "Guardar",
                    onTap: () {
                      print('manage_company_page 154  ${formControllers}');

                      final inputValues = retrieveFormControllersInput(
                          formWidgets, formControllers);
                      final imageValues = retrieveFormControllersImage(
                          formWidgets, imageControllers);

                      // print(
                      //     '🤖 🤖 manage_company_page 193 inputValues ${inputValues}');
                      // print(
                      //     '🤖 🤖 manage_company_page 194 imageValues ${imageValues}');

                      if (manageCompanyFormKey.currentState!.validate()) {
                        _handleSaveCompany(inputValues, imageValues, {});
                      } else {
                        EasyLoading.showInfo(
                            "Por favor verifique que los campos sean validos.");
                      }
                    },
                  )),
                ],
              ),
              const SizedBox(
                height: Dimensions.heightSize,
              ),
            ],
          ),
        ));
  }
}
