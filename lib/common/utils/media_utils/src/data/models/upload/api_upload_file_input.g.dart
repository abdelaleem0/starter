// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_upload_file_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiUploadFileInput _$ApiUploadFileInputFromJson(Map<String, dynamic> json) =>
    ApiUploadFileInput(
      const MultipartJsonConverter().fromJson(json['file']),
      ApiFileModelEnum.fromJson(json['model'] as String?),
    );

Map<String, dynamic> _$ApiUploadFileInputToJson(ApiUploadFileInput instance) =>
    <String, dynamic>{
      'file': const MultipartJsonConverter().toJson(instance.file),
      'model': _$ApiFileModelEnumEnumMap[instance.model]!,
    };

const _$ApiFileModelEnumEnumMap = {
  ApiFileModelEnum.EVENT_THUMBNAIL: 'EVENT_THUMBNAIL',
  ApiFileModelEnum.SPEAKER_PROFILE: 'SPEAKER_PROFILE',
  ApiFileModelEnum.CHALLENGE_THUMBNAIL: 'CHALLENGE_THUMBNAIL',
  ApiFileModelEnum.POST_ATTACHMENT: 'POST_ATTACHMENT',
  ApiFileModelEnum.COMMENT_ATTACHMENT: 'COMMENT_ATTACHMENT',
  ApiFileModelEnum.ARTICLE_COVER: 'ARTICLE_COVER',
  ApiFileModelEnum.CONTACT_US_ATTACHMENT: 'CONTACT_US_ATTACHMENT',
};
