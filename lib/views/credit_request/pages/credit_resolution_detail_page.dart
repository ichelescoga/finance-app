import "package:developer_company/shared/routes/router_paths.dart";
import "package:developer_company/shared/utils/http_adapter.dart";
import "package:developer_company/widgets/app_bar_title.dart";
import "package:developer_company/widgets/custom_button_widget.dart";
import "package:developer_company/widgets/layout.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:get/get.dart";

class CreditResolutionDetailPage extends StatefulWidget {
  const CreditResolutionDetailPage({Key? key}) : super(key: key);

  @override
  _CreditResolutionDetailPageState createState() =>
      _CreditResolutionDetailPageState();
}

class _CreditResolutionDetailPageState
    extends State<CreditResolutionDetailPage> {
  final Map<String, dynamic> arguments = Get.arguments;
  HttpAdapter httpAdapter = HttpAdapter();

  bool isAlreadySell = false;
  @override
  void initState() {
    super.initState();
    isAlreadySell = int.tryParse(arguments["statusId"]) == 3; //unitStatus unit_status
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        onBackFunction: (){
          if(isAlreadySell){
            Get.offAllNamed(RouterPaths.DASHBOARD_PAGE);
          }else{
            Get.back();
          }
        },
        sideBarList: [],
        appBar: CustomAppBarTitle(title: "Formalizar Venta"),
        child: SizedBox(
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              !isAlreadySell
                  ? CustomButtonWidget(
                      text: "Formalizar Venta",
                      onTap: () async {
                        try {
                          await httpAdapter.putApi(
                              "orders/v1/cotizacionVendida/${arguments["quoteId"]}",
                              {},
                              {});
                          EasyLoading.showSuccess(
                              "Formalización de venta procesada con éxito.");
                          isAlreadySell = true;
                        } catch (e) {
                          EasyLoading.showError("Algo Salio Mal");
                        }
                      })
                  : CustomButtonWidget(
                      text: "Ir Al Inicio",
                      onTap: () => Get.offAllNamed(RouterPaths.DASHBOARD_PAGE))
            ],
          ),
        ));
  }
}
