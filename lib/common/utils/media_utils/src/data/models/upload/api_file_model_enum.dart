// ignore_for_file: constant_identifier_names
part of media_utils;

enum ApiFileModelEnum {
  EVENT_THUMBNAIL,
  SPEAKER_PROFILE,
  CHALLENGE_THUMBNAIL,
  POST_ATTACHMENT,
  COMMENT_ATTACHMENT,
  ARTICLE_COVER,
  CONTACT_US_ATTACHMENT;

  factory ApiFileModelEnum.fromJson(String? json) {
    return ApiFileModelEnum.values.firstWhereOrNull((e) => e.name == json) ??
        ApiFileModelEnum.EVENT_THUMBNAIL;
  }

  factory ApiFileModelEnum.fromDomain(UploadFileModelEnum value) {
    switch (value) {
      case UploadFileModelEnum.eventThumbnail:
        return ApiFileModelEnum.EVENT_THUMBNAIL;
      case UploadFileModelEnum.speakerProfile:
        return ApiFileModelEnum.SPEAKER_PROFILE;
      case UploadFileModelEnum.challengeThumbnail:
        return ApiFileModelEnum.CHALLENGE_THUMBNAIL;
      case UploadFileModelEnum.postAttachment:
        return ApiFileModelEnum.POST_ATTACHMENT;
      case UploadFileModelEnum.commentAttachment:
        return ApiFileModelEnum.COMMENT_ATTACHMENT;
      case UploadFileModelEnum.articleCover:
        return ApiFileModelEnum.ARTICLE_COVER;
      case UploadFileModelEnum.contactUsAttachment:
        return ApiFileModelEnum.CONTACT_US_ATTACHMENT;
    }
  }
}
