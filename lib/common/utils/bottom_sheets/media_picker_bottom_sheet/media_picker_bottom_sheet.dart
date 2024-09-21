import 'package:starter/common/utils/app_routes/router_functions.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/common.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/common/utils/exceptions.dart';
import 'package:starter/common/utils/media_utils/media_utils.dart';
import 'package:starter/common/utils/media_utils/src/media_picker_utils/media_picker_utils.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

enum MediaPickType {
  pickMultipleGalleryImage,
  pickGalleryImage,
  pickCameraImage,
  pickGalleryVideo,
  pickCameraVideo,
  pickFile,
}

//ignore: must_be_immutable
class MediaPickerBottomSheet extends StatelessWidget {
  final BuildContext pageContext;
  final PickedMediaCallback? onPickMedia;
  final PickedMultipleMediaCallback? onPickMultiMedia;
  final List<MediaPickType> types;
  final bool canModifyImage;
  final PickerVideoProperties? pickerVideoProperties;
  final bool? isRemovable;
  final VoidCallback? onRemove;

  final Function()? onLoading;

  MediaPickerBottomSheet({
    super.key,
    required this.pageContext,
    this.onPickMedia,
    this.onPickMultiMedia,
    required this.types,
    this.canModifyImage = false,
    this.pickerVideoProperties,
    this.onLoading,
    this.isRemovable = false,
    this.onRemove,
  }) {
    for (MediaPickType mediaType in types) {
      switch (mediaType) {
        case MediaPickType.pickMultipleGalleryImage:
          _items.add(
            _Tile(
              label: "Gallery Images", //todo 2024 localization
              iconData: Iconsax.gallery5, //todo 2024 change icon
              onTap: (context) async {
                _onPickPressed(
                  context,
                  pickTask: () async => await MediaPicker.pickMultiImages(
                    onPickMultiMedia!,
                    exceededLimitAttachmentsCallback: (mediaList) {
                      if(mediaList.isNotEmpty){
                        showTopSnackError(
                          text:mediaList.length > 1
                            ? "Max image size is 5MB, ${mediaList.length} images are skipped"
                            : "Max image size is 5MB, 1 image is skipped",
                          context: pageContext,
                        );
                      }
                    },
                  ),
                );
              },
            ),
          );
          break;

        case MediaPickType.pickGalleryImage:
          _items.add(
            _Tile(
              label: "My Gallery", //todo 2024 localization
              iconData: Iconsax.gallery5, //todo 2024 change icon
              onTap: (context) async {
                _onPickPressed(
                  context,
                  pickTask: () async {
                    if (canModifyImage) {
                      await MediaPicker.pickAndModifyImage(
                        pickedMediaCallback: onPickMedia!,
                      );
                    } else {
                      await MediaPicker.pickImage(
                        pickedMediaCallback: onPickMedia!,
                        imageSource: ImageSource.gallery,
                      );
                    }
                  },
                );
              },
            ),
          );
          break;

        case MediaPickType.pickCameraImage:
          _items.add(
            _Tile(
              label: "Take a photo", //todo 2024 localization
              iconData: Iconsax.camera, //todo 2024 change icon
              onTap: (context) async {
                _onPickPressed(
                  context,
                  pickTask: () async {
                    if (canModifyImage) {
                      await MediaPicker.pickAndModifyImage(
                        pickedMediaCallback: onPickMedia!,
                        imageSource: ImageSource.camera,
                      );
                    } else {
                      await MediaPicker.pickImage(
                        pickedMediaCallback: onPickMedia!,
                        imageSource: ImageSource.camera,
                      );
                    }
                  },
                );
              },
            ),
          );
          break;

        case MediaPickType.pickGalleryVideo:
          _items.add(
            _Tile(
              label: "Gallery Video",
              iconData: Iconsax.video, //todo 2024 change icon
              onTap: (context) async {
                _onPickPressed(
                  context,
                  pickTask: () async => await MediaPicker.pickVideo(
                    pickedMediaCallback: onPickMedia!,
                    source: ImageSource.gallery,
                    pickerVideoProperties:
                        pickerVideoProperties ?? const PickerVideoProperties(),
                  ),
                );
              },
            ),
          );
          break;

        case MediaPickType.pickCameraVideo:
          _items.add(
            _Tile(
              label: "Camera Video",
              iconData: Iconsax.video, //todo 2024 change icon
              onTap: (context) async {
                _onPickPressed(
                  context,
                  pickTask: () async {
                    await MediaPicker.pickVideo(
                      pickedMediaCallback: onPickMedia!,
                      source: ImageSource.camera,
                      pickerVideoProperties: pickerVideoProperties!,
                    );
                  },
                );
              },
            ),
          );
          break;

        case MediaPickType.pickFile:
          _items.add(
            _Tile(
              label: "File",
              iconData: Iconsax.document, //todo 2024 change icon
              onTap: (context) async {
                _onPickPressed(
                  context,
                  pickTask: () async => await MediaPicker.pickFile(
                    onPickMedia!,
                  ),
                );
              },
            ),
          );
      }
    }
  }

  void _onPickPressed(BuildContext context,
      {required Future Function() pickTask}) async {
    _isPicking = true;

    if (context.mounted) {
      AppRouteNavigator.pop(context);
    }

    _handleCallBackAndExceptionCatch(task: pickTask());

    _isPicking = false;
  }

  final List<Widget> _items = [];
  bool _isPicking = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop && !_isPicking) {
          // AppToasts.error(context, message: "mediaPickupCanceled");
        }
      },
      child: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(_items.length, (index) {
              return _items[index];
            }),
          ),
          if (isRemovable == true) ...[
            const SizedBox(
              height: PaddingDimensions.normal,
            ),
            const Divider(
              height: 1,
              thickness: 0.5,
            ),
            const SizedBox(
              height: PaddingDimensions.small,
            ),
            _Tile(
              isRemoveIcon: true,
              label: "Remove Image",
              iconData: Iconsax.close_circle,
              onTap: (context) async {
                AppRouteNavigator.pop(context);
                onRemove!();
              },
            )
          ],
          const SizedBox(
            height: PaddingDimensions.xLarge,
          ),
        ],
      ),
    );
  }

  Future<void> _handleCallBackAndExceptionCatch({
    required Future<void> task,
  }) async {
    try {
      if (onLoading != null) {
        onLoading!();
      }

      await task;
    } catch (e) {
      if (!pageContext.mounted) return;

      if (e is FileSizeFailure) {
        showTopSnackError(
          text: e.errorMessage,
          context: pageContext,
        );
      }

      if (e is FileTypeFailure) {
        showTopSnackError(
          text: e.errorMessage,
          context: pageContext,
        );
      }

     /* if (e is NoAttachmentPickedFailure) {

      }*/
    }
  }
}

class _Tile extends StatelessWidget {
  const _Tile(
      {required this.iconData,
      required this.label,
      this.onTap,
      this.isRemoveIcon});

  final IconData iconData;
  final String label;
  final bool? isRemoveIcon;
  final void Function(BuildContext context)? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!(context);
        }
      },
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: PaddingDimensions.normal,
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: isRemoveIcon == true
                      ? AppColors.semanticColorsError6
                      : AppColors.primaryColorsSolid7,
                  shape: BoxShape.circle),
              padding: const EdgeInsets.all(PaddingDimensions.medium - 2),
              child: Icon(
                size: IconDimensions.normal,
                iconData,
                color: isRemoveIcon == true
                    ? AppColors.semanticColorsError4Default
                    : AppColors.primaryColorsSolid4Default,
              ),
            ),
            const SizedBox(
              width: PaddingDimensions.large,
            ),
            Text(
              label,
              style: TextStyles.medium(
                  fontSize: Dimensions.xLarge,
                  color: isRemoveIcon == true
                      ? AppColors.semanticColorsError4Default
                      : AppColors.neutralColors7),
            )
          ],
        ),
      ),
    );
  }
}
