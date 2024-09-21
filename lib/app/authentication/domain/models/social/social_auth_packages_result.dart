import 'package:equatable/equatable.dart';

import 'social_provider_type.dart';

// ignore: must_be_immutable
class SocialAuthPackagesResult extends Equatable {
  final String providerId;
  final SocialProviderTypeEnum provider;
  final String? email;
  final String? serverAuthCode;
  final String? userFullName;
  String? firstName;
  String? lastName;
  final bool? isEmailManuallyEntered;
  final String? imageUrl;
  final String? fcmToken;

  SocialAuthPackagesResult({
    required this.providerId,
    required this.provider,
    this.email,
    this.userFullName,
    this.serverAuthCode,
    this.imageUrl,
    this.fcmToken,
    this.isEmailManuallyEntered = false,
  }) {
    firstName = userFullName?.split(' ').first;
    lastName = userFullName?.split(' ').last;
  }

  SocialAuthPackagesResult modify(
      {String? email, String? fcmToken, bool? isEmailManuallyEntered}) {
    return SocialAuthPackagesResult(
      providerId: providerId,
      provider: provider,
      email: email ?? this.email,
      imageUrl: imageUrl,
      serverAuthCode: serverAuthCode,
      userFullName: userFullName,
      fcmToken: fcmToken ?? this.fcmToken,
      isEmailManuallyEntered:
          isEmailManuallyEntered ?? this.isEmailManuallyEntered,
    );
  }

  @override
  List<Object?> get props => [
        providerId,
        provider,
        email,
        userFullName,
        firstName,
        lastName,
        imageUrl,
        serverAuthCode,
        fcmToken
      ];

  @override
  String toString() {
    return 'SocialAuthPackagesResult{providerId: $providerId, provider: $provider, email: $email, serverAuthCode: $serverAuthCode, userFullName: $userFullName, firstName: $firstName, lastName: $lastName, isEmailManuallyEntered: $isEmailManuallyEntered, imageUrl: $imageUrl, fcmToken: $fcmToken}';
  }
}
