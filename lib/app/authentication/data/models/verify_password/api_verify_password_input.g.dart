// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_verify_password_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiVerifyPasswordInput _$ApiVerifyPasswordInputFromJson(
        Map<String, dynamic> json) =>
    ApiVerifyPasswordInput(
      code: json['code'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$ApiVerifyPasswordInputToJson(
        ApiVerifyPasswordInput instance) =>
    <String, dynamic>{
      'code': instance.code,
      'email': instance.email,
    };
