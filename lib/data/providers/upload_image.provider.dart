import 'dart:convert';

import 'package:developer_company/data/models/image_model.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';

class UploadImageProvider {
  final httpAdapter = HttpAdapter();

  Future<ImageToUpload> postImage(UploadImage image) async {
    try {
      final finalBody = json.encode(image.toJson());
      final response = await httpAdapter.postApi("assets/v1/uploadS3",
          finalBody, {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return ImageToUpload.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to fetch projects');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to fetch projects');
    }
  }
}
