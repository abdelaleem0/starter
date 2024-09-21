part of media_utils;

class UploadAttachmentUseCase {
  final UploadFileUseCase _uploadFileUseCase;
  final AttachmentThumbnailGrabber _attachmentThumbnailGrabber;
  final AttachmentCompressor _attachmentCompressor;

  UploadAttachmentUseCase(this._attachmentCompressor, this._uploadFileUseCase,
      this._attachmentThumbnailGrabber);

  Future<List<Attachment>> execute(
      {required List<Attachment> input,
      required UploadFileModelEnum uploadedFileModel,
      AttachmentCacheManager? attachmentCacheManager}) async {
    List<Attachment> attachmentResults = List.from(input);

    for (int index = 0; index < attachmentResults.length; index++) {
      Attachment attachment = attachmentResults[index];

      if (attachment.url.isEmpty) {
        throw UploadFileFailure("emptyFileError");
      }

      final cachedAttachment =
          attachmentCacheManager?.getCachedAttachment(id: attachment.id);

      final Attachment compressThenUploadAttachment =
          await ChainOfTasks.chain<Attachment>(
        attachment,
        [
          (data) async {
            Attachment modifiedAttachment = data;

            if (!(cachedAttachment?.isMediaCompressed ?? false)) {
              //Compress Media
              final compressMedia = await _attachmentCompressor.compress(
                  data.type, data.url);
              modifiedAttachment =
                  modifiedAttachment.modify(url: compressMedia);

              //cache compressed media url, to not make the compress process again if request fails and came here again
              attachmentCacheManager?.cacheCompressedMedia(
                id: data.id,
                compressedUrl: compressMedia ?? '',
              );
            } else {
              modifiedAttachment = modifiedAttachment.modify(
                  url: attachmentCacheManager
                      ?.getCachedAttachment(id: modifiedAttachment.id)
                      ?.compressedMedia);
            }

            if (!(cachedAttachment?.isThumbnailCompressed ?? false)) {
              //Compress Thumbnail
              final compressThumbnail = await _attachmentCompressor.compress(
                  AttachmentType.PHOTO, data.thumbnail);
              modifiedAttachment =
                  modifiedAttachment.modify(thumbnail: compressThumbnail);

              //cache compressed thumbnail url, to not make the compress process again if request fails and came here again
              attachmentCacheManager?.cacheCompressedThumbnail(
                  id: data.id, compressedUrl: compressThumbnail ?? '');
            } else {
              modifiedAttachment = modifiedAttachment.modify(
                  url: attachmentCacheManager
                      ?.getCachedAttachment(id: modifiedAttachment.id)
                      ?.compressedThumbnail);
            }

            return modifiedAttachment;
          },
          (data) async {
            //cache mechanism will be done in _uploadAttachment method
            final uploadedAttachment = await _uploadAttachment(
                data, uploadedFileModel, attachmentCacheManager);
            return uploadedAttachment;
          }
        ],
      );

      attachmentResults[index] = compressThenUploadAttachment;
    }

    return attachmentResults;
  }

  Future<Attachment> _uploadAttachment(
    Attachment attachment,
    UploadFileModelEnum fileModelEnum,
    AttachmentCacheManager? attachmentCacheManager,
  ) async {
    Attachment modifiedAttachment = attachment;
    final cachedAttachment =
        attachmentCacheManager?.getCachedAttachment(id: attachment.id);

    String thumbnail = attachment.thumbnail ?? '';
    String mediaUrl = attachment.url;

    String? uploadThumbnail;
    String? uploadMedia;

    if (thumbnail.isEmpty && !mediaUrl.isNetwork) {
      thumbnail = await _attachmentThumbnailGrabber.grabThumbnail(
              attachment.type, mediaUrl) ??
          '';
    }

    //Upload thumbnail
    if (thumbnail.isNotEmpty &&
        !(cachedAttachment?.isThumbnailUploaded ?? false)) {

      if(thumbnail.isNetwork){
        uploadThumbnail = thumbnail;
      }else{
        uploadThumbnail = await _uploadFileUseCase
            .execute(UploadInput(fileUrl: mediaUrl, model: fileModelEnum));

        attachmentCacheManager?.cacheUploadedThumbnail(
            id: attachment.id, uploadedUrl: uploadThumbnail);
      }

    } else {
      uploadThumbnail = cachedAttachment?.uploadedThumbnail;
    }

    //Upload Media
    if (!(cachedAttachment?.isMediaUploaded ?? false)) {
      if(mediaUrl.isNetwork){
        uploadMedia = mediaUrl;
      }else{
        uploadMedia = await _uploadFileUseCase
            .execute(UploadInput(fileUrl: mediaUrl, model: fileModelEnum));

        attachmentCacheManager?.cacheUploadedMedia(
            id: attachment.id, uploadedUrl: uploadMedia);
      }

    } else {
      uploadMedia = cachedAttachment?.uploadedMedia;
    }

    return modifiedAttachment.modify(
        url: uploadMedia, thumbnail: uploadThumbnail);
  }
}
