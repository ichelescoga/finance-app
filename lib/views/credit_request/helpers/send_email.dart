 import 'dart:convert';

import 'package:developer_company/shared/utils/http_adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

void sendEmail(String comment, String receipt, quoteId, context) async {
  HttpAdapter httpAdapter = HttpAdapter();
    final response =
        await httpAdapter.postApi("orders/v1/cotizacionPdf/$quoteId", {}, {});

    if (response.statusCode != 200) {
      EasyLoading.showError("Cotización no pudo ser generada.");
      return;
    }

    final responseBody = json.decode(response.body);
    final url = responseBody['body'];

    String email = Uri.encodeComponent(receipt);
    String finalSubject = Uri.encodeComponent("Envió de cotización");
    String body = Uri.encodeComponent("$comment \n \n $url");
    Uri mail = Uri.parse("mailto:$email?subject=$finalSubject&body=$body");
    try {
      await launchUrl(mail);
    } catch (e) {
      EasyLoading.showError("Correo no se pudo abrir");
      return;
    }

    EasyLoading.showSuccess("Cotización Enviada con éxito");

    Navigator.of(context).pop();
  }