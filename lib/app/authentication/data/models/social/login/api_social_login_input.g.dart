// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_social_login_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiSocialLogInInput _$ApiSocialLogInInputFromJson(Map<String, dynamic> json) =>
    ApiSocialLogInInput(
      providerId: json['providerId'] as String,
      provider:
          $enumDecode(_$ApiSocialProviderTypeEnumEnumMap, json['provider']),
      fcmToken: json['fcmToken'] as String,
      device: $enumDecode(_$ApiDeviceEnumEnumMap, json['device']),
    );

Map<String, dynamic> _$ApiSocialLogInInputToJson(
        ApiSocialLogInInput instance) =>
    <String, dynamic>{
      'providerId': instance.providerId,
      'provider': _$ApiSocialProviderTypeEnumEnumMap[instance.provider]!,
      'device': _$ApiDeviceEnumEnumMap[instance.device]!,
      'fcmToken': instance.fcmToken,
    };

const _$ApiSocialProviderTypeEnumEnumMap = {
  ApiSocialProviderTypeEnum.GOOGLE: 'GOOGLE',
  ApiSocialProviderTypeEnum.APPLE: 'APPLE',
};

const _$ApiDeviceEnumEnumMap = {
  ApiDeviceEnum.DESKTOP: 'DESKTOP',
  ApiDeviceEnum.IOS: 'IOS',
  ApiDeviceEnum.ANDROID: 'ANDROID',
};
