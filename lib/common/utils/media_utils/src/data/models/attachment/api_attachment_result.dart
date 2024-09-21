part of media_utils;

class ApiAttachmentResult {
  String? url;
  String? thumbnail;
  ApiAttachmentType? attachmentType;
  double? sizeInKb;
  int? numberOfPages;
  int? durationInSec;

  ApiAttachmentResult({
    this.url,
    this.thumbnail,
    this.attachmentType,
    this.sizeInKb,
    this.numberOfPages,
    this.durationInSec,
  });

  factory ApiAttachmentResult.fromJson(Map<String, dynamic> json) =>
      ApiAttachmentResult(
        url: json["url"],
        thumbnail: json["thumbnail"],
        attachmentType: json["type"] != null
            ? ApiAttachmentType.fromJson(json["type"])
            : null,
        sizeInKb: parseDynamicToDouble(json["sizeInKb"]),
        numberOfPages: json["numberOfPages"],
        durationInSec: json["durationInSec"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "thumbnail": thumbnail,
        "type": EnumUtils.enumToString(attachmentType),
        "durationInSec": durationInSec,
      };
}
class EnumUtils {
  //convert enum value to string
  static String enumToString<T>(T value) {
    return value.toString().split('.').last;
  }

  //convert string to enum value
  static T? enumFromString<T>(String? value, List<T> values) {
    final eumValue = values.firstWhereOrNull(
          (e) => enumToString(e) == value,
    );
    if (eumValue == null) {
      return values.first;
    }
    return eumValue;
  }
}