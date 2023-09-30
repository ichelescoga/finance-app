// import 'dart:convert';
import 'dart:io';

// import 'package:developer_company/shared/utils/http_adapter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<String> saveFileLocalApp(String url, String fileName) async {
  final uri = Uri.parse(url);
  final res = await http.get(uri);
  final bytes = res.bodyBytes;

  final temp = await getTemporaryDirectory();
  final path = '${temp.path}/$fileName';
  await File(path).writeAsBytes(bytes);

  return path;
}

Future shareFile(String fileUrl, String fileName) async {
  final path = await saveFileLocalApp(fileUrl, fileName);

  await Share.shareXFiles(
    [XFile(path)],
    sharePositionOrigin: Rect.fromCircle(
      radius: Get.width * 0.25,
      center: const Offset(0, 0),
    ),
  );
}

Future ShareText(List<String> texts) async {
  await Share.share(texts.join("\n ------------- \n"));
}

Future shareFiles(List<String> urls, String fileName) async {
  List<XFile> pathUrls = [];
  int idx = 0;
  for (final url in urls) {
    idx++;
    String path = await saveFileLocalApp(url, "${idx}_$fileName");
    pathUrls.add(XFile(path));
  }

  await Share.shareXFiles(
    pathUrls,
    sharePositionOrigin: Rect.fromCircle(
      radius: Get.width * 0.25,
      center: const Offset(0, 0),
    ),
  );
}

Future<void> openFolderPicker(String fileUrl, String fileName) async {
  try {
    final selectedFolder = await FilePicker.platform.getDirectoryPath();
    if (selectedFolder != null) {
      final pdfFilePath = await saveFileLocalApp(fileUrl, fileName);
      final destinationPath = '$selectedFolder/$fileName';
      await File(pdfFilePath).copy(destinationPath);
    } else {
      print('No folder selected.');
    }
  } catch (e) {
    print('Error picking folder or copying file: $e');
  }
}
