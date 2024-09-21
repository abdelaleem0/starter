import 'package:starter/app/authentication/data/models/register/api_register_input.dart';
import 'package:starter/app/authentication/domain/models/inputs/login_details_input.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_login_details_input.g.dart';

@JsonSerializable()
class ApiLoginDetailsInput extends Equatable {
  final String deviceName;
  final String fcmToken;
  final ApiDeviceEnum device;

  const ApiLoginDetailsInput({
    required this.deviceName,
    required this.fcmToken,
    required this.device,
  });

  factory ApiLoginDetailsInput.fromJson(Map<String, dynamic> json) =>
      _$ApiLoginDetailsInputFromJson(json);

  Map<String, dynamic> toJson() => _$ApiLoginDetailsInputToJson(this);


  factory ApiLoginDetailsInput.fromInput(LoginDetailsInput input) {
    final ApiDeviceEnum deviceEnum = getDeviceType();

    return ApiLoginDetailsInput(
        deviceName: input.deviceName??'',
      fcmToken: input.fcmToken,
      device:deviceEnum,
    );
  }

  factory ApiLoginDetailsInput.fromUserLoginDetailsInput(
      LoginDetailsInput userLoginDetailsInput) {
    final ApiDeviceEnum deviceEnum = getDeviceType();

    return ApiLoginDetailsInput(
        deviceName: userLoginDetailsInput.deviceName??'',
      fcmToken: userLoginDetailsInput.fcmToken,
      device: deviceEnum,
    );
  }

  @override
  List<Object?> get props => [deviceName,fcmToken,device];
}
