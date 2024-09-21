import 'package:starter/app/authentication/domain/models/inputs/forgot_password_input.dart';
import 'package:starter/app/authentication/domain/use_case/forget_password_use_case.dart';
import 'package:starter/app/authentication/ui/forget_password/forget_password/manager/forget_password_state.dart';
import 'package:starter/common/base/async.dart';
import 'package:starter/common/utils/bloc_utils.dart';
import 'package:starter/di/app_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(const ForgetPasswordState.initial()) {
    _forgotPasswordUseCase = injector();
  }

  late final ForgetPasswordUseCase _forgotPasswordUseCase;

  static ForgetPasswordCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> verifyEmail(ForgotPasswordInput forgetPassword) async {
    emit(state.reduce(verifyEmailState: const Async.loading()));
    await collect(
      task: () async {
        await _forgotPasswordUseCase.execute(forgetPassword.email);
        emit(state.reduce(verifyEmailState: const Async.successWithoutData()));
        emit(state.reduce(verifyEmailState: const Async.initial()));
      },
      onError: (errorMessage) {
        emit(state.reduce(
            errorMessage: errorMessage,
            verifyEmailState: Async.failure(errorMessage)));
      },
    );
  }
}
