import 'package:equatable/equatable.dart';

import '../otp_verification_type.dart';

class ResendOtpInput extends Equatable {
  final String email;
  final OtpVerificationType otpVerificationType;

  const ResendOtpInput(
      {required this.email, required this.otpVerificationType});

  @override
  List<Object?> get props => [email, otpVerificationType];
}
