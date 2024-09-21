import 'package:equatable/equatable.dart';

import '../otp_verification_type.dart';

class OtpVerificationInput extends Equatable {
  final String email;
  final String verificationCode;
  final OtpVerificationType otpVerificationType;

  const OtpVerificationInput({
    required this.otpVerificationType,
    required this.email,
    required this.verificationCode,
  });

  @override
  List<Object?> get props => [
        otpVerificationType,
        email,
        verificationCode,
      ];
}
