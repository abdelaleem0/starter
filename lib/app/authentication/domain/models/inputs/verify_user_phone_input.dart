import 'package:starter/app/authentication/domain/models/verification_usage.dart';
import 'package:equatable/equatable.dart';

class VerifyUserPhoneInput extends Equatable {
  final String phoneNumber;
  final VerificationUsage verificationCode;
  final String code;

  const VerifyUserPhoneInput({
    required this.phoneNumber,
    required this.verificationCode,
    required this.code,
  });

  @override
  List<Object?> get props => [
        phoneNumber,
        verificationCode,
        code,
      ];
}
