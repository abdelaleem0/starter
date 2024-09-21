// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_verify_email_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiVerifyEmailUserInput _$ApiVerifyEmailUserInputFromJson(
        Map<String, dynamic> json) =>
    ApiVerifyEmailUserInput(
      verificationCode: json['verificationCode'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$ApiVerifyEmailUserInputToJson(
        ApiVerifyEmailUserInput instance) =>
    <String, dynamic>{
      'verificationCode': instance.verificationCode,
      'email': instance.email,
    };
