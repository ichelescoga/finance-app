import 'package:developer_company/data/models/pre_sell_model.dart';
import 'package:developer_company/shared/controllers/base_controller.dart';
import 'package:flutter/material.dart';

class FinishSellController extends BaseController {
  // Basic Data

  TextEditingController fullName = TextEditingController();
  TextEditingController birthDate = TextEditingController();
  TextEditingController nationality = TextEditingController();
  TextEditingController civilStatus = TextEditingController();
  TextEditingController job = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController addressJob = TextEditingController();
  TextEditingController phoneJob = TextEditingController();
  TextEditingController monthlyIncome = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController identificationDocument = TextEditingController();
  TextEditingController whereGetDocument = TextEditingController();

  // juridic entity
  TextEditingController businessName = TextEditingController();
  TextEditingController copyBusinessName = TextEditingController();

  // references
  TextEditingController referenceOneFullName = TextEditingController();
  TextEditingController referenceOneFullContact = TextEditingController();

  TextEditingController referenceTwoFullName = TextEditingController();
  TextEditingController referenceTwoFullContact = TextEditingController();

  //  unit data
  TextEditingController loteNumber = TextEditingController();
  TextEditingController sector = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController squareMeters = TextEditingController();
  TextEditingController equivalencyMeters = TextEditingController();

  // businessData
  TextEditingController totalOfLote = TextEditingController();
  TextEditingController totalOfEnhancesLote = TextEditingController();

  // pay Method
  bool cashPriceOrCredit = false; //False to Cash and true for credit
  TextEditingController reserveCashPrice = TextEditingController();
  TextEditingController reserveCredit = TextEditingController();
  TextEditingController enganche = TextEditingController();
  TextEditingController monthlyBalance = TextEditingController();
  TextEditingController numberOfPayments = TextEditingController();
  TextEditingController valueOfEachPayment = TextEditingController();

  // subscription to accept

  TextEditingController city = TextEditingController();
  // TextEditingController day = TextEditingController();
  // TextEditingController month = TextEditingController();
  // TextEditingController year = TextEditingController();

  TextEditingController contractDate = TextEditingController();
  TextEditingController by = TextEditingController();
  TextEditingController nameOfPerson = TextEditingController();
  TextEditingController notary = TextEditingController();
  TextEditingController numberOfDocument = TextEditingController();
  TextEditingController typeOfDocument = TextEditingController(text: "DPI");
  TextEditingController whereExtended = TextEditingController();

  void updateControllerPreSell(PreSell preSell) {
    fullName.text = preSell.firstName;
    birthDate.text = preSell.birthDate;

    job.text = preSell.occupation;
    phone.text = preSell.phoneNumber;
    email.text = preSell.email;

    // For subscription to accept
    city.text = preSell.fatherNationalityId;
    nameOfPerson.text = preSell.firstName;
  }

  final List<String> typeOfDocumentList = ["DPI", "PASAPORTE"];

  void clearController() {
    fullName.clear();
    birthDate.clear();
    nationality.clear();
    civilStatus.clear();
    job.clear();
    location.clear();
    phone.clear();
    addressJob.clear();
    phoneJob.clear();
    monthlyIncome.clear();
    email.clear();
    identificationDocument.clear();
    whereGetDocument.clear();
    businessName.clear();
    copyBusinessName.clear();
    referenceOneFullName.clear();
    referenceOneFullContact.clear();
    referenceTwoFullName.clear();
    referenceTwoFullContact.clear();
    loteNumber.clear();
    sector.clear();
    area.clear();
    squareMeters.clear();
    equivalencyMeters.clear();
    totalOfLote.clear();
    totalOfEnhancesLote.clear();
    reserveCashPrice.clear();
    reserveCredit.clear();
    enganche.clear();
    monthlyBalance.clear();
    numberOfPayments.clear();
    valueOfEachPayment.clear();
    city.clear();
    contractDate.clear();
    by.clear();
    nameOfPerson.clear();
    notary.clear();
    numberOfDocument.clear();
    typeOfDocument.clear();
    whereExtended.clear();
    cashPriceOrCredit = false;
  }
}
