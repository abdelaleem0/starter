import 'package:starter/common/domain/repositories/common_repository.dart';

class DownloadImageUseCase{
  final CommonRepository _commonRepository;

  DownloadImageUseCase(this._commonRepository);

  Future<void> execute(String sketchIdentifier , String id) async {
    await _commonRepository.downloadImage(sketchIdentifier, id);
  }
}