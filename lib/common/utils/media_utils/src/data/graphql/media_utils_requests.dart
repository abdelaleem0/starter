part of media_utils;

const uploadFileMutation = r"""
mutation uploadFile($file: Upload!, $model: FileModelEnum!) {
  uploadFile(file: $file, model: $model) {
    data
    message
    code
    success
  }
}
""";

const attachmentEntityFragment = r"""
fragment attachmentEntityFragment on Attachment {
  url
  thumbnail
  attachmentType
  pageNumber
  durationInSec
}
""";