import 'package:starter/app/authentication/domain/models/inputs/complete_register_input.dart';
import 'package:starter/app/authentication/domain/models/inputs/login_details_input.dart';
import 'package:starter/app/authentication/domain/models/inputs/login_input.dart';
import 'package:starter/app/authentication/domain/models/inputs/register_input.dart';
import 'package:starter/app/authentication/domain/models/inputs/update_password_input.dart';
import 'package:starter/app/authentication/domain/models/otp_verification/otp_verification/otp_verification_input.dart';
import 'package:starter/app/authentication/domain/models/otp_verification/resond_otp/resend_verification_otp_input.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:starter/common/domain/models/token.dart';
import 'package:starter/data/preferences/models/cached_user_data.dart';

abstract class UserAuthenticationRepository {
  Future<AppUserModel> login(LoginInput input , LoginDetailsInput loginDetailsInput);

  Future<void> cacheUserData(CachedUserData userData);

  Future<CachedUserData> getCachedUserData();

  Future<void> deleteUserData();

  Future<void> updateToken(Token token);

  Future<bool> forgetPassword(String email);
  Future<bool> forgetPasswordOtpVerification(OtpVerificationInput input);

  Future<({bool verifyState, AppUserModel? appUserModel})> registerOtpVerification(OtpVerificationInput input);

  Future<String> updatePassword(UpdatePasswordInput updatePasswordInput);

  Future<void> userRegister(RegisterInput registerInput , LoginDetailsInput loginDetailsInput);

  Future<bool> isEmailExists(String email);

  Future<bool> resendOtp(ResendOtpInput input);
  Future<AppUserModel> completeRegister(CompleteRegisterInput completeRegister);
  Future<bool> isUserNameExists(String userName);

}
