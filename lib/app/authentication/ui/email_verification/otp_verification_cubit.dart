import 'package:starter/app/authentication/domain/models/otp_verification/otp_verification/otp_verification_input.dart';
import 'package:starter/app/authentication/domain/models/otp_verification/resond_otp/resend_verification_otp_input.dart';
import 'package:starter/app/authentication/domain/use_case/forget_password_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/otp/check_otp_verification_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/otp/resend_otp/resend_verification_use_case.dart';
import 'package:starter/app/authentication/ui/email_verification/otp_verification_state.dart';
import 'package:starter/common/base/async.dart';
import 'package:starter/common/domain/use_cases/otp/handle_otp_use_case.dart';
import 'package:starter/common/utils/bloc_utils.dart';
import 'package:starter/common/utils/common.dart';
import 'package:starter/common/utils/network_info.dart';
import 'package:starter/di/app_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  late final HandleOTPUseCase _handleOTPUseCase;
  late final ForgetPasswordUseCase _forgotPasswordUseCase;
  late final CheckOtpVerificationUseCase _otpVerificationUseCase;
  late final ResendOtpUseCase _resendOtpUseCase;

  OtpVerificationCubit() : super(const OtpVerificationState.initial()) {
    _loadInjector();
  }

  static OtpVerificationCubit of(BuildContext context) {
    return BlocProvider.of(context);
  }

  void _loadInjector() {
    // _emailUserVerificationUseCase = injector();
    // _resendVerificationUseCase = injector();
    _handleOTPUseCase = injector();
    _forgotPasswordUseCase = injector();
    _otpVerificationUseCase = injector();
    _resendOtpUseCase = injector();
  }

  /// we use both errorMessage and failure states , errorMessage for showing toast to notify user that there is no internet and failure state for showing error message from the backend under otp form
  Future<void> verifyOtp(OtpVerificationInput input) async {
    await handleOTP();
    if (!(state.otp.data?.isBlocked ?? false)) {
      emit(state.reduce(verifyOtp: const Async.loading()));
      await collect(task: () async {
        final data = await _otpVerificationUseCase.execute(input);
        emit(state.reduce(verifyOtp: Async.success(data)));
      }, onError: (errorMessage) async {
        if (!(await injector<NetworkInfo>().hasConnection)) {
          emit(state.reduce(verifyOtp: const Async.initial()));
          emit(state.reduce(errorMessage: errorMessage));
          emit(state.reduce(errorMessage: ""));
        } else {
          emit(
            state.reduce(
              verifyOtp: Async.failure(errorMessage),
            ),
          );
        }
      });
    }
  }

  void restOtp() {
    emit(state.reduce(verifyOtp: const Async.initial()));
  }

  Future<void> forgotPassword(String email) async {
    await handleOTP();
    if (!(state.otp.data?.isBlocked ?? false)) {
      emit(state.reduce(forgotPassword: const Async.initial()));
      await collect(task: () async {
        emit(state.reduce(forgotPassword: const Async.loading()));
        await _forgotPasswordUseCase.execute(email);
        emit(state.reduce(forgotPassword: const Async.successWithoutData()));
        emit(state.reduce(forgotPassword: const Async.initial()));
      }, onError: (errorMessage) {
        emit(state.reduce(forgotPassword: const Async.failure("")));
      }, catchError: (e) {
        logDebug(e);
      });
    }
  }

  Future<void> resendOtp(ResendOtpInput emailVerificationCodeInput) async {
    await handleOTP();
    if (!(state.otp.data?.isBlocked ?? false)) {
      await collect(task: () async {
        emit(state.reduce(resendOtp: const Async.loading()));
        await _resendOtpUseCase.execute(emailVerificationCodeInput);
        emit(state.reduce(resendOtp: const Async.successWithoutData()));
        emit(state.reduce(resendOtp: const Async.initial()));
      }, onError: (errorMessage) {
        emit(state.reduce(resendOtp: Async.failure(errorMessage)));
        emit(state.reduce(resendOtp: const Async.initial()));
      });
    }
  }

  Future<void> handleOTP() async {
    await collect(
      task: () async {
        emit(state.reduce(otp: const Async.loading()));
        final result = await _handleOTPUseCase.execute();
        emit(state.reduce(otp: Async.success(result)));
      },
      onError: (errorMessage) {
        emit(state.reduce(
          otp: Async.failure(errorMessage),
        ));
      },
    );
  }
}
