class ImageToUpload {
  String? base64;
  bool needUpdate;
  String? link;

  ImageToUpload({
    required this.base64,
    required this.needUpdate,
    required this.link,
  });

  void updateBase64String(String newBase64String) {
    base64 = newBase64String;
    needUpdate = true;
  }

  void updateLink(String newLink) {
    link = newLink;
    needUpdate = false;
  }

  void markUpdateComplete() {
    needUpdate = false;
  }

  void reset() {
    base64 = null;
    needUpdate = false;
    link = null;
  }

  factory ImageToUpload.fromJson(Map<String, dynamic> json) {
    return ImageToUpload(link: json['s3Response'].toString(), needUpdate: false, base64: "");
  }
}

class UploadImage {
  dynamic file;
  String fileName;
  String transactionType;

  UploadImage(
      {required this.file,
      required this.fileName,
      required this.transactionType});

   Map<String, dynamic> toJson() {
    return {
      "file": "$file",
      "fileName": fileName,
      "transactionType": transactionType,
    };
  }

  factory UploadImage.fromJson(Map<String, dynamic> json) {
    return UploadImage(
        file: json["file"],
        fileName: json["fileName"],
        transactionType: json["transactionType"]);
  }
}
