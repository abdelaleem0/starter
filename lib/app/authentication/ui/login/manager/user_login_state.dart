import 'package:starter/common/base/async.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:starter/common/domain/models/otp.dart';
import 'package:equatable/equatable.dart';

class UserLoginState extends Equatable {
  final Async<AppUserModel> loginState;
  final String? errorMessage;

  const UserLoginState(this.loginState, this.errorMessage);

  const UserLoginState.initial()
      : this(
          const Async.initial(),
          null,
        );

  UserLoginState reduce({
    Async<AppUserModel>? loginState,
    Async<OTP>? isBlocked,
    Async<void>? notBlocked,
    String? errorMessage,
  }) {
    return UserLoginState(
      loginState ?? this.loginState,
      errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        loginState,
        errorMessage,
      ];
}
