import 'package:starter/common/domain/inputs/path_view_enum.dart';
import 'package:starter/common/domain/repositories/common_repository.dart';

class IncreasePathViewsUseCase {
  final CommonRepository _commonRepository;

  const IncreasePathViewsUseCase(this._commonRepository);

  Future<void> execute(PathViewEnum pathViewEnum) async {
    return await _commonRepository.increasePathViews(pathViewEnum);
  }
}
