// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_resend_otp_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResendOtpInput _$ApiResendOtpInputFromJson(Map<String, dynamic> json) =>
    ApiResendOtpInput(
      json['email'] as String,
      $enumDecode(_$_ApiUserOtpVerificationTypeEnumEnumMap, json['useCase']),
    );

Map<String, dynamic> _$ApiResendOtpInputToJson(ApiResendOtpInput instance) =>
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
