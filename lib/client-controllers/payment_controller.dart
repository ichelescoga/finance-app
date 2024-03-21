import 'package:developer_company/data/models/image_model.dart';
import 'package:developer_company/shared/controllers/base_controller.dart';
// import 'package:developer_company/widgets/autocomplete_dropdown.dart';
import 'package:flutter/material.dart';

class ClientPaymentController extends BaseController {
  final TextEditingController reference = TextEditingController();
  final TextEditingController idPaymentStatus =
      TextEditingController(text: "1");
  final TextEditingController paymentType = TextEditingController();
  final TextEditingController bank = TextEditingController();
  final TextEditingController amount = TextEditingController();

  ImageToUpload evidenceUrl = ImageToUpload(
    base64: null,
    needUpdate: true,
    link: "",
  );

  clear() {
    reference.clear();
    reference.clear();
    paymentType.clear();

    evidenceUrl.reset();
  }
}




  // referencia: req.body.referencia,
  //           url: req.body.url,
  //           idFormaPago: req.body.idFormaPago,
  //           idStatusPago: req.body.idStatusPago,
  //           idEstablecimiento: req.body.idEstablecimiento,