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
// import 'package:developer_company/views/developer_company/forms/manage_company_form.dart';
import 'package:developer_company/widgets/CDI/dynamic_form.dart';
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

  _handleSaveCompany(
      Map<String, dynamic> inputValues,
      Map<String, ImageToUpload> imageValues,
      Map<String, dynamic>
          dropdownValues //TODO: should be receive the dynamicInputDropDownValues;
      ) async {
    EasyLoading.show();
    final imagesResponse = await handleImagesToUpload(imageValues);
    bool result = false;

    if (companyId != null) {
      result = await cdiRepository.postData("orders/v1/editCompany",
          {"id": companyId, ...inputValues, ...imagesResponse});
    } else {
      result = await cdiRepository
          .postData("orders/v1/addCompany", {...inputValues, ...imagesResponse});
    }
    if (result) {
      Get.back(closeOverlays: true, result: result);
    }
  
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
                DynamicDatabaseForm(
                    callBackById: (p0) => companyProvider.getCompanyById(companyId!),
                    imageControllers: imageControllers,
                    controllers: formControllers,
                    enable: true,
                    id: companyId,
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
                      if (manageCompanyFormKey.currentState!.validate()) {
                        final inputValues = retrieveFormControllersInput(
                            formWidgets, formControllers);
                        final imageValues = retrieveFormControllersImage(
                            formWidgets, imageControllers);
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
