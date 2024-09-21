// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_update_fcm_token_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiUpdateFcmTokenInput _$ApiUpdateFcmTokenInputFromJson(
        Map<String, dynamic> json) =>
    ApiUpdateFcmTokenInput(
      json['fcmToken'] as String,
      $enumDecode(_$DeviceEnumEnumMap, json['device']),
    );

Map<String, dynamic> _$ApiUpdateFcmTokenInputToJson(
        ApiUpdateFcmTokenInput instance) =>
    <String, dynamic>{
      'fcmToken': instance.fcmToken,
      'device': _$DeviceEnumEnumMap[instance.device]!,
    };

const _$DeviceEnumEnumMap = {
  DeviceEnum.DESKTOP: 'DESKTOP',
  DeviceEnum.IOS: 'IOS',
  DeviceEnum.ANDROID: 'ANDROID',
};
