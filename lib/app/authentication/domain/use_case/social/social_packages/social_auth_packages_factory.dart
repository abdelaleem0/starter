import 'package:starter/app/authentication/domain/use_case/social/social_packages/states/apple_login_use_case.dart';
import 'package:starter/common/domain/use_cases/cached_user_data/set_cached_user_apple_email_use_case.dart';

import '../../../models/social/social_provider_type.dart';
import 'states/google_auth.dart';
import 'states/i_social_auth_packages.dart';

class SocialAuthFactory {
  final SetCachedAppleEmailUseCase _setCachedAppleEmailUseCase;
  final GetCachedAppleEmailUseCase _getCachedAppleEmailUseCase;
  final DeleteCachedAppleEmailUseCase _deleteCachedAppleEmailUseCase;

  SocialAuthFactory(this._setCachedAppleEmailUseCase, this._getCachedAppleEmailUseCase, this._deleteCachedAppleEmailUseCase);
  ISocialAuthPackages getSocialPackage({required SocialProviderTypeEnum type}) {
    switch (type) {
      case SocialProviderTypeEnum.google:
        return GoogleAuthUseCase();
      case SocialProviderTypeEnum.apple:
        return AppleLoginUseCase(
            setCachedAppleEmailUseCase: _setCachedAppleEmailUseCase,
            getCachedAppleEmailUseCase: _getCachedAppleEmailUseCase,
            deleteCachedAppleEmailUseCase: _deleteCachedAppleEmailUseCase,
        );
    }
  }
}
