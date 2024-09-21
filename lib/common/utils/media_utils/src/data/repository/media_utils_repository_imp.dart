part of media_utils;

class MediaUtilsRepositoryImp implements MediaUtilsRepository{
  final GraphQLClient _graphQlConfig;

  MediaUtilsRepositoryImp(this._graphQlConfig);

  @override
  Future<String> uploadFile(UploadInput input) async {
    final result = await _graphQlConfig.perform(
        mutation: uploadFileMutation, variables: (await input.map).toJson());

    if (result.hasException || result.data == null) {
      throw const ServerException();
    } else {
      final request = ApiUploadFileResult.fromJson(result.data!).uploadFile;
      final data = request?.data;
      if (request?.code == StatusCodes.success && data != null) {
        return request!.data!;
      } else {
        throw ApiRequestException(
            request?.code ?? StatusCodes.unknown, request?.message ?? "");
      }
    }
  }

}