import 'package:starter/common/utils/media_utils/src/domain/models/attachment_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../../media_utils.dart';

part 'api_attachment_input.g.dart';

@JsonSerializable()
class ApiAttachment {
  String url;
  String? thumbnail;
  int? pageNumber;
  int? durationInSec;
  ApiAttachmentType attachmentType;

  ApiAttachment({
    required this.url,
    this.thumbnail,
    this.pageNumber,
    this.durationInSec,
    required this.attachmentType,
  });

  factory ApiAttachment.fromJson(Map<String, dynamic> json) =>
      _$ApiAttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$ApiAttachmentToJson(this);

  factory ApiAttachment.fromAttachment(Attachment input) {
    return ApiAttachment(
      attachmentType: ApiAttachmentType.fromDomain(input.type ?? AttachmentType.EMPTY),
      url: input.url,
      thumbnail: input.thumbnail,
      durationInSec: input.durationInSec,
    );
  }

  @override
  String toString() {
    return 'ApiAttachment{url: $url, thumbnail: $thumbnail, pageNumber: $pageNumber, attachmentType: $attachmentType}';
  }
}
