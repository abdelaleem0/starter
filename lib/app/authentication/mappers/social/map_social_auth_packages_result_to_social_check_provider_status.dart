

import 'package:starter/app/authentication/domain/models/social/check_provider_status/social_check_provider_status_input.dart';
import 'package:starter/app/authentication/domain/models/social/social_auth_packages_result.dart';

extension ConvertSocialAuthPackagesResultToSocialCheckProviderStatusInput
    on SocialAuthPackagesResult {
  SocialCheckProviderStatusInput mapToProviderStatusInput() {
    return SocialCheckProviderStatusInput(
        provider: provider,
        providerId: providerId,
        email: email ?? '',
        isEmailManuallyEntered: isEmailManuallyEntered ?? false);
  }
}
