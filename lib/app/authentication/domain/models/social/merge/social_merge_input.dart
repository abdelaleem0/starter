import 'package:equatable/equatable.dart';

import '../social_provider_type.dart';

class SocialMergeInput extends Equatable {
  final String providerId;
  final SocialProviderTypeEnum provider;
  final String email;
  final String fcmToken;

  const SocialMergeInput(
      {required this.providerId,required this.provider,required this.email,required this.fcmToken});

  @override
  List<Object?> get props => [providerId, provider, email, fcmToken];
}
