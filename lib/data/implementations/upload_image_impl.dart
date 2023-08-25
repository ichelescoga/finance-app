import 'package:developer_company/data/models/image_model.dart';
import 'package:developer_company/data/providers/upload_image.provider.dart';
import 'package:developer_company/data/repositories/upload_image_repository.dart';

class UploadImageRepositoryImpl implements UploadImageRepository {
  final UploadImageProvider imageUploadProvider;

  UploadImageRepositoryImpl(this.imageUploadProvider);

  @override
  Future<ImageToUpload> postImage(UploadImage imageRequest) async {
    return await imageUploadProvider.postImage(imageRequest);
  }
}
