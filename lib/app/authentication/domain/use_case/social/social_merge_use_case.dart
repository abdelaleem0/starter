import 'package:starter/app/authentication/domain/models/social/merge/social_merge_input.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:starter/common/domain/models/token.dart';

import '../../../../../common/domain/use_cases/cached_user_data/set_cached_user_data_use_case.dart';
import '../../../../../data/preferences/models/cached_user_data.dart';
import '../../repositories/social_authentication_repository.dart';

class SocialMergeUseCase {
  final SocialAuthenticationRepository _socialAuthenticationRepository;
  final SetCachedUserDataUseCase _setCachedUserDataUseCase;
  SocialMergeUseCase(
      this._socialAuthenticationRepository, this._setCachedUserDataUseCase);

  Future<AppUserModel> execute(SocialMergeInput input) async {
    final result = await _socialAuthenticationRepository.socialMerge(input);
    await _setUserData(CachedUserData(id: result.id ??"", token: result.token ?? const Token("", true)));
    return (result);
  }

  Future<void> _setUserData(CachedUserData data) async {
    await _setCachedUserDataUseCase(data);
  }
}
