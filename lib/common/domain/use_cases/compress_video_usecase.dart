import 'package:video_compress/video_compress.dart';

class CompressVideoUseCase{
  Future<String> compress(String filePath) async {
    //await VideoCompress.setLogLevel(0);
    final MediaInfo? info = await VideoCompress.compressVideo(
      filePath,
      quality: VideoQuality.Res640x480Quality,
      deleteOrigin: false,
      includeAudio: true,
    );

    return info?.path ?? '';
  }

  Future<void> clearCache() async{
    try{
      await VideoCompress.deleteAllCache();
    }catch(e){
      //do not throw error if this fails
    }
  }

  /*Future<String> getVideoThumbnail(String path) async{
    final thumbnail = await VideoCompress.getFileThumbnail(
        path,
        quality: 70,
        position: -1
    );

    return thumbnail.path;
  }*/
}