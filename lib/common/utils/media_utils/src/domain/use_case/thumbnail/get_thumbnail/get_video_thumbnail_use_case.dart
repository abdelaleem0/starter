part of media_utils;

class GetVideoThumbnailUseCase {
  Future<String> execute({required String videoPath}) async {
    final thumbnail = await VideoThumbnail.thumbnailFile(
        video: videoPath, imageFormat: ImageFormat.JPEG);

    if (thumbnail == null) {
      throw GenerateThumbnailFailure("thumbnailError");
    } else {
      return thumbnail;
    }
  }
}
