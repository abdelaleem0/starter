part of media_utils;

class AttachmentThumbnailGrabber {
  final GetVideoThumbnailUseCase _getVideoThumbnail;
  final GetFileThumbnailUseCase _getFileThumbnailUseCase;

  AttachmentThumbnailGrabber(
      this._getVideoThumbnail, this._getFileThumbnailUseCase);

  Future<String?> grabThumbnail(
      AttachmentType? attachmentType, String fileUrl) async {
    switch (attachmentType) {
      case AttachmentType.VIDEO:
        return await _getVideoThumbnail.execute(videoPath: fileUrl);

      case AttachmentType.DOCUMENT:
        return await _getFileThumbnailUseCase.execute(File(fileUrl));

      default:
        return null;
    }
  }
}
