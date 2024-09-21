import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:starter/common/domain/models/token.dart';
import 'package:starter/data/preferences/models/cached_user_data.dart';

import '../../../../../common/domain/use_cases/cached_user_data/set_cached_user_data_use_case.dart';
import '../../models/social/login/social_login_input.dart';
import '../../repositories/social_authentication_repository.dart';

class SocialLogInUseCase {
  final SocialAuthenticationRepository _socialAuthenticationRepository;
  final SetCachedUserDataUseCase _setCachedUserDataUseCase;

  SocialLogInUseCase(
      this._socialAuthenticationRepository, this._setCachedUserDataUseCase);


  Future<AppUserModel?> execute({required SocialLogInInput input}) async {
    final userData = await _socialAuthenticationRepository.socialLogin(input);
    if (userData != null) {
      await _setUserData(CachedUserData(id: userData.id??"", token: userData.token ?? const Token("", false)));
      return userData;
    }
    return null;
  }

  Future<void> _setUserData(CachedUserData data) async {
    await _setCachedUserDataUseCase(data);
  }
}
