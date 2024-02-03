import 'package:developer_company/data/implementations/CDI/cdi_repository_impl.dart';
import 'package:developer_company/data/models/image_model.dart';
import 'package:developer_company/data/providers/CDI/cdi_provider.dart';
import 'package:developer_company/data/repositories/CDI/cdi_repository.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/utils/handle_upload_image.dart';
import 'package:developer_company/utils/retrieve_form_list_controllers.dart';
import 'package:developer_company/widgets/CDI/dynamic_form.dart';
import 'package:developer_company/widgets/app_bar_title.dart';
import 'package:developer_company/widgets/custom_button_widget.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class CDIManagePage extends StatefulWidget {
  const CDIManagePage({Key? key}) : super(key: key);

  @override
  _CDIManagePageState createState() => _CDIManagePageState();
}

class _CDIManagePageState extends State<CDIManagePage> {
  // var uuid = Uuid();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> manageCDIFormKey = GlobalKey<FormState>();
  final Map<String, dynamic> arguments = Get.arguments;
  Map<String, TextEditingController> formControllers = {};
  Map<String, ImageToUpload> imageControllers = {};
  CDIRepository cdiRepository = CDIRepositoryImpl(CDIProvider());
  List<dynamic> formWidgets = [];
  String entityId = "";
  String editEndpoint = "";
  String addEndpoint = "";
  String principalLabel = "";
  String getByIdEndpoint = "";
  String? dataId;
  int activeStep = 0;
  double circleRadius = 20;

  _getFormCDI() async {
    final result = await cdiRepository.fetchDataTable(entityId);
    setState(() {
      formWidgets = result;
    });
  }

  _getImportantDataToCDI() async {
    entityId = arguments["entityId"].toString();
    editEndpoint = arguments["editEndpoint"];
    addEndpoint = arguments["addEndpoint"];
    principalLabel = arguments["principalLabel"];
    getByIdEndpoint = arguments["getByIdEndpoint"];
  }

  _handleSaveFormData(
      Map<String, dynamic> inputValues,
      Map<String, ImageToUpload> imageValues,
      Map<String, dynamic>
          dropdownValues //TODO: should be receive the dynamicInputDropDownValues;
      ) async {
    EasyLoading.show();
    final imagesResponse = await handleImagesToUpload(imageValues);
    bool result = false;

    if (dataId != null) {
      result = await cdiRepository.postData(
          editEndpoint, {"id": dataId, ...inputValues, ...imagesResponse});
    } else {
      result = await cdiRepository
          .postData(addEndpoint, {...inputValues, ...imagesResponse});
    }
    if (result) {
      Get.back(closeOverlays: true, result: result);
    }

    EasyLoading.dismiss();
  }

  @override
  void initState() {
    super.initState();
    _getImportantDataToCDI();
    _getFormCDI();
    if (arguments["dataId"] != null) {
      dataId = arguments["dataId"].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        sideBarList: [],
        appBar: CustomAppBarTitle(
          title: "Gestión de ${principalLabel}",
        ),
        child: Form(
          key: manageCDIFormKey,
          child: Column(
            children: [
              if (!formWidgets.length.isEqual(0))
                DynamicDatabaseForm(
                    callBackById: (p0) => cdiRepository.getDataById(
                        getByIdEndpoint, dataId.toString()),
                    imageControllers: imageControllers,
                    controllers: formControllers,
                    enable: true,
                    id: dataId,
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
                      if (manageCDIFormKey.currentState!.validate()) {
                        final inputValues = retrieveFormControllersInput(
                            formWidgets, formControllers);
                        final imageValues = retrieveFormControllersImage(
                            formWidgets, imageControllers);
                        _handleSaveFormData(inputValues, imageValues, {});
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
