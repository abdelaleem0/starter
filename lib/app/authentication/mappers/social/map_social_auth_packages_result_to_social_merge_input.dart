
import 'package:starter/app/authentication/domain/models/social/merge/social_merge_input.dart';
import 'package:starter/app/authentication/domain/models/social/social_auth_packages_result.dart';

extension ConvertSocialAuthPackagesResultToSocialMergeInput
    on SocialAuthPackagesResult {
  SocialMergeInput mapToMergeInput({String? email}) {
    return SocialMergeInput(
        provider: provider,
        providerId: providerId,
        fcmToken: fcmToken ??'temp-fcm-token',
        email: this.email ?? email ?? '');
  }
}
