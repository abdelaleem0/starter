import 'package:starter/common/domain/exceptions/exceptions.dart';
import 'package:starter/common/domain/exceptions/status_codes.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../../utils/localization/authentication_localizer.dart';
import '../../../../models/social/social_auth_packages_result.dart';
import '../../../../models/social/social_provider_type.dart';
import 'i_social_auth_packages.dart';

class GoogleAuthUseCase implements ISocialAuthPackages {
    final googleSignIn = GoogleSignIn(
      scopes: [
        "email",
        "profile",
      ],
    );
  @override
  Future<SocialAuthPackagesResult> getResult() async {
    try {
      final result = await googleSignIn.signIn();
      if (result != null) {
        await googleSignIn.signOut();
        return await _reformatData(result);
      } else {
        throw ApiRequestException(StatusCodes.userCancelledSocialLogin,
            AuthenticationLocalizer.userCancelSocialLogin);
      }
    } on PlatformException catch (e) {
      if (e.code == GoogleSignIn.kSignInFailedError) {
        throw ApiRequestException(
          StatusCodes.failedToLoginWithGoogle,
          AuthenticationLocalizer.failedToLoginWithGoogle,
        );
      } else {
        rethrow;
      }
    }
  }

  Future<SocialAuthPackagesResult> _reformatData(
      GoogleSignInAccount account) async {
    final result = SocialAuthPackagesResult(
        providerId: account.id,
        serverAuthCode: account.serverAuthCode,
        userFullName: account.displayName,
        provider: SocialProviderTypeEnum.google,
        email: account.email, // comment this to test provider without email
        imageUrl: account.photoUrl);
    googleSignIn.signOut();
    return result;
  }
}
