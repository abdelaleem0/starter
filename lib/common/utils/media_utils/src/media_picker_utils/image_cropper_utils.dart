part of media_utils;

class ImageCropperUtils {
  final imageCropperObj = ImageCropper();

  Future<File?> lockedAspectCrop(File? pickedImage) async {
    if (pickedImage != null) {
      final croppedFile = await imageCropperObj.cropImage(
        sourcePath: pickedImage.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: Colors.black,
            toolbarWidgetColor: AppColors.appBackgroundColor,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            hideBottomControls: true,
            showCropGrid: false,
            backgroundColor: AppColors.appBackgroundColor,
          ),
          IOSUiSettings(
            hidesNavigationBar: true,
            aspectRatioLockEnabled: true,
            resetAspectRatioEnabled: false,
          ),
        ],
      );
      if (croppedFile != null) {
        return File(croppedFile.path);
      }
    }
    return null;
  }

  Future<File?> freeCrop(File? pickedImage) async {
    if (pickedImage != null) {
      final croppedFile = await imageCropperObj.cropImage(
        sourcePath: pickedImage.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarColor: Colors.black,
              toolbarWidgetColor: AppColors.appBackgroundColor,
              initAspectRatio: CropAspectRatioPreset.original,
              backgroundColor: Colors.black.withOpacity(.9),
              lockAspectRatio: false,
              hideBottomControls: true,
              showCropGrid: false,
              toolbarTitle: ''),
          IOSUiSettings(
            hidesNavigationBar: true,
          ),
        ],
      );
      if (croppedFile != null) {
        return File(croppedFile.path);
      }
    }
    return null;
  }
}
