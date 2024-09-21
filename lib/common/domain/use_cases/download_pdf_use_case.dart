import 'package:starter/common/domain/repositories/common_repository.dart';

class DownloadPdfUseCase{
  final CommonRepository _commonRepository;

  DownloadPdfUseCase(this._commonRepository);

  Future<void> execute(String sketchIdentifier , String id) async {
    await _commonRepository.downloadPdf(sketchIdentifier, id);
  }

}