// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_resend_email_verification_code_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResendEmailVerificationCodeInput
    _$ApiResendEmailVerificationCodeInputFromJson(Map<String, dynamic> json) =>
        ApiResendEmailVerificationCodeInput(
          json['email'] as String,
          $enumDecode(
              _$_ApiUserOtpVerificationTypeEnumEnumMap, json['useCase']),
        );

Map<String, dynamic> _$ApiResendEmailVerificationCodeInputToJson(
        ApiResendEmailVerificationCodeInput instance) =>
    <String, dynamic>{
      'email': instance.email,
      'useCase': _$_ApiUserOtpVerificationTypeEnumEnumMap[instance.useCase]!,
    };

const _$_ApiUserOtpVerificationTypeEnumEnumMap = {
  _ApiUserOtpVerificationTypeEnum.PASSWORD_RESET: 'PASSWORD_RESET',
  _ApiUserOtpVerificationTypeEnum.EMAIL_VERIFICATION: 'EMAIL_VERIFICATION',
  _ApiUserOtpVerificationTypeEnum.SOCIAL_EMAIL_VERIFICATION:
      'SOCIAL_EMAIL_VERIFICATION',
};
