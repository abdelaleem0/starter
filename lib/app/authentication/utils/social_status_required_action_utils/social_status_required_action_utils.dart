import 'package:starter/app/authentication/domain/models/social/check_provider_status/social_register_response_required_action.dart';
import 'package:starter/app/authentication/domain/models/social/social_provider_type.dart';
import 'package:starter/app/authentication/ui/complete_register/first_name/first_name_page.dart';
import 'package:starter/app/authentication/ui/email_verification/otp_verification_page.dart';
import 'package:starter/app/authentication/ui/social/email_page/social_email_page.dart';
import 'package:starter/app/authentication/ui/social/merge/social_merge_bottom_sheet.dart';
import 'package:starter/app/authentication/ui/social/provider_inherited_widget/provider_inherited_widget.dart';
import 'package:starter/common/utils/app_routes/router_functions.dart';
import 'package:starter/common/utils/assets_paths/svg_paths.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/models/otp_verification/otp_verification_type.dart';
class SocialStatusRequiredActionUtils {
  void call(BuildContext context,
      {required SocialProviderStatusRequiredActionEnum requiredAction,
      String? email}) {
    final provider = ProviderInheritedWidget.of(context).provider;
    switch (requiredAction) {
      case SocialProviderStatusRequiredActionEnum.register:
        AppRouteNavigator.push(
          context,
          FirstNamePage.routeName,
          const FirstNamePage(isSocial: true),
        );
        break;
      case SocialProviderStatusRequiredActionEnum.registerVerification:
        AppRouteNavigator.push(
            context,
            FirstNamePage.routeName,
            const FirstNamePage(
              isSocial: true,
            ));
        break;
      case SocialProviderStatusRequiredActionEnum.merge:
        SocialMergeBottomSheet.openBottomSheet(
          context: context,
          socialIcon: provider == SocialProviderTypeEnum.apple?SvgPaths.apple:null,
          title: "Looks like you already have an Ajmal account!",
          description: provider == SocialProviderTypeEnum.apple
              ? "An account with this Email address already exists and connected to Apple, Would you like to link it with this Apple account?"
              : "An account with this Email address already exists and connected to Google, Would you like to link it with this Google account?",
          confirmButtonText: "Link accounts",
        );
        break;
      case SocialProviderStatusRequiredActionEnum.verificationMerge:
        AppRouteNavigator.push(
          context,
          OtpVerificationPage.routeName,
          OtpVerificationPage(
            otpVerificationType: OtpVerificationType.socialMerge,
            email: email ?? '',
          ),
        );
        break;
      case SocialProviderStatusRequiredActionEnum.mergeSameProvider:
        SocialMergeBottomSheet.openBottomSheet(
          context: context,
          socialIcon:
              provider == SocialProviderTypeEnum.apple ? SvgPaths.apple : null,
          title: "Looks like you already have an Ajmal account!",
          description: provider == SocialProviderTypeEnum.apple
              ? "An account with this email address already exists, would you like to connect Apple as an additional login method and merge the accounts?"
              : "An account with this email address already exists, would you like to connect Google as an additional login method and merge the accounts?",
          confirmButtonText: "Replace accounts",
        );
        break;
      case SocialProviderStatusRequiredActionEnum.verificationMergeSameProvider:
        SocialMergeBottomSheet.openBottomSheet(
          socialIcon:
              provider == SocialProviderTypeEnum.apple ? SvgPaths.apple : null,
          context: context,
          title: "Looks like you already have an Ajmal account!",

          description: provider == SocialProviderTypeEnum.apple
              ? "An account with this Email address already exists and connected to Apple, Would you like to link it with this Apple account?"
              : "An account with this Email address already exists and connected to Google, Would you like to link it with this Google account?",
          confirmButtonText: "Link accounts",
        );
        break;
      case SocialProviderStatusRequiredActionEnum.noEmail:
        AppRouteNavigator.push(
          context,
          SocialEmailPage.routeName,
          const SocialEmailPage(),
        );
        break;
      // case SocialProviderStatusRequiredActionEnum.updateOldUserRegistration:
      //   pushMaterialPage(
      //     context,
      //     const UpdateUserRegistrationPage(),
      //   );
      //   break;
      // case SocialProviderStatusRequiredActionEnum.changeEmail:
      //   pushMaterialPage(
      //     context,
      //     const UserChangeEmailPage(isOldUser: true),
      //   );
      //   break;
    }
  }
}
