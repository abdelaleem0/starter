import 'package:starter/app/authentication/data/models/register/api_register_input.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/models/social/login/social_login_input.dart';
import '../api_social_provider_type.dart';

part 'api_social_login_input.g.dart';

@JsonSerializable()
class ApiSocialLogInInput {
  final String providerId;
  final ApiSocialProviderTypeEnum provider;
  final ApiDeviceEnum device;
  final String fcmToken;
  // final ApiLoginDetailsInput apiLoginDetailsInput;

  factory ApiSocialLogInInput.fromJson(Map<String, dynamic> json) =>
      _$ApiSocialLogInInputFromJson(json);

  factory ApiSocialLogInInput.fromInput(SocialLogInInput input) {
    final ApiDeviceEnum deviceEnum = getDeviceType();
    return ApiSocialLogInInput(
        providerId: input.providerId,
        provider:ApiSocialProviderTypeMapper.map(input.provider),
        fcmToken: input.fcmToken,
        // apiLoginDetailsInput:
        // ApiLoginDetailsInput.fromInput(input.loginDetailsInput),
        device: deviceEnum);
  }

  ApiSocialLogInInput({
    required this.providerId,
    required this.provider,
    required this.fcmToken,
    required this.device,
    // required this.apiLoginDetailsInput,
  });

  Map<String, dynamic> toJson() => _$ApiSocialLogInInputToJson(this);
}
