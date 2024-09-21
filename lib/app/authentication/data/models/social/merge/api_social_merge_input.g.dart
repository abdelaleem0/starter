// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_social_merge_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiSocialMergeInput _$ApiSocialMergeInputFromJson(Map<String, dynamic> json) =>
    ApiSocialMergeInput(
      providerId: json['providerId'] as String,
      provider:
          $enumDecode(_$ApiSocialProviderTypeEnumEnumMap, json['provider']),
      email: json['email'] as String,
      fcmToken: json['fcmToken'] as String,
      device: $enumDecode(_$ApiDeviceEnumEnumMap, json['device']),
    );

Map<String, dynamic> _$ApiSocialMergeInputToJson(
        ApiSocialMergeInput instance) =>
    <String, dynamic>{
      'providerId': instance.providerId,
      'provider': _$ApiSocialProviderTypeEnumEnumMap[instance.provider]!,
      'email': instance.email,
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
