import 'package:starter/app/authentication/domain/repositories/social_authentication_repository.dart';

import '../../../../../common/domain/use_cases/cached_user_data/set_cached_user_data_use_case.dart';
import '../../../../../data/preferences/models/cached_user_data.dart';
import '../../models/social/check_provider_status/social_check_provider_status_input.dart';
import '../../models/social/check_provider_status/social_register_response_required_action.dart';

class CheckSocialStatusUseCase {
  final SocialAuthenticationRepository socialAuthenticationRepository;
  final SetCachedUserDataUseCase setCachedUserDataUseCase;

  CheckSocialStatusUseCase(
      this.socialAuthenticationRepository, this.setCachedUserDataUseCase);

  Future<SocialProviderStatusRequiredActionEnum> execute(
      SocialCheckProviderStatusInput input) async {
    final result =
        await socialAuthenticationRepository.checkSocialProvider(input);
    final userData = result.userData;
    if (userData != null) {
      await _setUserData(userData);
    }
    return result.registerResponseType;
  }

  Future<void> _setUserData(CachedUserData data) async {
    await setCachedUserDataUseCase(data);
  }
}
