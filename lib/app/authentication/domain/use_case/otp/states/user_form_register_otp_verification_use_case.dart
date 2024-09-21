import 'package:starter/app/authentication/domain/repositories/user_authentication_repository.dart';
import 'package:starter/common/blocs/user_cubit/user_cubit.dart';
import 'package:starter/common/domain/models/token.dart';
import 'package:starter/common/domain/use_cases/cached_user_data/set_cached_user_data_use_case.dart';
import 'package:starter/data/preferences/models/cached_user_data.dart';

import '../../../models/otp_verification/otp_verification/otp_verification_input.dart';
import 'i_otp_verification_use_case.dart';

class UserFormRegisterOtpVerificationUseCase
    implements IOtpVerificationUseCase {
  final UserAuthenticationRepository _repository;
  final SetCachedUserDataUseCase _setCachedUserDataUseCase;

  UserFormRegisterOtpVerificationUseCase(
    this._repository, this._setCachedUserDataUseCase,
  );

  @override
  Future<({bool verifyState, AppUserModel? appUserModel})> verifyOtp(OtpVerificationInput input) async {
    final userData = await _repository.registerOtpVerification(input);
    await _setCachedUserDataUseCase(CachedUserData(id: userData.appUserModel?.id ?? '', token: Token(userData.appUserModel?.token?.token?? '',true)));
    return userData;
  }
}
