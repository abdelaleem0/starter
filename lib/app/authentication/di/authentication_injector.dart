import 'package:starter/app/authentication/data/repository/social_authentication_repository_imp.dart';
import 'package:starter/app/authentication/domain/repositories/social_authentication_repository.dart';
import 'package:starter/app/authentication/domain/repositories/user_authentication_repository.dart';
import 'package:starter/app/authentication/domain/use_case/complete_register_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/is_email_exists_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/is_username_exists_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/logout_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/otp/check_otp_verification_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/otp/otp_verification_factory.dart';
import 'package:starter/app/authentication/domain/use_case/otp/resend_otp/resend_verification_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/otp/states/forget_password_otp_verification_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/otp/states/social_email_otp_verification_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/otp/states/user_form_register_otp_verification_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/social/check_social_provider_status_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/social/social_login_status_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/social/social_login_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/social/social_merge_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/social/social_packages/get_social_package_result_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/social/social_packages/social_auth_packages_factory.dart';
import 'package:starter/app/authentication/domain/use_case/social/social_register_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/user_register_use_case.dart';
import 'package:starter/common/data/otp_repository_imp.dart';
import 'package:starter/common/domain/repositories/otp_repository.dart';
import 'package:starter/common/domain/use_cases/cached_user_data/set_cached_user_apple_email_use_case.dart';
import 'package:starter/common/domain/use_cases/otp/delete_otp_use_case.dart';
import 'package:starter/common/domain/use_cases/otp/get_otp_use_case.dart';
import 'package:starter/common/domain/use_cases/otp/handle_otp_use_case.dart';
import 'package:starter/common/domain/use_cases/otp/set_opt_use_case.dart';
import 'package:starter/di/app_injector.dart';
import 'package:starter/app/authentication/data/repository/user_authentication_repository_imp.dart';
import 'package:starter/app/authentication/domain/use_case/forget_password_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/get_token_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/user_login_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/update_password_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/is_user_authenticated_use_case.dart';

class AuthenticationDi {
  static Future<void> initialize() async {
    injector.registerLazySingleton<UserAuthenticationRepository>(
        () => UserAuthenticationRepositoryImp(injector(), injector()));

    injector
        .registerFactory(() => UserLoginUseCase(injector(),injector(),injector() , injector()));

    injector.registerFactory(
        () => ForgetPasswordUseCase(injector()));
    injector.registerFactory(() => GetTokenUseCase(injector()));

    injector.registerFactory(() => ResetPasswordUseCase(
          injector(),
        ));


    /////////////////////////
    injector.registerFactory(
        () => UserAuthenticatedUseCase(injector()));

    injector.registerFactory(
            () => IsUserNameExistsUseCase(injector()));
    injector.registerFactory(() => UserRegisterUseCase(injector(),injector() , injector()));
    injector.registerFactory<OTPRepository>(() => OTPRepositoryImp(injector()));
    injector.registerFactory(() => SetOTPUseCase(injector()));
    injector.registerFactory(() => GetOTPUseCase(injector()));
    injector.registerFactory(() => DeleteOTPUseCase(injector()));
    injector.registerFactory(() => HandleOTPUseCase(
      injector(),
      injector(),
      injector(),
    ));
    injector.registerFactory(() => IsEmailExistsUseCase(injector()));
    injector.registerFactory(() => CompleteRegisterUseCase(injector() , injector()));


    injector.registerFactory(() => SocialLogInUseCase(injector() , injector()));
    injector.registerFactory(() => LogoutUseCase(injector(),injector()));


    injector.registerFactory<SocialAuthenticationRepository>(
            () => SocialAuthenticationRepositoryImp(injector()));

    // email verification
    injector.registerFactory(() => ResendOtpUseCase(injector()));
    injector.registerFactory(() => CheckOtpVerificationUseCase(injector(),));
    // injector.registerFactory(() => ResetPasswordUseCase(injector(),));
    injector.registerFactory(() => OtpVerificationFactory(
      injector(),
      injector(),
      injector(),
    ));
    injector.registerFactory(() => UserFormRegisterOtpVerificationUseCase(injector() , injector()));
    injector.registerFactory(() => ForgetPasswordOtpVerificationUseCase(
      injector(),
    ));

    injector.registerFactory(() => SocialAuthFactory(
      injector(),
      injector(),
      injector(),
    ));
    injector.registerFactory(() => GetSocialPackageResultUseCase(
      injector(),
    ));

    injector.registerFactory(() => SocialRegisterUseCase(
      injector(),
      injector(),
    ));
    injector.registerFactory(() => CheckSocialStatusUseCase(
      injector(),
      injector(),
    ));

    injector.registerFactory(() => SocialLogInRequiredActionUseCase(
        injector(),
        injector(),
        injector(),
        injector()
    ));
    injector.registerFactory(() => SocialMergeUseCase(
      injector(),
      injector(),
    ));
    injector.registerFactory(() => SocialOtpVerificationUseCase(
      injector(),
      injector(),
    ));
    injector.registerFactory(() => SetCachedAppleEmailUseCase(
      injector(),
    ));
    injector.registerFactory(() => GetCachedAppleEmailUseCase(
      injector(),
    ));
    injector.registerFactory(() => DeleteCachedAppleEmailUseCase(
      injector(),
    ));
  }
}
