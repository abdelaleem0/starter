// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_social_register_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiSocialRegisterInput _$ApiSocialRegisterInputFromJson(
        Map<String, dynamic> json) =>
    ApiSocialRegisterInput(
      providerId: json['providerId'] as String,
      provider:
          $enumDecode(_$ApiSocialProviderTypeEnumEnumMap, json['provider']),
      email: json['email'] as String,
      isManuallyEntered: json['isManuallyEntered'] as bool,
      loginDetails: ApiLoginDetailsInput.fromJson(
          json['loginDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiSocialRegisterInputToJson(
        ApiSocialRegisterInput instance) =>
    <String, dynamic>{
      'providerId': instance.providerId,
      'provider': _$ApiSocialProviderTypeEnumEnumMap[instance.provider]!,
      'email': instance.email,
      'isManuallyEntered': instance.isManuallyEntered,
      'loginDetails': instance.loginDetails,
    };

const _$ApiSocialProviderTypeEnumEnumMap = {
  ApiSocialProviderTypeEnum.GOOGLE: 'GOOGLE',
  ApiSocialProviderTypeEnum.APPLE: 'APPLE',
};
