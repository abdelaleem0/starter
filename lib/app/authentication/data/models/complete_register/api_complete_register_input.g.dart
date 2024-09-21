// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_complete_register_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiCompleteRegisterInput _$ApiCompleteRegisterInputFromJson(
        Map<String, dynamic> json) =>
    ApiCompleteRegisterInput(
      firstName: json['firstName'] as String,
      userName: json['userName'] as String,
      fcmToken: json['fcmToken'] as String?,
      device: $enumDecode(_$ApiDeviceEnumEnumMap, json['device']),
      profilePicture: json['profilePicture'] as String?,
    );

Map<String, dynamic> _$ApiCompleteRegisterInputToJson(
        ApiCompleteRegisterInput instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'userName': instance.userName,
      'fcmToken': instance.fcmToken,
      'device': _$ApiDeviceEnumEnumMap[instance.device]!,
      'profilePicture': instance.profilePicture,
    };

const _$ApiDeviceEnumEnumMap = {
  ApiDeviceEnum.DESKTOP: 'DESKTOP',
  ApiDeviceEnum.IOS: 'IOS',
  ApiDeviceEnum.ANDROID: 'ANDROID',
};
