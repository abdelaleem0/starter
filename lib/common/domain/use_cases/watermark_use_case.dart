// import 'dart:async';
// import 'dart:io';
//
// import 'package:starter/common/domain/exceptions/exceptions.dart';
// import 'package:starter/common/utils/common.dart';
// import 'package:path_provider_android/path_provider_android.dart';
// import 'package:path_provider_ios/path_provider_ios.dart';
// import 'package:image/image.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:isolate_handler/isolate_handler.dart';
// import 'package:path_provider/path_provider.dart';
//
// final isolates = IsolateHandler();
// Completer<String>? _completer;
// String? name;
//
// class WatermarkUseCase {
//   Future<String> execute(String imagePath) async {
//     logDebug("startedWatermarking");
//     name = "background${DateTime.now()}";
//     _completer = Completer();
//
//     final watermarkByteData =
//         await rootBundle.load("images/common/watermark.png");
//     final watermarkIntList = watermarkByteData.buffer.asUint8List().toList();
//
//     final Map<String, dynamic> input = {
//       "watermark": watermarkIntList,
//       "imagePath": imagePath
//     };
//
//     isolates.spawn(
//       _entryPoint,
//       name: name,
//       onReceive: onReceived,
//       onInitialized: () => isolates.send(input, to: name),
//     );
//
//     final String result = await _completer!.future;
//     _completer == null;
//
//     logDebug("finishedWatermarking");
//
//     if (result != null && result != "Error") {
//       return result;
//     } else {
//       throw ImageWatermarkException();
//     }
//   }
// }
//
// void onReceived(dynamic data) {
//   _completer?.complete(data);
//   if (name != null) {
//     isolates.kill(name!);
//     name = null;
//   }
// }
//
// void _entryPoint(Map<String, dynamic> context) async {
//   final messenger = HandledIsolate.initialize(context);
//   messenger.listen((message) async {
//     final result = await _watermark(message);
//     messenger.send(result);
//   });
// }
//
// Future<String> _watermark(dynamic input) async {
//   final Map<String, dynamic>? inputs = input;
//   if (inputs == null) {
//     logDebug("inputs error");
//     return "Error";
//   }
//   final String? imagePath = inputs["imagePath"];
//   if (imagePath == null) {
//     logDebug("imagePath error");
//     return "Error";
//   }
//   final originalImageFile = File(imagePath);
//   final originalImage = decodeImage(originalImageFile.readAsBytesSync());
//
//   final List<int>? watermarkList = inputs["watermark"];
//   if (watermarkList == null) {
//     logDebug("watermark error");
//     return "Error";
//   }
//
//   // final watermarkImage = decodeImage(
//   //     watermarkByteData.buffer.asUint8List(
//   //         watermarkByteData.offsetInBytes,
//   //         watermarkByteData.lengthInBytes
//   //     )
//   // );
//   final watermarkImage = decodeImage(watermarkList);
//
//   if (originalImage == null) {
//     return "Error";
//   }
//
//   if (watermarkImage == null) {
//     return "Error";
//   }
//
//   final watermarkAspectRatio = watermarkImage.width / watermarkImage.height;
//
//   final estimatedWatermarkHeight = originalImage.height ~/ 7;
//   final estimatedWatermarkWidth = originalImage.width ~/ 7;
//
//   final int watermarkHeight;
//   final int watermarkWidth;
//
//   if (originalImage.height <= originalImage.width) {
//     final estimatedWatermarkWidthRelatedToHeight =
//         estimatedWatermarkHeight * watermarkAspectRatio;
//     if (estimatedWatermarkWidthRelatedToHeight >= estimatedWatermarkWidth) {
//       watermarkWidth = estimatedWatermarkWidth;
//       watermarkHeight = estimatedWatermarkWidth ~/ watermarkAspectRatio;
//     } else {
//       watermarkWidth = estimatedWatermarkWidthRelatedToHeight.toInt();
//       watermarkHeight = estimatedWatermarkHeight;
//     }
//   } else {
//     final estimatedWatermarkHeightRelatedToWidth =
//         estimatedWatermarkWidth ~/ watermarkAspectRatio;
//     if (estimatedWatermarkHeightRelatedToWidth >= estimatedWatermarkHeight) {
//       watermarkHeight = estimatedWatermarkHeight;
//       watermarkWidth =
//           (estimatedWatermarkHeight * watermarkAspectRatio).toInt();
//     } else {
//       watermarkHeight = estimatedWatermarkHeightRelatedToWidth;
//       watermarkWidth = estimatedWatermarkWidth;
//     }
//   }
//
//   const marginPercent = 2 / 100;
//   final yMargin = marginPercent * originalImage.height;
//   final xMargin = marginPercent * originalImage.width;
//
//   final image = copyResize(watermarkImage,
//       width: watermarkWidth, height: watermarkHeight);
//
//   final x = originalImage.width - watermarkWidth - xMargin.toInt();
//   final y = originalImage.height - watermarkHeight - yMargin.toInt();
//
//   copyInto(
//     originalImage,
//     image,
//     dstX: x,
//     dstY: y,
//   );
//
//   if (Platform.isAndroid) PathProviderAndroid.registerWith();
//   if (Platform.isIOS) PathProviderIOS.registerWith();
//
//   final fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
//
//   final wmImage = encodeJpg(originalImage);
//   final watermarkedImageFile =
//       File("${(await getTemporaryDirectory()).path}/$fileName");
//
//   await watermarkedImageFile.writeAsBytes(wmImage);
//   return watermarkedImageFile.path;
// }
