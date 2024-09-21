import 'dart:async';
import 'package:starter/common/utils/common.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class ImageCompressionUseCase {
  Future<String> execute(String imageFilePath) async {
    if (imageFilePath.isEmpty) return '';

    try {
      final fileName = "${DateTime.now().millisecondsSinceEpoch}-mobilecompressed.jpg";
      final targetPath = "${(await getTemporaryDirectory()).path}/$fileName";
      final result = await FlutterImageCompress.compressAndGetFile(
        imageFilePath,
        targetPath,
        format: CompressFormat.jpeg,
        quality: 70,
      );
      if (result != null) {
        return targetPath;
      } else {
        logDebug("CompressedImage: Failure}");
        return "Error";
      }
    } catch (e) {
      logDebug("CompressedImage: Failure}");
      logDebug(e);
      return "Error";
    }

  }

}
