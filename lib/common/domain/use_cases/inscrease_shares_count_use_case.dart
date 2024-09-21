import 'package:starter/common/domain/inputs/system_action_tracker_input.dart';
import 'package:starter/common/domain/repositories/common_repository.dart';

class IncreaseSharesCountUseCase {
  final CommonRepository _commonRepository;

  IncreaseSharesCountUseCase(this._commonRepository);

  Future<void> execute(SystemActionTrackerInput input) async {
    await _commonRepository.increaseSharesCount(input);
  }
}
