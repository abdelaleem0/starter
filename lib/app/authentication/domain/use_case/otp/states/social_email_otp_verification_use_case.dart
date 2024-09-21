
import 'package:starter/app/authentication/domain/repositories/social_authentication_repository.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:starter/common/domain/models/token.dart';
import 'package:starter/common/domain/use_cases/cached_user_data/set_cached_user_data_use_case.dart';
import 'package:starter/data/preferences/models/cached_user_data.dart';

import '../../../models/otp_verification/otp_verification/otp_verification_input.dart';
import 'i_otp_verification_use_case.dart';

class SocialOtpVerificationUseCase implements IOtpVerificationUseCase {
  final SocialAuthenticationRepository _repository;
  final SetCachedUserDataUseCase _setCachedUserDataUseCase;
  SocialOtpVerificationUseCase(
      this._repository, this._setCachedUserDataUseCase);

  Future<void> _setUserData(CachedUserData data) async {
    await _setCachedUserDataUseCase(data);
  }

  @override
  Future<({bool verifyState, AppUserModel? appUserModel})> verifyOtp(OtpVerificationInput input) async {
    final data = await _repository.verifyOtp(input);
    await _setUserData(CachedUserData(id: data.appUserModel?.id ??"", token: data.appUserModel?.token ?? const Token("", false)));
    return data;
  }
}
