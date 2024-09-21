import '../../../../models/social/social_auth_packages_result.dart';

abstract class ISocialAuthPackages {
  Future<SocialAuthPackagesResult> getResult();
}
