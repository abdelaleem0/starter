import 'package:starter/common/domain/repositories/common_repository.dart';

class UpdateFcmTokenUseCase {
  final CommonRepository _repository;

  UpdateFcmTokenUseCase(this._repository);

  Future<void> execute(String fcmToken) async {
    return _repository.updateFcmToken(fcmToken);
  }
}