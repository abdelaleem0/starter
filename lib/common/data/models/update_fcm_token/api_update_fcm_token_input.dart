import 'package:json_annotation/json_annotation.dart';

part 'api_update_fcm_token_input.g.dart';

@JsonSerializable()
class ApiUpdateFcmTokenInput {
  final String fcmToken;
  final DeviceEnum device;

  factory ApiUpdateFcmTokenInput.fromJson(Map<String, dynamic> json) =>
      _$ApiUpdateFcmTokenInputFromJson(json);

  ApiUpdateFcmTokenInput(this.fcmToken, this.device);

  Map<String, dynamic> toJson() => _$ApiUpdateFcmTokenInputToJson(this);

}

enum DeviceEnum {
  DESKTOP,
  IOS,
  ANDROID,
}