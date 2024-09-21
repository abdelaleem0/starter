
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';

import '../../../models/otp_verification/otp_verification/otp_verification_input.dart';

abstract class IOtpVerificationUseCase {
  Future<({bool verifyState, AppUserModel? appUserModel})> verifyOtp(OtpVerificationInput input);
}
