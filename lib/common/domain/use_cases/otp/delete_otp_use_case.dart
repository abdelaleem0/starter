import 'package:starter/common/domain/repositories/otp_repository.dart';

class DeleteOTPUseCase{
  final OTPRepository _otpRepository;

  DeleteOTPUseCase(this._otpRepository);

  Future<void> execute()async{
    await _otpRepository.deleteOTP();
  }
}