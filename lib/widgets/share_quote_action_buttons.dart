import "dart:convert";
import "dart:io";

import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/utils/http_adapter.dart";
import "package:file_picker/file_picker.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:flutter_speed_dial/flutter_speed_dial.dart";
import "package:get/get.dart";
import "package:http/http.dart" as http;
import "package:path_provider/path_provider.dart";
import "package:share_plus/share_plus.dart";

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

  Future<String> saveQuote(String url) async {
    final uri = Uri.parse(url);
    final res = await http.get(uri);
    final bytes = res.bodyBytes;

    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/Cotizacion.pdf';
    await File(path).writeAsBytes(bytes);

    return path;
  }

  Future shareFile() async {
    final quoteUrl = await getQuoteUrl();
    final path = await saveQuote(quoteUrl);

    await Share.shareXFiles(
      [XFile(path)],
      sharePositionOrigin: Rect.fromCircle(
        radius: Get.width * 0.25,
        center: const Offset(0, 0),
      ),
    );
  }

  Future<void> openFolderPicker() async {
    try {
      final quoteUrl = await getQuoteUrl();

      final selectedFolder = await FilePicker.platform.getDirectoryPath();
      if (selectedFolder != null) {
        final pdfFilePath = await saveQuote(quoteUrl);
        final destinationPath =
            '$selectedFolder/Cotización-${widget.quoteId}.pdf';
        await File(pdfFilePath).copy(destinationPath);
      } else {
        print('No folder selected.');
      }
    } catch (e) {
      print('Error picking folder or copying file: $e');
    }
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
              await openFolderPicker();
              EasyLoading.showSuccess("Cotización guardada con éxito.");
            },
            labelBackgroundColor: AppColors.blueColor),
        // FAB 2
        SpeedDialChild(
            child: Icon(
              Icons.share,
              color: Colors.white,
            ),
            backgroundColor: AppColors.blueColor,
            onTap: () async {
              await shareFile();
            },
            labelBackgroundColor: AppColors.blueColor),
      ],
    );
  }
}
