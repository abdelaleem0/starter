// // ignore_for_file: deprecated_member_use
//
// import 'package:starter/app/authentication/domain/models/social/social_auth_packages_result.dart';
//
// import '../../../../../utils/localization/authentication_localizer.dart';
// import '../../../../models/social/social_provider_type.dart';
// import 'i_social_auth_packages.dart';
//
// class TwitterAuthUseCase implements ISocialAuthPackages {
//     final twitterLogin = TwitterLogin(
//       apiKey: _TwitterConfig.apiKey,
//       apiSecretKey: _TwitterConfig.secretApiKey,
//       redirectURI: _TwitterConfig.redirectAndroidURI,
//     );
//   @override
//   Future<SocialAuthPackagesResult> getResult() async {
//     try {
//       final authResult = await twitterLogin.login();
//       switch (authResult.status) {
//         case TwitterLoginStatus.loggedIn:
//           return await _reformatData(authResult);
//         case TwitterLoginStatus.cancelledByUser:
//         case TwitterLoginStatus.error:
//         case null:
//           throw ApiRequestException(StatusCodes.userCancelledSocialLogin,
//               AuthenticationLocalizer.userCancelSocialLogin);
//       }
//     } catch (e) {
//       throw ApiRequestException(
//         StatusCodes.failedToLoginWithGoogle,
//         AuthenticationLocalizer.failedToLoginWithTwitter,
//       );
//     }
//   }
//
//   Future<SocialAuthPackagesResult> _reformatData(AuthResult account) async {
//     final result = SocialAuthPackagesResult(
//         providerId: account.user?.id.toString() ?? '',
//         serverAuthCode: account.authToken,
//         userFullName: account.user?.name,
//         provider: SocialProviderTypeEnum.twitter,
//         email: account.user?.email == '' ? null : account.user?.email,
//         imageUrl: account.user?.thumbnailImage);
//
//     return result;
//   }
// }
//
// class _TwitterConfig {
//   // static const String appIcon = "";
//   static const String apiKey = "IUqxKpmykGsHHasyRIEmIcgId";
//   static const String secretApiKey =
//       "yCpvYC0Pf9x991mUwS2GieH3F2h3U7Naoj22lMtUndxylkYsoU";
//
//   /// [SchemeName] created in package permissions in [AndroidManifest] and ios [info]
//   static const String _schemeName = 'yolo';
//   static const String redirectAndroidURI = "$_schemeName://";
// }
