// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_login_details_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiLoginDetailsInput _$ApiLoginDetailsInputFromJson(
        Map<String, dynamic> json) =>
    ApiLoginDetailsInput(
      deviceName: json['deviceName'] as String,
      fcmToken: json['fcmToken'] as String,
      device: $enumDecode(_$ApiDeviceEnumEnumMap, json['device']),
    );

Map<String, dynamic> _$ApiLoginDetailsInputToJson(
        ApiLoginDetailsInput instance) =>
    <String, dynamic>{
      'deviceName': instance.deviceName,
      'fcmToken': instance.fcmToken,
      'device': _$ApiDeviceEnumEnumMap[instance.device]!,
    };

const _$ApiDeviceEnumEnumMap = {
  ApiDeviceEnum.DESKTOP: 'DESKTOP',
  ApiDeviceEnum.IOS: 'IOS',
  ApiDeviceEnum.ANDROID: 'ANDROID',
};
