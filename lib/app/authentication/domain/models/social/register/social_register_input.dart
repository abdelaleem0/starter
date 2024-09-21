import 'package:starter/app/authentication/domain/models/inputs/login_details_input.dart';
import 'package:starter/app/authentication/domain/models/social/social_provider_type.dart';
import 'package:starter/common/utils/media_utils/src/domain/models/attachment_entity.dart';
import 'package:equatable/equatable.dart';

class SocialRegisterInput extends Equatable {
  final String providerId;
  final SocialProviderTypeEnum provider;
  final String email;
  final bool isEmailManuallyEntered;
  final LoginDetailsInput loginDetailsInput;

  const SocialRegisterInput(
      {required this.providerId,
      required this.provider,
      required this.email,
      required this.isEmailManuallyEntered,
      required this.loginDetailsInput});

  SocialRegisterInput modify({String? fcmToken, Attachment? profilePicture}) {
    return SocialRegisterInput(
      providerId: providerId,
      provider: provider,
      email: email,
      isEmailManuallyEntered: isEmailManuallyEntered,
      loginDetailsInput: loginDetailsInput,
    );
  }

  @override
  List<Object?> get props =>
      [providerId, provider, email, isEmailManuallyEntered, loginDetailsInput];
}
