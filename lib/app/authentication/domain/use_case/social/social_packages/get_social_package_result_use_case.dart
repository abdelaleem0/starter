import '../../../models/social/social_auth_packages_result.dart';
import '../../../models/social/social_provider_type.dart';
import 'social_auth_packages_factory.dart';
import 'states/i_social_auth_packages.dart';

class GetSocialPackageResultUseCase {
  final SocialAuthFactory _socialAuthFactory;

  GetSocialPackageResultUseCase(this._socialAuthFactory);

  Future<SocialAuthPackagesResult> execute(
      {required SocialProviderTypeEnum type}) async {
    ISocialAuthPackages package =
        _socialAuthFactory.getSocialPackage(type: type);
    return await package.getResult();
  }
}
