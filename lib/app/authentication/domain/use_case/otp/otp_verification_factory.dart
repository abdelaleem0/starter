import 'package:starter/app/authentication/domain/use_case/otp/states/social_email_otp_verification_use_case.dart';

import '../../models/otp_verification/otp_verification_type.dart';
import 'states/forget_password_otp_verification_use_case.dart';
import 'states/i_otp_verification_use_case.dart';
import 'states/user_form_register_otp_verification_use_case.dart';

class OtpVerificationFactory {
  final UserFormRegisterOtpVerificationUseCase _emailUserVerificationUseCase;
  final ForgetPasswordOtpVerificationUseCase
      _verifyForgetPasswordVerificationCode;
  final SocialOtpVerificationUseCase _verifySocialEmailUseCase;

  OtpVerificationFactory(this._verifyForgetPasswordVerificationCode,
      this._verifySocialEmailUseCase, this._emailUserVerificationUseCase);

  IOtpVerificationUseCase getType(OtpVerificationType otpVerificationType) {
    switch (otpVerificationType) {
      case OtpVerificationType.passwordReset:
        return _verifyForgetPasswordVerificationCode;
      case OtpVerificationType.formRegister:
      case OtpVerificationType.changeEmail:
        return _emailUserVerificationUseCase;
      case OtpVerificationType.socialMerge:
      case OtpVerificationType.socialRegister:
        return _verifySocialEmailUseCase;
    }
  }
}
