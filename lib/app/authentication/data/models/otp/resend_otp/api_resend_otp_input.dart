// ignore_for_file: constant_identifier_names, library_private_types_in_public_api

import 'package:starter/app/authentication/domain/models/otp_verification/resond_otp/resend_verification_otp_input.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/models/otp_verification/otp_verification_type.dart';

part 'api_resend_otp_input.g.dart';

@JsonSerializable()
class ApiResendOtpInput {
  final String email;
  final _ApiUserOtpVerificationTypeEnum useCase;

  factory ApiResendOtpInput.fromJson(Map<String, dynamic> json) =>
      _$ApiResendOtpInputFromJson(json);

  ApiResendOtpInput(this.email, this.useCase);

  Map<String, dynamic> toJson() => _$ApiResendOtpInputToJson(this);

  factory ApiResendOtpInput.fromApiResendOtpInput(ResendOtpInput input) {
    final _ApiUserOtpVerificationTypeEnum useCaseEnum =
        _getUserOtpUseCaseEnum(input.otpVerificationType);
    return ApiResendOtpInput(input.email, useCaseEnum);
  }
}

_ApiUserOtpVerificationTypeEnum _getUserOtpUseCaseEnum(
    OtpVerificationType usage) {
  switch (usage) {
    case OtpVerificationType.formRegister:
    case OtpVerificationType.changeEmail:
      return _ApiUserOtpVerificationTypeEnum.EMAIL_VERIFICATION;
    case OtpVerificationType.passwordReset:
      return _ApiUserOtpVerificationTypeEnum.PASSWORD_RESET;
    case OtpVerificationType.socialMerge:
    case OtpVerificationType.socialRegister:
    case OtpVerificationType.socialRegister:
      return _ApiUserOtpVerificationTypeEnum.SOCIAL_EMAIL_VERIFICATION;
  }
}

enum _ApiUserOtpVerificationTypeEnum {
  PASSWORD_RESET,
  EMAIL_VERIFICATION,
  SOCIAL_EMAIL_VERIFICATION
}
