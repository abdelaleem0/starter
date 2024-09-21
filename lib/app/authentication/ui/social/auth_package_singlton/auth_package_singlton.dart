import '../../../domain/models/social/check_provider_status/social_register_response_required_action.dart';
import '../../../domain/models/social/social_auth_packages_result.dart';

class SocialAuthPackagesResultSingleton {
  SocialAuthPackagesResultSingleton._();

  static SocialAuthPackagesResultSingleton? instance =
      SocialAuthPackagesResultSingleton._();

  SocialAuthPackagesResult? packageData;
  SocialProviderStatusRequiredActionEnum? actionRequired;
}
