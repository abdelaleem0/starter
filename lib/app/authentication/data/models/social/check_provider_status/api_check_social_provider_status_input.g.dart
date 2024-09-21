// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_check_social_provider_status_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiCheckProviderStatusInput _$ApiCheckProviderStatusInputFromJson(
        Map<String, dynamic> json) =>
    ApiCheckProviderStatusInput(
      providerId: json['providerId'] as String,
      provider:
          $enumDecode(_$ApiSocialProviderTypeEnumEnumMap, json['provider']),
      email: json['email'] as String,
      isManuallyEntered: json['isManuallyEntered'] as bool,
    );

Map<String, dynamic> _$ApiCheckProviderStatusInputToJson(
        ApiCheckProviderStatusInput instance) =>
    <String, dynamic>{
      'providerId': instance.providerId,
      'provider': _$ApiSocialProviderTypeEnumEnumMap[instance.provider]!,
      'email': instance.email,
      'isManuallyEntered': instance.isManuallyEntered,
    };

const _$ApiSocialProviderTypeEnumEnumMap = {
  ApiSocialProviderTypeEnum.GOOGLE: 'GOOGLE',
  ApiSocialProviderTypeEnum.APPLE: 'APPLE',
};
