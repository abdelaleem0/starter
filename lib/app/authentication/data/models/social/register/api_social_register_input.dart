import 'package:starter/app/authentication/data/models/register/api_login_details/api_login_details_input.dart';
import 'package:starter/app/authentication/data/models/social/api_social_provider_type.dart';
import 'package:starter/app/authentication/domain/models/social/register/social_register_input.dart';
import 'package:json_annotation/json_annotation.dart';
part 'api_social_register_input.g.dart';


@JsonSerializable()
class ApiSocialRegisterInput {
  final String providerId;
  final ApiSocialProviderTypeEnum provider;
  final String email;
  final bool isManuallyEntered;
  final ApiLoginDetailsInput loginDetails;


  factory ApiSocialRegisterInput.fromJson(Map<String, dynamic> json) =>
      _$ApiSocialRegisterInputFromJson(json);

  factory ApiSocialRegisterInput.fromInput(SocialRegisterInput input) {
    return ApiSocialRegisterInput(
      loginDetails: ApiLoginDetailsInput.fromInput(input.loginDetailsInput),
      providerId: input.providerId,
      provider:ApiSocialProviderTypeMapper.map(input.provider),
      email: input.email,
      isManuallyEntered: input.isEmailManuallyEntered,
    );
  }

  ApiSocialRegisterInput(
      {
        required this.providerId,
      required this.provider,
      required this.email,
      required this.isManuallyEntered,
        required this.loginDetails,
      });

  Map<String, dynamic> toJson() => _$ApiSocialRegisterInputToJson(this);
}



