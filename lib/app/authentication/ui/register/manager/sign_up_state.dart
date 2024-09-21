import 'package:starter/common/base/async.dart';
import 'package:starter/common/domain/models/otp.dart';
import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final Async<void> userRegisterState;
  final Async<OTP> isBlocked;
  final String? errorMessage;

  const SignUpState(this.userRegisterState, this.isBlocked, this.errorMessage);

  const SignUpState.initial()
      : this(
          const Async.initial(),
          const Async.initial(),
          null,
        );

  SignUpState reduce({
    Async<bool>? isEmailExists,
    Async<void>? userRegisterState,
    Async<OTP>? isBlocked,
    String? errorMessage,
  }) {
    return SignUpState(
      userRegisterState ?? this.userRegisterState,
      isBlocked ?? this.isBlocked,
      errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        userRegisterState,
        isBlocked,
        errorMessage,
      ];
}
