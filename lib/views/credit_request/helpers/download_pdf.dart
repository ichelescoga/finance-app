import 'dart:convert';

import 'package:developer_company/shared/utils/http_adapter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

void downloadPdf(quoteId) async {
  HttpAdapter httpAdapter = HttpAdapter();
    final response =
        await httpAdapter.postApi("orders/v1/cotizacionPdf/$quoteId", {}, {});

    if (response.statusCode != 200) {
      EasyLoading.showError("Cotización no pudo ser generada.");
      return;
    }

    final responseBody = json.decode(response.body);
    final url = responseBody['body'];

    Uri pdfUrl = Uri.parse(url.toString());
    await launchUrl(pdfUrl, mode: LaunchMode.externalNonBrowserApplication);
  }