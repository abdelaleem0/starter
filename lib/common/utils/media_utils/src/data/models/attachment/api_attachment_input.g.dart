// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_attachment_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiAttachment _$ApiAttachmentFromJson(Map<String, dynamic> json) =>
    ApiAttachment(
      url: json['url'] as String,
      thumbnail: json['thumbnail'] as String?,
      pageNumber: (json['pageNumber'] as num?)?.toInt(),
      durationInSec: (json['durationInSec'] as num?)?.toInt(),
      attachmentType:
          ApiAttachmentType.fromJson(json['attachmentType'] as String?),
    );

Map<String, dynamic> _$ApiAttachmentToJson(ApiAttachment instance) =>
    <String, dynamic>{
      'url': instance.url,
      'thumbnail': instance.thumbnail,
      'pageNumber': instance.pageNumber,
      'durationInSec': instance.durationInSec,
      'attachmentType': _$ApiAttachmentTypeEnumMap[instance.attachmentType]!,
    };

const _$ApiAttachmentTypeEnumMap = {
  ApiAttachmentType.DOCUMENT: 'DOCUMENT',
  ApiAttachmentType.VIDEO: 'VIDEO',
  ApiAttachmentType.PHOTO: 'PHOTO',
  ApiAttachmentType.SOUND: 'SOUND',
  ApiAttachmentType.EMPTY: 'EMPTY',
};
