import 'package:starter/app/authentication/domain/models/social/login_user_status_required_action.dart';
import 'package:starter/common/base/async.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:equatable/equatable.dart';

class SocialAuthStates extends Equatable {
  final Async<LogInUserStatusRequiredAction> logInStatusRequiredAction;
  final Async<AppUserModel> socialRegisterState;
  final String? errorMessage;

  const SocialAuthStates(
    this.logInStatusRequiredAction,
    this.socialRegisterState,
    this.errorMessage,
  );

  const SocialAuthStates.initial()
      : this(
          const Async.initial(),
          const Async.initial(),
          null,
        );

  SocialAuthStates reduce(
      {Async<LogInUserStatusRequiredAction>? logInStatusRequiredAction,
      Async<AppUserModel>? socialRegisterState,
      String? errorMessage}) {
    return SocialAuthStates(
        logInStatusRequiredAction ?? this.logInStatusRequiredAction,
        socialRegisterState ?? this.socialRegisterState,
        errorMessage);
  }

  @override
  List<Object?> get props => [
        socialRegisterState,
        logInStatusRequiredAction,
        errorMessage
      ];
}
