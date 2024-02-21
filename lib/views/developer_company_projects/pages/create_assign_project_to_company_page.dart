import 'package:developer_company/controllers/cdi_check_button_controller.dart';
import 'package:developer_company/data/implementations/CDI/cdi_repository_impl.dart';
import 'package:developer_company/data/implementations/project__repository_impl.dart';
import 'package:developer_company/data/models/image_model.dart';
import 'package:developer_company/data/providers/CDI/cdi_provider.dart';
import 'package:developer_company/data/providers/project_provider.dart';
import 'package:developer_company/data/repositories/CDI/cdi_repository.dart';
import 'package:developer_company/data/repositories/project_repository.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
// import 'package:developer_company/utils/handle_upload_image.dart';
import 'package:developer_company/utils/retrieve_form_list_controllers.dart';
import 'package:developer_company/widgets/CDI/dynamic_form.dart';
import 'package:developer_company/widgets/app_bar_title.dart';
// import 'package:developer_company/widgets/autocomplete_dropdown.dart';
import 'package:developer_company/widgets/custom_button_widget.dart';
// import 'package:developer_company/widgets/custom_dropdown_widget.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class createAssignProjectToCompanyPage extends StatefulWidget {
  const createAssignProjectToCompanyPage({Key? key}) : super(key: key);

  @override
  _createAssignProjectToCompanyPageState createState() =>
      _createAssignProjectToCompanyPageState();
}

class _createAssignProjectToCompanyPageState
    extends State<createAssignProjectToCompanyPage> {
  var uuid = Uuid();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> manageCompanyFormKey = GlobalKey<FormState>();

  final Map<String, dynamic> arguments = Get.arguments;

  Map<String, TextEditingController> formControllers = {};
  Map<String, ImageToUpload> imageControllers = {};
  Map<String, CDICheckController> checkControllers = {};


  CDIRepository cdiRepository = CDIRepositoryImpl(CDIProvider());

  List<dynamic> formWidgets = [];

  ProjectRepository projectProvider = ProjectRepositoryImpl(ProjectProvider());

  _getFormCompany() async {
    final String PROJECT_ENTITY = "2";
    final result = await cdiRepository.fetchDataTable(PROJECT_ENTITY);
    setState(() {
      formWidgets = result;
    });
  }

  int? projectId;
  int activeStep = 0;
  double circleRadius = 20;

  @override
  void initState() {
    super.initState();
    _getFormCompany();
    if (arguments["dataId"] != null) {
      projectId = arguments["dataId"];
    }
  }

  _handleSaveCompany(
      Map<String, dynamic> inputValues,
      Map<String, ImageToUpload> imageValues,
      Map<String, dynamic>
          dropdownValues //TODO: should be receive the dynamicInputDropDownValues;
      ) async {
    EasyLoading.show();
    // final imagesResponse = await handleImagesToUpload(imageValues);
    // bool result = false;

    // if (projectId != null) {
    //   result = await cdiRepository.postData("orders/v1/editCompany",
    //       {"id": projectId, ...inputValues, ...imagesResponse});
    // } else {
    //   result = await cdiRepository
    //       .postData("orders/v1/addCompany", {...inputValues, ...imagesResponse});
    // }
    // if (result) {
    //   Get.back(closeOverlays: true, result: result);
    // }

    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        sideBarList: [],
        appBar: CustomAppBarTitle(
          title: "Gestión proyecto",
        ),
        child: Form(
          key: manageCompanyFormKey,
          child: Column(
            children: [
              if (!formWidgets.length.isEqual(0))
                DynamicDatabaseForm(
                    callBackById: (p0) => projectProvider
                        .getProjectById(projectId.toString()),
                    imageControllers: imageControllers,
                    checkControllers: checkControllers,
                    controllers: formControllers,
                    enable: true,
                    id: projectId.toString(),
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
