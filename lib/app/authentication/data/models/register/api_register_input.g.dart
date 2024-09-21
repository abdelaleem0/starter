// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_register_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiRegisterInput _$ApiRegisterInputFromJson(Map<String, dynamic> json) =>
    ApiRegisterInput(
      email: json['email'] as String,
      password: json['password'] as String,
      loginDetails: ApiLoginDetailsInput.fromJson(
          json['loginDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiRegisterInputToJson(ApiRegisterInput instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'loginDetails': instance.loginDetails,
    };
