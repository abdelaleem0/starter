import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:starter/common/utils/common.dart';
import 'package:starter/common/utils/exceptions.dart';
import 'package:starter/common/utils/extensions/file.dart';
import 'package:starter/common/utils/media_utils/media_utils.dart';
import 'package:starter/common/utils/media_utils/src/domain/models/attachment_entity.dart';
import 'package:starter/common/utils/permissions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../../../video_utils.dart';

typedef PickedMediaCallback = void Function(Attachment media);

typedef PickedMultipleMediaCallback = void Function(List<Attachment> mediaList);
typedef ExceededLimitAttachmentsCallback = void Function(
    List<Attachment> mediaList);

const int _maxAllowedImageSizeOnMB = 5;
const int _maxAllowedDocumentSizeOnMB = 20;
const int _maxAllowedVideoSizeOnMB = 50; //todo:

class MediaPicker {
  static final _picker = ImagePicker();
  static final _cropperUtils = ImageCropperUtils();

  static Future<void> pickImage(
      {required PickedMediaCallback pickedMediaCallback,
      ImageSource imageSource = ImageSource.gallery}) async {
    if (imageSource == ImageSource.gallery) {
      await AppPermissions.instance.requestMediaLibraryPermission();

      final pickedImage = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 80);

      if (pickedImage != null) {
        final sizeInMB = await File(pickedImage.path).sizeInMB;
        if (sizeInMB > _maxAllowedImageSizeOnMB) {
          throw FileSizeFailure(
              _getUploadFileMaxSizeText(_maxAllowedImageSizeOnMB));
        }
        pickedMediaCallback(Attachment(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: AttachmentType.PHOTO,
          url: pickedImage.path,
        ));
      } else {
        throw NoAttachmentPickedFailure();
      }
    } else {
      try {
        await AppPermissions.instance.requestCameraPermission();

        final pickedImage = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 80,
        );
        if (pickedImage != null) {
          final sizeInMB = await File(pickedImage.path).sizeInMB;
          if (sizeInMB > _maxAllowedImageSizeOnMB) {
            throw FileSizeFailure(
                _getUploadFileMaxSizeText(_maxAllowedImageSizeOnMB));
          }
          pickedMediaCallback(Attachment(
            id: Attachment.generateId,
            type: AttachmentType.PHOTO,
            url: pickedImage.path,
          ));
        } else {
          throw NoAttachmentPickedFailure();
        }
      } catch (e) {
        rethrow;
      }
    }
  }

  static Future<void> pickMultiImages(
      PickedMultipleMediaCallback pickedMultipleMediaCallback,
      {required ExceededLimitAttachmentsCallback
          exceededLimitAttachmentsCallback}) async {
    try {
      await AppPermissions.instance.requestMediaLibraryPermission();

      final pickedImages = await _picker.pickMultiImage(imageQuality: 80);

      final List<Attachment> attachmentList = [];
      final List<Attachment> exceededLimitAttachments = [];

      for (int i = 0; i < pickedImages.length; i++) {
        final imagePath = pickedImages[i].path;

        final sizeInMB = await File(imagePath).sizeInMB;
        debugPrint('sizeInMB $sizeInMB');

        final pickedAttachment = Attachment(
          id: (DateTime.now().millisecondsSinceEpoch + i).toString(),
          //it is essential to add + i to the id, so if the process went so fast,  it does not get the same id (i use the id for AttachmentCacheManager)
          url: imagePath,
          type: AttachmentType.PHOTO,
        );

        if (sizeInMB > _maxAllowedImageSizeOnMB) {
          exceededLimitAttachments.add(pickedAttachment);
        } else {
          attachmentList.add(pickedAttachment);
        }
      }

      if (exceededLimitAttachments.isNotEmpty) {
        exceededLimitAttachmentsCallback(exceededLimitAttachments);
      }

      if (attachmentList.isNotEmpty) {
        pickedMultipleMediaCallback(attachmentList);
      } else {
        throw NoAttachmentPickedFailure();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> pickVideo(
      {required ImageSource source,
      required PickedMediaCallback pickedMediaCallback,
      required PickerVideoProperties pickerVideoProperties}) async {
    XFile? pickedVideo;
    if (source == ImageSource.camera) {
      try {
        await AppPermissions.instance
            .requestCameraPermission(); //it will throw exception if not granted
        pickedVideo = await _picker.pickVideo(
          source: source,
          maxDuration:
              pickerVideoProperties.maxDuration ?? const Duration(minutes: 5),
        );
      } catch (e) {
        rethrow;
      }
    } else {
      try {
        await AppPermissions.instance
            .requestMediaLibraryPermission(); //it will throw exception if not granted
        pickedVideo = await _picker.pickVideo(
          source: source,
          maxDuration:
              pickerVideoProperties.maxDuration ?? const Duration(minutes: 5),
        );
      } catch (e) {
        rethrow;
      }
    }

    if (pickedVideo != null) {
      if (!pickerVideoProperties.ignoreSizeRestrictions) {
        final sizeInMB = await File(pickedVideo.path).sizeInMB;

        if (sizeInMB > _maxAllowedVideoSizeOnMB) {
          throw FileSizeFailure(
              _getUploadFileMaxSizeText(_maxAllowedVideoSizeOnMB));
        }
      }

      String? videoThumbnailPath;

      if (pickerVideoProperties.generateThumbnail) {
        try {
          videoThumbnailPath = await VideoUtils.getVideoThumbnail(
              videoPath: videoThumbnailPath ?? '');
        } catch (e) {
          //todo: do not do anything, not important to throw error if thumbnail could not be generated
        }
      }

      pickedMediaCallback(Attachment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        url: pickedVideo.path,
        type: AttachmentType.VIDEO,
        thumbnail: videoThumbnailPath,
      ));
    } else {
      throw NoAttachmentPickedFailure();
    }
  }

  static Future<void> pickAndModifyImage(
      {required PickedMediaCallback pickedMediaCallback,
      ImageSource imageSource = ImageSource.gallery}) async {
    await pickImage(
        pickedMediaCallback: (media) async {
          final modifiedImage =
              await _cropperUtils.lockedAspectCrop(File(media.url));
          if (modifiedImage != null) {
            pickedMediaCallback(Attachment(
              id: Attachment.generateId,
              url: modifiedImage.path,
              type: AttachmentType.PHOTO,
            ));
          }
        },
        imageSource: imageSource);
  }

  static void addAttachmentsWithLimitRespect(
      {required List<Attachment> mediaList,
      required List<Attachment> selectedImages,
      required int limit,
        required Function(List<Attachment> finalList) pickedMultipleMediaCallback,
      required BuildContext context}) {
    List<Attachment> currentAttachments = List.from(selectedImages);

    if (currentAttachments.length > limit) {
      showTopSnackError(
          text: "Max allowed limit is $limit images", context: context);
      return;
    }

    final totalMediaLength = currentAttachments.length + mediaList.length;

    //check if the limit will be exceeded if i added the new attachments
    if (totalMediaLength > limit) {
      final int canAddIfExceeded = limit - currentAttachments.length;

      //add attachments until it equals to maxLimit and ignore the rest.
      if (canAddIfExceeded > 0) {
        int modifiedCanAddIfExceeded = canAddIfExceeded;

        for (int i = 0; i < canAddIfExceeded; i++) {
          currentAttachments.add(mediaList[i]);
        }

        showTopSnackError(
            context: context,
            text:
                "Media Limit Exceeded, added $modifiedCanAddIfExceeded out of ${mediaList.length}"); // todo add localization
      } else {
        showTopSnackError(
            text: "Max allowed limit is 8 images",
            context: context); // todo add localization
      }
    } else {
      for (Attachment attachment in mediaList) {
        currentAttachments.add(attachment);
      }
    }

    selectedImages = currentAttachments;
    pickedMultipleMediaCallback(selectedImages);
  }

  static Future<void> pickFile(PickedMediaCallback pickedMediaCallback) async {
    try {
      final result = await FilePicker.platform.pickFiles(
          allowCompression: true,
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: [
            'DOC',
            'DOCX',
            'HTML',
            'HTM',
            'ODT',
            'PDF',
            'XLS',
            'XLSX',
            'ODS',
            'PPT',
            'PPTX',
            'TXT'
          ]);

      if (result != null) {
        final File file = File(result.files.single.path!);

        final sizeInMB = await file.sizeInMB;

        if (sizeInMB > _maxAllowedDocumentSizeOnMB) {
          throw FileSizeFailure(
              _getUploadFileMaxSizeText(_maxAllowedDocumentSizeOnMB));
        }
        pickedMediaCallback(
          Attachment(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            url: file.path,
            type: AttachmentType.DOCUMENT,
          ),
        );
      } else {
        throw NoAttachmentPickedFailure();
      }
    } catch (e) {
      rethrow;
    }
  }

  static String getFileExtension(String filePath) {
    return path.extension(filePath);
  }
}

String _getUploadFileMaxSizeText(int maxSize) {
  //todo: Localization
  return '${'Max media size is'} $maxSize${"MB"}';
}

// A transparent image used to avoid loading images when they are not needed.
final Uint8List kTransparentImage = Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82,
]);

/*class _MediaPickerHelper {
  static Future<List<String>> compressImage(List<String> images) async {
    final compressedImages = <String>[];
    for (final image in images) {
      try {
        final result =
            await injector.get<ImageCompressionUseCase>().execute(image);
        compressedImages.add(result);
      } on ImageCompressionException {
        throw ApiRequestException(
          StatusCodes.compressionError,
          //todo: localizer
          "فشل ضغط الصورة",
        );
      }
    }
    return compressedImages;
  }
}*/

class ExtractImageFormFile {
  static Future<String> execute(List<int> list) async {
    final tempDir = await getTemporaryDirectory();
    File? imageFile;

    imageFile = File('${tempDir.path}/image.png')
      ..createSync(recursive: true)
      ..writeAsBytesSync(list);

    return imageFile.path;
  }
}
