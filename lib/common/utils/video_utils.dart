
import 'package:starter/common/domain/exceptions/exceptions.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoUtils {
  static Future<String> getVideoThumbnail({required String videoPath}) async {
    final thumbnail = await VideoThumbnail.thumbnailFile(
        video: videoPath, imageFormat: ImageFormat.JPEG);

    if (thumbnail == null) {
      throw GenerateThumbnailException();
    } else {
      return thumbnail;
    }
  }
}
