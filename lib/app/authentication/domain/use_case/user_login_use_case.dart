import 'package:starter/app/authentication/domain/models/inputs/login_input.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:starter/common/domain/models/token.dart';
import 'package:starter/common/domain/use_cases/cached_user_data/set_cached_user_data_use_case.dart';
import 'package:starter/common/domain/use_cases/fcm_token_use_case.dart';
import 'package:starter/app/authentication/domain/repositories/user_authentication_repository.dart';
import 'package:starter/common/domain/use_cases/get_device_info_use_case.dart';
import 'package:starter/data/preferences/models/cached_user_data.dart';

class UserLoginUseCase {
  final FcmTokenUseCase _fcmTokenUseCase;
  final UserAuthenticationRepository _repository;
  final SetCachedUserDataUseCase _setCachedUserDataUseCase;
  final GetDeviceInfoUseCase _getDeviceInfoUSeCase;

  UserLoginUseCase(this._fcmTokenUseCase, this._repository,
      this._setCachedUserDataUseCase, this._getDeviceInfoUSeCase);

  Future<AppUserModel> execute(LoginInput loginInput) async {
    loginInput = loginInput.modify(fcmToken: await _fcmTokenUseCase.execute());
    final result = await _repository.login(
        loginInput, (await _getDeviceInfoUSeCase.execute()));
    await _setCachedUserDataUseCase(CachedUserData(id: result.id ??"", token: result.token ?? const Token("", false)));
    return result;
  }
}
