import 'package:starter/app/authentication/domain/models/social/social_provider_type.dart';
import 'package:equatable/equatable.dart';

class SocialCheckProviderStatusInput extends Equatable {
  final String providerId;
  final SocialProviderTypeEnum provider;
  final String email;
  final bool isEmailManuallyEntered;

  const SocialCheckProviderStatusInput(
      {required this.providerId,
      required this.provider,
      required this.email,
      required this.isEmailManuallyEntered});

  @override
  List<Object?> get props =>
      [providerId, provider, email, isEmailManuallyEntered];
}
