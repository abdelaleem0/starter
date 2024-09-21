import 'package:starter/app/authentication/data/models/register/api_register_input.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../../domain/models/social/merge/social_merge_input.dart';
import '../api_social_provider_type.dart';
part 'api_social_merge_input.g.dart';

@JsonSerializable()
class ApiSocialMergeInput {
  final String providerId;
  final ApiSocialProviderTypeEnum provider;
  final String email;
  final ApiDeviceEnum device;
  final String fcmToken;

  factory ApiSocialMergeInput.fromJson(Map<String, dynamic> json) =>
      _$ApiSocialMergeInputFromJson(json);

  factory ApiSocialMergeInput.fromInput(SocialMergeInput input) {
    final ApiDeviceEnum deviceEnum = getDeviceType();
    return ApiSocialMergeInput(
        providerId: input.providerId,
        provider:ApiSocialProviderTypeMapper.map(input.provider),
        fcmToken: input.fcmToken,
        email: input.email,
        device: deviceEnum);
  }

  ApiSocialMergeInput({
    required this.providerId,
    required this.provider,
    required this.email,
    required this.fcmToken,
    required this.device,
  });

  Map<String, dynamic> toJson() => _$ApiSocialMergeInputToJson(this);
}
