// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_logout_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiLogoutInput _$ApiLogoutInputFromJson(Map<String, dynamic> json) =>
    ApiLogoutInput(
      $enumDecode(_$DeviceEnumEnumMap, json['device']),
    );

Map<String, dynamic> _$ApiLogoutInputToJson(ApiLogoutInput instance) =>
    <String, dynamic>{
      'device': _$DeviceEnumEnumMap[instance.device]!,
    };

const _$DeviceEnumEnumMap = {
  DeviceEnum.DESKTOP: 'DESKTOP',
  DeviceEnum.IOS: 'IOS',
  DeviceEnum.ANDROID: 'ANDROID',
};
