import 'package:starter/common/base/async.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:starter/common/domain/models/otp.dart';
import 'package:equatable/equatable.dart';

class OtpVerificationState extends Equatable {
  final Async<({bool verifyState, AppUserModel? appUserModel})> verifyOtp;
  final String? errorMessage;
  final Async<bool> resendOtp;
  final Async<OTP> otp;
  final Async<void> forgotPassword;

  const OtpVerificationState(
    this.verifyOtp,
    this.errorMessage,
    this.resendOtp,
    this.otp,
    this.forgotPassword,
  );

  const OtpVerificationState.initial()
      : this(
          const Async.initial(),
          null,
          const Async.initial(),
          const Async.initial(),
          const Async.initial(),
        );

  OtpVerificationState reduce({
    Async<({bool verifyState, AppUserModel? appUserModel})>? verifyOtp,
    String? errorMessage,
    Async<bool>? resendOtp,
    Async<OTP>? otp,
    Async<void>? forgotPassword,
  }) {
    return OtpVerificationState(
      verifyOtp ?? this.verifyOtp,
      errorMessage,
      resendOtp ?? this.resendOtp,
      otp ?? this.otp,
      forgotPassword ?? this.forgotPassword,
    );
  }

  @override
  List<Object?> get props => [
        verifyOtp,
        errorMessage,
        resendOtp,
        otp,
        forgotPassword,
      ];
}
