import "dart:convert";

import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/services/pdf_download_share.dart";
import "package:developer_company/shared/utils/http_adapter.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:flutter_speed_dial/flutter_speed_dial.dart";

class ShareQuoteActionButtons extends StatefulWidget {
  final String quoteId;
  const ShareQuoteActionButtons({Key? key, required this.quoteId})
      : super(key: key);

  @override
  _ShareQuoteActionButtonsState createState() =>
      _ShareQuoteActionButtonsState();
}

class _ShareQuoteActionButtonsState extends State<ShareQuoteActionButtons> {
  final HttpAdapter httpAdapter = HttpAdapter();

  Future<String> getQuoteUrl() async {
    final response = await httpAdapter
        .postApi("orders/v1/cotizacionPdf/${widget.quoteId}", {}, {});

    if (response.statusCode != 200) {
      EasyLoading.showError("Cotización no pudo ser generada.");
      return "";
    }

    final responseBody = json.decode(response.body);
    final url = responseBody['body'];
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22),
      backgroundColor: AppColors.blueColor,
      visible: true,
      curve: Curves.bounceIn,
      direction: SpeedDialDirection.left,
      children: [
        // FAB 1
        SpeedDialChild(
            child: Icon(
              Icons.download,
              color: Colors.white,
            ),
            backgroundColor: AppColors.blueColor,
            onTap: () async {
              String quoteUrl = await getQuoteUrl();
              await openFolderPicker(quoteUrl, "cotizacion-${widget.quoteId}.pdf");
              EasyLoading.showSuccess("Cotización guardada con éxito.");
            },
            labelBackgroundColor: AppColors.blueColor),
        SpeedDialChild(
            child: Icon(
              Icons.share,
              color: Colors.white,
            ),
            backgroundColor: AppColors.blueColor,
            onTap: () async {
              final quoteUrl = await getQuoteUrl();
              await shareFile(quoteUrl, "cotizacion-${widget.quoteId}.pdf");
            },
            labelBackgroundColor: AppColors.blueColor),
      ],
    );
  }
}
