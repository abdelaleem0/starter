import 'dart:io';

import 'package:starter/app/authentication/data/models/register/api_login_details/api_login_details_input.dart';
import 'package:starter/app/authentication/domain/models/inputs/login_details_input.dart';
import 'package:starter/app/authentication/domain/models/inputs/register_input.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_register_input.g.dart';

@JsonSerializable()
class ApiRegisterInput {
  final String email;
  final String password;
  final ApiLoginDetailsInput loginDetails;

  ApiRegisterInput(
      {required this.email,
      required this.password,
      required this.loginDetails});

  factory ApiRegisterInput.fromJson(Map<String, dynamic> json) =>
      _$ApiRegisterInputFromJson(json);

  Map<String, dynamic> toJson() => _$ApiRegisterInputToJson(this);

  Map<String, dynamic> toJsonWithoutNulls() {
    final Map<String, dynamic> filteredJson = {};
    toJson().forEach((key, value) {
      if (value != null) {
        filteredJson[key] = value;
      }
    });
    return filteredJson;
  }

  factory ApiRegisterInput.fromRegisterInput(
      RegisterInput input, LoginDetailsInput loginDetailsInput) {
    return ApiRegisterInput(
        email: input.email,
        password: input.password,
        loginDetails:
        ApiLoginDetailsInput.fromUserLoginDetailsInput(loginDetailsInput)
    );
  }
}

enum ApiDeviceEnum { DESKTOP, IOS, ANDROID }

ApiDeviceEnum getDeviceType() {
  if (Platform.isAndroid) {
    return ApiDeviceEnum.ANDROID;
  } else if (Platform.isIOS) {
    return ApiDeviceEnum.IOS;
  } else {
    return ApiDeviceEnum.DESKTOP;
  }
}
