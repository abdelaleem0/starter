import 'package:starter/app/authentication/domain/models/inputs/login_details_input.dart';
import 'package:equatable/equatable.dart';

import '../social_provider_type.dart';

class SocialLogInInput extends Equatable {
  final String providerId;
  final SocialProviderTypeEnum provider;
  final String fcmToken;
  final LoginDetailsInput loginDetailsInput;

  const SocialLogInInput({
    required this.providerId,
    required this.provider,
    required this.fcmToken,
    required this.loginDetailsInput,
  });

  @override
  List<Object?> get props => [providerId, provider, fcmToken];

  @override
  String toString() {
    return 'SocialLogInInput{providerId: $providerId, provider: $provider, fcmToken: $fcmToken}';
  }
}
