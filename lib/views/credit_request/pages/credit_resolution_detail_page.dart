import "package:developer_company/data/implementations/buyer_respository_impl.dart";
import "package:developer_company/data/models/buyer_model.dart";
import "package:developer_company/data/providers/buyer_provider.dart";
import "package:developer_company/data/repositories/buyer_repository.dart";
import "package:developer_company/shared/resources/dimensions.dart";
import "package:developer_company/shared/resources/strings.dart";
import "package:developer_company/shared/routes/router_paths.dart";
import "package:developer_company/shared/services/pdf_download_share.dart";
import "package:developer_company/shared/services/quetzales_currency.dart";
import "package:developer_company/shared/utils/http_adapter.dart";
import "package:developer_company/views/credit_request/controllers/finish_sell_form_controller.dart";
import 'package:developer_company/views/credit_request/forms/finish_sell_form.dart';
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

  final BuyerRepository buyerProvider = BuyerRepositoryImpl(BuyerProvider());
  final FinishSellController _finishSellFormController = FinishSellController();
  final _formBuyerKey = GlobalKey<FormState>();

  bool isAlreadySell = false;
  @override
  void initState() {
    super.initState();
    isAlreadySell =
        int.tryParse(arguments["statusId"]) == 3; //unitStatus unit_status
  }

  void sellUnit() async {
    final BuyerData buyerData = BuyerData(
        nombreCompletoCmprd: _finishSellFormController.fullName.text,
        fechaNacimientoCmprd: _finishSellFormController.birthDate.text,
        estadoCivilCmprd: _finishSellFormController.civilStatus.text,
        nacionalidadCmprd: _finishSellFormController.nationality.text,
        profesionCmprd: _finishSellFormController.job.text,
        residenciaCmprd: _finishSellFormController.addressJob.text,
        telefonoCmprd: _finishSellFormController.phone.text,
        direccionTrabajoCmprd: _finishSellFormController.addressJob.text,
        telefonoTrabajoCmprd: _finishSellFormController.phoneJob.text,
        ingresoMensualTextoCmprd: extractNumber(_finishSellFormController.monthlyIncome.text)!,
        ingresoMensualNumCmprd: extractNumber(_finishSellFormController.monthlyIncome.text)!,
        correoElectronicoCmprd: _finishSellFormController.email.text,
        docIdentificacionCmprd: _finishSellFormController.typeOfDocument.text,
        pasaporteCmprd: "NA",
        dpiCmprd: _finishSellFormController.numberOfDocument.text,
        extendido: _finishSellFormController.whereExtended.text,
        razonSocial: _finishSellFormController.businessName.text,
        urlFotocopiaRepresentacion: "",
        valorTotalLote: extractNumber(_finishSellFormController.totalOfLote.text)!,
        valorMejoras: extractNumber(_finishSellFormController.totalOfEnhancesLote.text)!,
        contado: _finishSellFormController.cashPriceOrCredit ? "1" : "0",
        reserva: extractNumber(_finishSellFormController.reserveCashPrice.text)!,
        fechaLimiteCancelSaldo: "",
        enganche: extractNumber(_finishSellFormController.enganche.text)!,
        saldo: "",
        numeroCuotas: _finishSellFormController.numberOfPayments.text,
        valorCuota: extractNumber(_finishSellFormController.valueOfEachPayment.text)!,
        ciudad: _finishSellFormController.city.text,
        referencia: [
          Reference(
              nombreCompleto:
                  _finishSellFormController.referenceOneFullName.text,
              residencia:
                  _finishSellFormController.referenceOneFullContact.text,
              telefono: ""),
          Reference(
              nombreCompleto:
                  _finishSellFormController.referenceTwoFullName.text,
              residencia:
                  _finishSellFormController.referenceTwoFullContact.text,
              telefono: "")
        ]);

    try {
      String? urlOfDocument = await buyerProvider.postSellBuyerData(
          buyerData, arguments["quoteId"]);

      if (urlOfDocument == null) {
        throw Exception('Failed to post buyer data');
      }

      await shareFile(urlOfDocument.toString(),
          "Formalizacion de venta-${_finishSellFormController.numberOfDocument}.pdf");


      await httpAdapter.putApi(
          "orders/v1/cotizacionVendida/${arguments["quoteId"]}", {}, {});
      EasyLoading.showSuccess("Formalización de venta procesada con éxito.");
      isAlreadySell = true;
      _finishSellFormController.clearController();
      Get.offAllNamed(RouterPaths.DASHBOARD_PAGE);
    } catch (e) {
      EasyLoading.showError("Algo Salio Mal");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        onBackFunction: () {
          if (isAlreadySell) {
            Get.offAllNamed(RouterPaths.DASHBOARD_PAGE);
          } else {
            Get.back();
          }
        },
        sideBarList: [],
        appBar: CustomAppBarTitle(title: "Formalizar Venta"),
        child: Form(
          key: _formBuyerKey,
          child: Column(
            children: [
              FinishSellForm(
                finishSellFormController: _finishSellFormController,
                quoteId: arguments["quoteId"],
              ),
              const SizedBox(height: Dimensions.buttonHeight),
              !isAlreadySell
                  ? CustomButtonWidget(
                      text: "Formalizar Venta",
                      onTap: () async {
                        if (_formBuyerKey.currentState!.validate()) {
                          sellUnit();
                        } else {
                          EasyLoading.showInfo(Strings.pleaseVerifyInputs);
                        }
                      })
                  : CustomButtonWidget(
                      text: "Ir Al Inicio",
                      onTap: () => Get.offAllNamed(RouterPaths.DASHBOARD_PAGE)),
              const SizedBox(height: Dimensions.buttonHeight),
            ],
          ),
        ));
  }
}
