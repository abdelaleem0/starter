

import 'package:starter/app/authentication/domain/models/inputs/login_details_input.dart';
import 'package:starter/app/authentication/domain/models/social/login/social_login_input.dart';
import 'package:starter/app/authentication/domain/models/social/social_auth_packages_result.dart';

extension ConvertSocialAuthPackagesResultToSocialLogInInput
    on SocialAuthPackagesResult {
  SocialLogInInput mapToLogInInput(
      {required LoginDetailsInput loginDetailsInput}) {
    return SocialLogInInput(
        loginDetailsInput: loginDetailsInput,
        provider: provider,
        providerId: providerId,
        fcmToken: fcmToken ??'temp-fcm-token');
  }
}
