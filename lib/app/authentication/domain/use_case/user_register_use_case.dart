import 'package:starter/app/authentication/domain/models/inputs/register_input.dart';
import 'package:starter/app/authentication/domain/repositories/user_authentication_repository.dart';
import 'package:starter/common/domain/use_cases/fcm_token_use_case.dart';
import 'package:starter/common/domain/use_cases/get_device_info_use_case.dart';

class UserRegisterUseCase {
  final FcmTokenUseCase _fcmTokenUseCase;
  final GetDeviceInfoUseCase _getDeviceInfoUseCase;
  final UserAuthenticationRepository _userAuthenticationRepository;

  UserRegisterUseCase(this._fcmTokenUseCase, this._userAuthenticationRepository,
      this._getDeviceInfoUseCase);

  Future<void> execute(RegisterInput input) async {
    input = input.modify(fcmToken: await _fcmTokenUseCase.execute());
    final result = await _userAuthenticationRepository.userRegister(
        input, await _getDeviceInfoUseCase.execute());
    return result;
  }
}
