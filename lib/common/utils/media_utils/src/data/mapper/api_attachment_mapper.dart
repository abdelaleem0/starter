part of media_utils;

extension AttachmentMapper on ApiAttachment{
  Attachment map(){
    return Attachment(
      id: Attachment.generateId,
      url: Constants.concatWithBaseUrl(url),
      thumbnail: Constants.concatWithBaseUrl(thumbnail),
      type: attachmentType.toDomainType(),
      durationInSec: durationInSec,
    );
  }
}