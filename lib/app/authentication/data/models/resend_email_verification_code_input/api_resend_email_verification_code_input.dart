// ignore_for_file: library_private_types_in_public_api, constant_identifier_names

import 'package:starter/app/authentication/domain/models/otp_verification/otp_verification_type.dart';
import 'package:starter/app/authentication/domain/models/otp_verification/resond_otp/resend_verification_otp_input.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_resend_email_verification_code_input.g.dart';

@JsonSerializable()
class ApiResendEmailVerificationCodeInput {
  final String email;
  final _ApiUserOtpVerificationTypeEnum useCase;

  factory ApiResendEmailVerificationCodeInput.fromJson(
          Map<String, dynamic> json) =>
      _$ApiResendEmailVerificationCodeInputFromJson(json);

  ApiResendEmailVerificationCodeInput(this.email, this.useCase);

  Map<String, dynamic> toJson() =>
      _$ApiResendEmailVerificationCodeInputToJson(this);

  Map<String, dynamic> toJsonWithoutNulls() {
    final Map<String, dynamic> filteredJson = {};
    toJson().forEach((key, value) {
      if (value != null) {
        filteredJson[key] = value;
      }
    });
    return filteredJson;
  }

  factory ApiResendEmailVerificationCodeInput.fromApiResendEmailVerificationCodeInput(
      ResendOtpInput input) {
    final _ApiUserOtpVerificationTypeEnum useCaseEnum =
    _getUserOtpUseCaseEnum(input.otpVerificationType);
    return ApiResendEmailVerificationCodeInput(input.email, useCaseEnum);
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
      return _ApiUserOtpVerificationTypeEnum.SOCIAL_EMAIL_VERIFICATION;
  }
}

enum _ApiUserOtpVerificationTypeEnum {
  PASSWORD_RESET,
  EMAIL_VERIFICATION,
  SOCIAL_EMAIL_VERIFICATION
}
