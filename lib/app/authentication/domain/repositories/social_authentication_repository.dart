

import 'package:starter/app/authentication/domain/models/otp_verification/otp_verification/otp_verification_input.dart';
import 'package:starter/app/authentication/domain/models/social/check_provider_status/social_check_provider_status_input.dart';
import 'package:starter/app/authentication/domain/models/social/check_provider_status/social_check_provider_status_result.dart';
import 'package:starter/app/authentication/domain/models/social/login/social_login_input.dart';
import 'package:starter/app/authentication/domain/models/social/merge/social_merge_input.dart';
import 'package:starter/app/authentication/domain/models/social/register/social_register_input.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';

abstract class SocialAuthenticationRepository {
  Future<AppUserModel> socialRegister(SocialRegisterInput input);
  Future<AppUserModel?> socialLogin(SocialLogInInput input);
  Future<SocialCheckProviderStatusResult> checkSocialProvider(
      SocialCheckProviderStatusInput input);
  Future<AppUserModel> socialMerge(SocialMergeInput input);
  Future<({bool verifyState , AppUserModel? appUserModel})> verifyOtp(OtpVerificationInput input);
}
