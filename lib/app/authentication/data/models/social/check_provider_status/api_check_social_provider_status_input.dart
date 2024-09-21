import 'package:json_annotation/json_annotation.dart';
import '../../../../domain/models/social/check_provider_status/social_check_provider_status_input.dart';
import '../api_social_provider_type.dart';
part 'api_check_social_provider_status_input.g.dart';

@JsonSerializable()
class ApiCheckProviderStatusInput {
  final String providerId;
  final ApiSocialProviderTypeEnum provider;
  final String email;
  final bool isManuallyEntered;

  factory ApiCheckProviderStatusInput.fromJson(Map<String, dynamic> json) =>
      _$ApiCheckProviderStatusInputFromJson(json);

  factory ApiCheckProviderStatusInput.fromInput(
      SocialCheckProviderStatusInput input) {
    return ApiCheckProviderStatusInput(
      providerId: input.providerId,
      provider:ApiSocialProviderTypeMapper.map(input.provider),
      email: input.email,
      isManuallyEntered: input.isEmailManuallyEntered,
    );
  }

  ApiCheckProviderStatusInput({
    required this.providerId,
    required this.provider,
    required this.email,
    required this.isManuallyEntered,
  });

  Map<String, dynamic> toJson() => _$ApiCheckProviderStatusInputToJson(this);
}
