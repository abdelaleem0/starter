import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:starter/common/domain/models/token.dart';
import 'package:starter/data/preferences/models/cached_user_data.dart';

import '../../../../../common/domain/use_cases/cached_user_data/set_cached_user_data_use_case.dart';
import '../../models/social/register/social_register_input.dart';
import '../../repositories/social_authentication_repository.dart';

class SocialRegisterUseCase {
  final SocialAuthenticationRepository _socialAuthenticationRepository;
  final SetCachedUserDataUseCase _setCachedUserDataUseCase;

  SocialRegisterUseCase(
      this._socialAuthenticationRepository, this._setCachedUserDataUseCase,);

  Future<AppUserModel> execute({required SocialRegisterInput input}) async {
    final result = await _socialAuthenticationRepository.socialRegister(input);
    await _setCachedUserDataUseCase(CachedUserData(id: result.id ??"", token: result.token ?? const Token("", false)));
    return result;

  }
}
