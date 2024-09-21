
import 'package:starter/app/authentication/domain/repositories/user_authentication_repository.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';

import '../../../models/otp_verification/otp_verification/otp_verification_input.dart';
import 'i_otp_verification_use_case.dart';

class ForgetPasswordOtpVerificationUseCase implements IOtpVerificationUseCase {
  final UserAuthenticationRepository _authenticationRepository;

  ForgetPasswordOtpVerificationUseCase(this._authenticationRepository);

  @override
  Future<({bool verifyState, AppUserModel? appUserModel})> verifyOtp(OtpVerificationInput input) async {
    return (verifyState : await _authenticationRepository.forgetPasswordOtpVerification(input) ,appUserModel: null);
  }
}
