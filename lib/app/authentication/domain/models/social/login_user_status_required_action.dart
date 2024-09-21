import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:equatable/equatable.dart';

import 'check_provider_status/social_register_response_required_action.dart';
import 'social_auth_packages_result.dart';

class LogInUserStatusRequiredAction extends Equatable {
  final SocialProviderStatusRequiredActionEnum? actionRequired;
  final SocialAuthPackagesResult packagesResult;
  final AppUserModel? appUserModel;

  const LogInUserStatusRequiredAction({
    required this.packagesResult,
    this.actionRequired,
    this.appUserModel,
  });


  LogInUserStatusRequiredAction modify({
    SocialProviderStatusRequiredActionEnum? actionRequired,
    SocialAuthPackagesResult? packagesResult,
    AppUserModel? appUserModel,
  }) {
    return LogInUserStatusRequiredAction(
      packagesResult: packagesResult ?? this.packagesResult,
      actionRequired: actionRequired ?? this.actionRequired,
      appUserModel: appUserModel ?? this.appUserModel,
    );
  }

  @override
  List<Object?> get props =>
      [packagesResult, actionRequired,
        appUserModel
      ];
}
