import 'package:developer_company/data/implementations/upload_image_impl.dart';
import 'package:developer_company/data/models/image_model.dart';
import 'package:developer_company/data/providers/upload_image.provider.dart';
import 'package:developer_company/data/repositories/upload_image_repository.dart';
import 'package:uuid/uuid.dart';

Future<String> saveImage(
    ImageToUpload imageController) async {
  var uuid = Uuid();
  final uid = uuid.v1();

  UploadImageRepository uploadImageRepository =
      UploadImageRepositoryImpl(UploadImageProvider());

  final developerLogoBase64 = imageController.base64;
  final needUpdateLogo = imageController.needUpdate;

  if (developerLogoBase64 != null && needUpdateLogo) {
    String developerName = imageController.originalName != null
        ? imageController.originalName!
        : "${uid}-${uid}${imageController.extension}";

    final UploadImage logoRequestImage = UploadImage(
        file: developerLogoBase64,
        fileName: developerName,
        transactionType: "developerLogo");

    ImageToUpload responseImage =
        await uploadImageRepository.postImage(logoRequestImage);
    String? imageLink = responseImage.link;
    return imageLink!;
  }

  return imageController.link!;
}

Future<Map<String, String>> handleImagesToUpload(
    Map<String, ImageToUpload> imagesInput) async {
  Map<String, String> imagesValues = {};

  for (var entry in imagesInput.entries) {
    final key = entry.key;
    final value = entry.value;

    final linkResponse = await saveImage(value);
    imagesValues[key] = linkResponse;
  }

  return imagesValues;
}
