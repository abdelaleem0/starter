part of 'reset_password_cubit.dart';

class ResetPasswordState extends Equatable {
  final Async<String> resetPasswordState;
  final String? errorMessage;

  const ResetPasswordState(this.resetPasswordState, this.errorMessage);

  const ResetPasswordState.initial()
      : this(
          const Async.initial(),
          null,
        );

  ResetPasswordState reduce({
    Async<String>? resetPasswordState,
    String? errorMessage,
  }) {
    return ResetPasswordState(
      resetPasswordState ?? this.resetPasswordState,
      errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        resetPasswordState,
        errorMessage,
      ];
}
