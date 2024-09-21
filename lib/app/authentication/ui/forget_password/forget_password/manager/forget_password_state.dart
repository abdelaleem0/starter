import 'package:starter/common/base/async.dart';
import 'package:equatable/equatable.dart';

class ForgetPasswordState extends Equatable {
  const ForgetPasswordState(
      this.verifyEmailState,
      this.errorMessage,
      );

  final Async<void> verifyEmailState;

  final String? errorMessage;

  const ForgetPasswordState.initial()
      : this(const Async.initial(), null);

  ForgetPasswordState reduce(
      {Async<void>? verifyEmailState,
        String? errorMessage}) {
    return ForgetPasswordState(verifyEmailState ?? this.verifyEmailState, errorMessage);
  }

  @override
  List<Object?> get props => [verifyEmailState, errorMessage];
}