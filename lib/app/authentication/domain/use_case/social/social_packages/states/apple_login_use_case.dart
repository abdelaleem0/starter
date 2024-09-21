import 'dart:convert';
import 'package:starter/app/authentication/domain/models/social/social_auth_packages_result.dart';
import 'package:starter/app/authentication/domain/models/social/social_provider_type.dart';
import 'package:starter/app/authentication/domain/use_case/social/social_packages/states/i_social_auth_packages.dart';
import 'package:starter/app/authentication/utils/localization/authentication_localizer.dart';
import 'package:starter/common/domain/exceptions/exceptions.dart';
import 'package:starter/common/domain/exceptions/status_codes.dart';
import 'package:starter/common/domain/use_cases/cached_user_data/set_cached_user_apple_email_use_case.dart';
import 'package:crypto/crypto.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleLoginUseCase implements ISocialAuthPackages {
  final SetCachedAppleEmailUseCase setCachedAppleEmailUseCase;
  final GetCachedAppleEmailUseCase getCachedAppleEmailUseCase;
  final DeleteCachedAppleEmailUseCase deleteCachedAppleEmailUseCase;

  AppleLoginUseCase(
      {required this.setCachedAppleEmailUseCase, required this.getCachedAppleEmailUseCase,required this.deleteCachedAppleEmailUseCase,});
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<SocialAuthPackagesResult> getResult() async {
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

        /// Save the email securely for future logins
      if (appleCredential.email != null) {
        await setCachedAppleEmailUseCase.execute(appleCredential.email??'');
      }
      return await _reformatData(appleCredential);
    } on SignInWithAppleAuthorizationException catch (e) {
      switch (e.code) {
        case AuthorizationErrorCode.canceled:
          throw ApiRequestException(StatusCodes.userCancelledSocialLogin,
              AuthenticationLocalizer.userCancelSocialLogin);
        case AuthorizationErrorCode.failed:
          throw ApiRequestException(
            StatusCodes.failedToLoginWithApple,
            'Failed to login', //Todo()
          );
        case AuthorizationErrorCode.invalidResponse:
          throw ApiRequestException(
            StatusCodes.failedToGetAppleUser,
            'Failed to login', //Todo()
          );
        case AuthorizationErrorCode.notHandled:
          rethrow;
        case AuthorizationErrorCode.notInteractive:
          rethrow;
        case AuthorizationErrorCode.unknown:
          throw ApiRequestException(
            StatusCodes.failedToLoginWithApple,
            'Failed to login',
          );
      }
    }
  }

  Future<SocialAuthPackagesResult> _reformatData(
      AuthorizationCredentialAppleID credential) async {
    String? email = credential.email;
    ///  use it if you need don't use private email (hide)
    // if (email != null && email.endsWith('@privaterelay.appleid.com')) {
    //   email = null;
    //   await deleteCachedAppleEmailUseCase.execute();
    // } else {
    //   email ??= await getCachedAppleEmailUseCase.execute();
    // }
    email ??= await getCachedAppleEmailUseCase.execute();
    final result = SocialAuthPackagesResult(
        providerId: credential.userIdentifier ?? "",
        serverAuthCode: credential.authorizationCode,
        userFullName:
        credential.givenName != null && credential.familyName != null
            ? '${credential.givenName} ${credential.familyName}'
            : null,
        provider: SocialProviderTypeEnum.apple,
        email: email,
        imageUrl: null);
    return result;
  }
}
