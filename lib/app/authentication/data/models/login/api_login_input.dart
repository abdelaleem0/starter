import 'dart:io';
import 'package:starter/app/authentication/domain/models/inputs/login_input.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_login_input.g.dart';

@JsonSerializable()
class ApiLoginInput {
  final String email;
  final String password;
  final String? fcmToken;
  final DeviceEnum? device;

  ApiLoginInput({
    required this.email,
    required this.password,
    this.device,
    this.fcmToken,
  });

  factory ApiLoginInput.fromJson(Map<String, dynamic> json) =>
      _$ApiLoginInputFromJson(json);

  Map<String, dynamic> toJson() => _$ApiLoginInputToJson(this);

  Map<String, dynamic> toJsonWithoutNulls() {
    final Map<String, dynamic> filteredJson = {};
    toJson().forEach((key, value) {
      if (value != null) {
        filteredJson[key] = value;
      }
    });
    return filteredJson;
  }

  factory ApiLoginInput.fromLoginInput(
      LoginInput input) {
    final DeviceEnum deviceEnum = getDeviceType();
    return ApiLoginInput(
        email: input.email,
        password: input.password,
        device: deviceEnum,
        fcmToken: input.fcmToken,
    );
  }
}

enum DeviceEnum { DESKTOP, IOS, ANDROID }

DeviceEnum getDeviceType() {
  if (Platform.isAndroid) {
    return DeviceEnum.ANDROID;
  } else if (Platform.isIOS) {
    return DeviceEnum.IOS;
  } else {
    return DeviceEnum.DESKTOP;
  }
}
