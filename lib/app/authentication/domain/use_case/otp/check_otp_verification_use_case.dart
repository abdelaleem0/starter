
import 'package:starter/app/authentication/domain/models/otp_verification/otp_verification/otp_verification_input.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';

import 'otp_verification_factory.dart';
import 'states/i_otp_verification_use_case.dart';

class CheckOtpVerificationUseCase {
  final OtpVerificationFactory _factory;
  CheckOtpVerificationUseCase(this._factory);
  Future<({bool verifyState, AppUserModel? appUserModel})> execute(
    OtpVerificationInput input,
  ) async {
    IOtpVerificationUseCase verificationUseCase =
        _factory.getType(input.otpVerificationType);
    return await verificationUseCase.verifyOtp(input);
  }
}
