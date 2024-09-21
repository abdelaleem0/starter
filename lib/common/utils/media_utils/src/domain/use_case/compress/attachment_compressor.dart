part of media_utils;

class AttachmentCompressor {
  final ImageCompressionUseCase _compressImageUseCase;
  final VideoCompressUseCase _compressVideoUseCase;

  AttachmentCompressor(this._compressImageUseCase, this._compressVideoUseCase);

  Future<String?> compress(
      AttachmentType? attachmentType, String? filePath) async {
    String compressedMedia = filePath ?? '';

    if (compressedMedia.isEmpty || compressedMedia.isNetwork) {
      return compressedMedia;
    }

    if (attachmentType == AttachmentType.PHOTO) {
      compressedMedia = await _compressImageUseCase.execute(filePath!);
    } else if (attachmentType == AttachmentType.VIDEO) {
      compressedMedia = await _compressVideoUseCase.compress(filePath!);
    }

    if (kDebugMode) {
    }

    return compressedMedia;
  }
}
