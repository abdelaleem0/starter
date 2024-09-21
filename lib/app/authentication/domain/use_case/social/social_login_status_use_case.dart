import 'package:starter/app/authentication/domain/models/inputs/login_details_input.dart';
import 'package:starter/app/authentication/mappers/social/map_social_auth_packages_result_to_social_check_provider_status.dart';
import 'package:starter/app/authentication/mappers/social/map_social_auth_packages_result_to_social_log_in_input.dart';
import 'package:starter/common/domain/use_cases/fcm_token_use_case.dart';

import '../../models/social/check_provider_status/social_register_response_required_action.dart';
import '../../models/social/login_user_status_required_action.dart';
import '../../models/social/social_auth_packages_result.dart';
import '../../models/social/social_provider_type.dart';
import 'check_social_provider_status_use_case.dart';
import 'social_login_use_case.dart';
import 'social_packages/get_social_package_result_use_case.dart';

class SocialLogInRequiredActionUseCase {
  final SocialLogInUseCase _socialLogInUseCase;
  final CheckSocialStatusUseCase _checkSocialStatusUseCase;
  final GetSocialPackageResultUseCase _getSocialPackageResultUseCase;
  final FcmTokenUseCase _fcmTokenUseCase;

  SocialLogInRequiredActionUseCase(this._socialLogInUseCase,
      this._checkSocialStatusUseCase,
      this._getSocialPackageResultUseCase,
      this._fcmTokenUseCase,);

  Future<LogInUserStatusRequiredAction> execute(
      SocialProviderTypeEnum type) async {
    SocialAuthPackagesResult packageResult =
    await _getSocialPackageResultUseCase.execute(type: type);
    packageResult =
        packageResult.modify(fcmToken: await _fcmTokenUseCase.execute());
    // check if user log in
    final logInResult = await _socialLogInUseCase.execute(
        input: packageResult.mapToLogInInput(
            loginDetailsInput: const LoginDetailsInput.initial())); // cacheUserData CachedUserData(id: userData.id??"", token: userData.token ?? const Token("", false)));
    SocialProviderStatusRequiredActionEnum? actionRequired;
    // user not register
    if (logInResult == null) {
      // here meaning the user data return null
      // from graphql and not register yet.
      // that means it is first time .
      if (packageResult.email == null) {
        actionRequired = SocialProviderStatusRequiredActionEnum.noEmail;
      } else {
        actionRequired = await _checkSocialStatusUseCase
            .execute(packageResult.mapToProviderStatusInput());
      }
    }
    return LogInUserStatusRequiredAction(
      packagesResult: packageResult,
      actionRequired: actionRequired,
      appUserModel: logInResult,
    );
  }
}
