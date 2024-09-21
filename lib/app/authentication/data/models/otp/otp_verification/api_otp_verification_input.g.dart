// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_otp_verification_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiOtpVerificationInput _$ApiOtpVerificationInputFromJson(
        Map<String, dynamic> json) =>
    ApiOtpVerificationInput(
      json['email'] as String,
      json['verificationCode'] as String,
    );

Map<String, dynamic> _$ApiOtpVerificationInputToJson(
        ApiOtpVerificationInput instance) =>
    <String, dynamic>{
      'email': instance.email,
      'verificationCode': instance.verificationCode,
    };
