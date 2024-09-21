part of media_utils;

class UploadFileUseCase {
  final MediaUtilsRepository _repository;

  UploadFileUseCase(this._repository);

  Future<String> execute(UploadInput input) async {
    final result = await _repository.uploadFile(input);
    return result;
  }
}
