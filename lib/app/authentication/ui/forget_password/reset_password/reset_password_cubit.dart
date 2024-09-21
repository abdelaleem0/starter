import 'package:starter/app/authentication/domain/models/inputs/update_password_input.dart';
import 'package:starter/common/base/async.dart';
import 'package:starter/common/utils/bloc_utils.dart';
import 'package:starter/app/authentication/domain/use_case/update_password_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit
    extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase _updatePasswordUseCase;

  ResetPasswordCubit(this._updatePasswordUseCase)
      : super(const ResetPasswordState.initial());

  Future<void> resetPassword(UpdatePasswordInput updatePasswordInput) async {
    await collect(
      task: () async {
        emit(state.reduce(resetPasswordState: const Async.loading()));
        final verifiedEmail=await _updatePasswordUseCase.execute(updatePasswordInput);
        emit(state.reduce(resetPasswordState:  Async.success(verifiedEmail)));
      },
      onError: (errorMessage) {
        emit(
          state.reduce(
            resetPasswordState: Async.failure(errorMessage.toString()),
            errorMessage: errorMessage,
          ),
        );
      },
    );
  }
  void setUpdatePasswordError(String errorMessage){
    emit(state.reduce(resetPasswordState: const Async.initial()));
    emit(
      state.reduce(
        resetPasswordState: Async.failure(errorMessage.toString()),
        errorMessage: errorMessage,
      ),
    );
  }
}
