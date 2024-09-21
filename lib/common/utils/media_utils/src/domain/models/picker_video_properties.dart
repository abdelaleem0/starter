part of media_utils;

class PickerVideoProperties {
  final Duration? maxDuration;
  final bool generateThumbnail;
  final bool ignoreSizeRestrictions;

  const PickerVideoProperties(
      {this.maxDuration,
      this.generateThumbnail = true,
      this.ignoreSizeRestrictions = false});
}
