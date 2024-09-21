import 'package:starter/common/domain/models/otp.dart';
import 'package:starter/common/domain/repositories/otp_repository.dart';

class SetOTPUseCase {
  final OTPRepository _otpRepository;

  SetOTPUseCase(this._otpRepository);

  Future<void> execute(OTP otp) async {
    await _otpRepository.setOTP(otp);
  }
}
