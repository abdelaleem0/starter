part of media_utils;

class UploadInput {
  final String fileUrl;
  final UploadFileModelEnum model;
  final double? sizeInBytes;

  UploadInput({required this.fileUrl, required this.model, this.sizeInBytes});

  Future<ApiUploadFileInput> get map async {
    final filename = fileUrl.split("/").last;

    final file = await MultipartFile.fromPath("", fileUrl,
        filename: filename, contentType: getMimeType);
    return ApiUploadFileInput(file, ApiFileModelEnum.fromDomain(model));
  }

  MediaType get getMimeType {
    final mime = lookupMimeType(fileUrl);
    if (mime != null) {
      final splits = mime.split("/");
      final type = (splits.firstOrNull).toString();
      final subtype = (splits.lastOrNull).toString();
      return MediaType(type, subtype);
    } else {
      return MediaType("", "");
    }
  }
}

