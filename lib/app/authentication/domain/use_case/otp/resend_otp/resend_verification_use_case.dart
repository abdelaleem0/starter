

import 'package:starter/app/authentication/domain/models/otp_verification/resond_otp/resend_verification_otp_input.dart';
import 'package:starter/app/authentication/domain/repositories/user_authentication_repository.dart';

class ResendOtpUseCase {
  final UserAuthenticationRepository _repository;

  ResendOtpUseCase(
    this._repository,
  );

  Future<bool> execute(ResendOtpInput input) async {
    final result = await _repository.resendOtp(input);
    return result;
  }
}
