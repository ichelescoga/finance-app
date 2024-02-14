import 'package:developer_company/data/models/client_model.dart';
import 'package:developer_company/data/models/image_model.dart';
import 'package:developer_company/shared/controllers/base_controller.dart';
import 'package:developer_company/shared/utils/discount_status_text.dart';
import 'package:flutter/material.dart';

class UnitDetailPageController extends BaseController {
  final List<String> statusOfDiscount = ["Solicitado", "Aceptado", "Rechazado"];

  TextEditingController detailCompany = TextEditingController();
  TextEditingController detailIncomes = TextEditingController();
  TextEditingController detailKindJob = TextEditingController();
  TextEditingController detailJobInDate = TextEditingController();
  TextEditingController detailBirthday = TextEditingController();
  TextEditingController detailDpi = TextEditingController();
  TextEditingController detailNit = TextEditingController();
  TextEditingController unitType = TextEditingController();
  TextEditingController unit = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController finalSellPrice = TextEditingController();
  TextEditingController clientName = TextEditingController();
  TextEditingController clientPhone = TextEditingController();
  TextEditingController quoteHistory = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController startMoney = TextEditingController();
  TextEditingController priceWithDiscount = TextEditingController();
  TextEditingController clientId = TextEditingController();

  TextEditingController discount = TextEditingController(text: "0");
  bool applyDefaultDiscount = false;
  TextEditingController seasonDiscount = TextEditingController(text: "0");
  TextEditingController extraDiscount = TextEditingController(text: "0");
  
  String? statusDiscount;
  String? resolutionDiscount;

  TextEditingController bankHistory = TextEditingController();
  TextEditingController paymentMonths = TextEditingController();
  TextEditingController unitStatus = TextEditingController();
  TextEditingController balanceToFinance = TextEditingController();

  bool unitCheck = false;
  bool clientCheck = false;
  bool executiveCheck = false;
  bool isPayedTotal = false;

  // RxString frontDpi = ''.obs;
  // RxString reverseDpi = ''.obs;

  ImageToUpload reverseDpi = ImageToUpload(
    base64: null,
    needUpdate: true,
    link: "",
  );
  ImageToUpload frontDpi = ImageToUpload(
    base64: null,
    needUpdate: true,
    link: "",
  );

// quoteInfo?.extraDiscount.toString(),
// quoteInfo.isActiveDiscount.toString(),
// quoteInfo.statusDiscount.toString(),
  void updateController(
    String? argsExtraDiscount,
    String? argsStatusDiscount,
    String? argsResolutionDiscount, 

    String? argsStartMoney,
    String? argsPaymentMonths,
    String? argsEmail,
    String? argsClientName,
    String? argsClientPhone,
  ) {
    // discount.text = argsDiscount ?? "0";
    extraDiscount.text = argsExtraDiscount!;
    applyDefaultDiscount = isActiveDiscount(argsStatusDiscount);
    statusDiscount = argsStatusDiscount!;
    resolutionDiscount = argsResolutionDiscount;

    clientName.text = argsClientName ?? "";
    clientPhone.text = argsClientPhone ?? "";
    email.text = argsEmail ?? "";
    startMoney.text = argsStartMoney ?? "";
    paymentMonths.text = argsPaymentMonths ?? "";
  }

  void updateClientInfo(ClientModel client){
    clientId.text = client.id.toString();
    clientName.text = client.name!;
    clientPhone.text = client.phone!;
    email.text = client.email!;
  }

  void cleanInfoClient(){
    clientId.clear();
    clientName.clear();
    clientPhone.clear();
    email.clear();
  }

  void cleanController() {
    frontDpi.reset();
    reverseDpi.reset();
    applyDefaultDiscount = false;

    seasonDiscount.text = "0";
    extraDiscount.text = "0";
    statusDiscount = null;


    detailCompany.clear();
    detailIncomes.clear();
    detailKindJob.clear();
    detailJobInDate.clear();
    detailBirthday.clear();
    detailDpi.clear();
    detailNit.clear();
    unitType.clear();
    unit.clear();
    salePrice.clear();
    finalSellPrice.clear();
    clientName.clear();
    clientPhone.clear();
    quoteHistory.clear();
    email.clear();
    startMoney.clear();
    priceWithDiscount.clear();
    discount.clear();
    bankHistory.clear();
    paymentMonths.clear();
    unitStatus.clear();
    unitCheck = false;
    clientCheck = false;
    executiveCheck = false;
  }

  void startController() {
    unit.text = "Unidad de prueba";
    salePrice.text = "Q 450,000.00";
    unitStatus.text = "En proceso";
  }
}
