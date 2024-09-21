// import 'package:starter/app/authentication/domain/models/social/social_auth_packages_result.dart';
// import 'package:starter/app/authentication/utils/localization/authentication_localizer.dart';
// import 'package:starter/common/domain/exceptions/exceptions.dart';
// import 'package:starter/common/domain/exceptions/status_codes.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//
// import '../../../../models/social/social_provider_type.dart';
// import 'i_social_auth_packages.dart';
//
// class FacebookAuthentication implements ISocialAuthPackages {
//   @override
//   Future<SocialAuthPackagesResult> getResult() async {
//     final result = await FacebookAuth.instance.login();
//     switch (result.status) {
//       case LoginStatus.success:
//         return await _handleLoginSuccess(result.accessToken);
//       case LoginStatus.cancelled:
//         throw ApiRequestException(StatusCodes.userCancelledSocialLogin,
//             AuthenticationLocalizer.userCancelSocialLogin);
//       case LoginStatus.failed:
//       case LoginStatus.operationInProgress:
//         throw ApiRequestException(
//           StatusCodes.failedToLoginWithFacebook,
//           AuthenticationLocalizer.failedToLoginWithFacebook,
//         );
//     }
//   }
//
//   Future<SocialAuthPackagesResult> _handleLoginSuccess(
//       AccessToken? accessToken) async {
//     final userJson = await FacebookAuth.instance.getUserData();
//     final String? id = userJson["id"];
//     final String? name = userJson["name"];
//     final String? email = userJson["email"];
//     final String? profilePicture = userJson["picture"]["data"]["url"];
//     final socialInput = SocialAuthPackagesResult(
//         providerId: id ?? '',
//         userFullName: name,
//         provider: SocialProviderTypeEnum.facebook,
//         email: email,
//         imageUrl: profilePicture);
//     return socialInput;
//   }
// }
