
class Failure {
  final String errorMessage;

  const Failure(this.errorMessage);
}

class ApiRequestFailure extends Failure {
  final int statusCode;

  const ApiRequestFailure(
    this.statusCode,
    super.errorMessage,
  );

  @override
  String toString() {
    return """
    ApiRequestFailure: 
      statusCode = $statusCode
      errorMessage = $errorMessage
    """
        .trim();
  }
}

class ServerFailure extends Failure {
  const ServerFailure(super.errorMessage);
}

class UnExpectedFailure extends Failure {
  UnExpectedFailure(super.errorMessage);
}

class RetrieveFcmTokenFailure extends Failure {
  RetrieveFcmTokenFailure() : super('');
}

//Media Utils Exceptions
class IsolationException extends Failure {
  IsolationException(super.error);
}

class NoAttachmentPickedFailure extends Failure {
  NoAttachmentPickedFailure() : super('mediaPickupCanceled');
}

class ImageCompressionFailure extends Failure {
  ImageCompressionFailure(super.errorMessage);
}

class GenerateThumbnailFailure extends Failure {
  GenerateThumbnailFailure(super.errorMessage);
}

class FileSizeFailure extends Failure {
  FileSizeFailure(super.errorMessage);
}

class UploadFileFailure extends Failure {
  UploadFileFailure(super.errorMessage);
}

class FileTypeFailure extends Failure {
  FileTypeFailure() : super('');
}

class CancelDownloadFileFailure extends Failure {
  CancelDownloadFileFailure() : super('');
}

class NoInternetFailure extends Failure {
  NoInternetFailure() : super('networkError');
}

class OfflineException extends Failure {
  OfflineException() : super('');
}

class GoogleMapPlacesException extends Failure {
  GoogleMapPlacesException(super.errorMessage);
}

class LocationPermissionDeniedForEverException extends Failure {
  LocationPermissionDeniedForEverException(super.errorMessage);
}

class LocationException extends Failure {
  LocationException(super.errorMessage);
}
