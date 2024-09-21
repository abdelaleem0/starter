// ignore_for_file: constant_identifier_names

part of media_utils;

enum ApiAttachmentType {
  DOCUMENT,
  VIDEO,
  PHOTO,
  SOUND,
  EMPTY;

  factory ApiAttachmentType.fromJson(String? json) {
    return EnumUtils.enumFromString(json, ApiAttachmentType.values) ??
        ApiAttachmentType.PHOTO;
  }

  factory ApiAttachmentType.fromDomain(AttachmentType value) {
    switch(value){
      case AttachmentType.DOCUMENT:
        return ApiAttachmentType.DOCUMENT;
      case AttachmentType.SOUND:
        return ApiAttachmentType.SOUND;
      case AttachmentType.PHOTO:
        return ApiAttachmentType.PHOTO;
      case AttachmentType.VIDEO:
        return ApiAttachmentType.VIDEO;
      case AttachmentType.EMPTY:
        return ApiAttachmentType.EMPTY;
    }
  }
}

extension ConvertAttachmentTypeToApiEnum on AttachmentType{
  ApiAttachmentType toApiType(){
    switch (this) {
      case AttachmentType.DOCUMENT:
        return ApiAttachmentType.DOCUMENT;
      case AttachmentType.SOUND:
        return ApiAttachmentType.SOUND;
      case AttachmentType.PHOTO:
        return ApiAttachmentType.PHOTO;
      case AttachmentType.VIDEO:
        return ApiAttachmentType.VIDEO;
      case AttachmentType.EMPTY:
        return ApiAttachmentType.EMPTY;
    }
  }
}

extension ConvertApiAttachmentTypeEnum on ApiAttachmentType{
  AttachmentType toDomainType(){
    switch (this) {
      case ApiAttachmentType.DOCUMENT:
        return AttachmentType.DOCUMENT;
      case ApiAttachmentType.SOUND:
        return AttachmentType.SOUND;
      case ApiAttachmentType.PHOTO:
        return AttachmentType.PHOTO;
      case ApiAttachmentType.VIDEO:
        return AttachmentType.VIDEO;
      case ApiAttachmentType.EMPTY:
        return AttachmentType.EMPTY;
    }
  }
}