
import 'package:starter/common/utils/media_utils/media_utils.dart';
import 'package:starter/common/utils/media_utils/src/domain/use_case/compress/compressors/image_compression_use_case.dart';
import 'package:starter/di/app_injector.dart';

class MediaUtilsDi {
  MediaUtilsDi._();

  static Future<void> initialize() async {
    injector.registerFactory(() => ImageCompressionUseCase());
    injector.registerFactory(() => VideoCompressUseCase());
    injector.registerFactory(() => AttachmentCompressor(injector(),injector()));
    injector.registerFactory(() => GetFileThumbnailUseCase());
    injector.registerFactory(() => GetVideoThumbnailUseCase());
    injector.registerFactory(() => AttachmentThumbnailGrabber(injector(),injector()));
    injector.registerFactory(() => UploadAttachmentUseCase(injector(),injector(),injector()));
    injector.registerFactory(() => UploadFileUseCase(injector()));
    injector.registerFactory(() => GetFilePageNumberUseCase());
    injector.registerFactory<MediaUtilsRepository>(() => MediaUtilsRepositoryImp(injector()));

  }
}
