import 'package:starter/app/authentication/domain/models/inputs/login_details_input.dart';
import 'package:starter/app/authentication/domain/models/social/check_provider_status/social_register_response_required_action.dart';
import 'package:starter/app/authentication/domain/models/social/register/social_register_input.dart';
import 'package:starter/app/authentication/domain/models/social/social_provider_type.dart';
import 'package:starter/app/authentication/domain/use_case/social/social_login_status_use_case.dart';
import 'package:starter/app/authentication/domain/use_case/social/social_register_use_case.dart';
import 'package:starter/app/authentication/ui/social/social_auth_state.dart';
import 'package:starter/common/base/async.dart';
import 'package:starter/common/utils/bloc_utils.dart';
import 'package:starter/di/app_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialAuthCubit extends Cubit<SocialAuthStates> {
  static SocialAuthCubit of(BuildContext context) {
    return BlocProvider.of(context);
  }

  late final SocialLogInRequiredActionUseCase logInRequiredActionUseCase;
  late final SocialRegisterUseCase _socialRegisterUseCase;

  SocialAuthCubit() : super(const SocialAuthStates.initial()) {
    _loadUseCases();
  }

  void _loadUseCases() {
    logInRequiredActionUseCase = injector();
    _socialRegisterUseCase = injector();
  }

  void logInStatusRequiredAction(SocialProviderTypeEnum type) async {
    emit(state.reduce(logInStatusRequiredAction: const Async.loading()));
    await collect(
      task: () async {
        final result = await logInRequiredActionUseCase.execute(type);
        if (result.actionRequired ==
            SocialProviderStatusRequiredActionEnum.register) {
          final appUserModel = await _socialRegisterUseCase.execute(
              input: SocialRegisterInput(
                  providerId: result.packagesResult.providerId,
                  provider: result.packagesResult.provider,
                  email: result.packagesResult.email ?? '',
                  isEmailManuallyEntered:
                      result.packagesResult.isEmailManuallyEntered ?? false,
                  loginDetailsInput: LoginDetailsInput(
                      fcmToken: result.packagesResult.fcmToken ?? '')));
          emit(state.reduce(
              logInStatusRequiredAction:
                  Async.success(result.modify(appUserModel: appUserModel))));
          emit(state.reduce(logInStatusRequiredAction: const Async.initial()));
        }else {
          emit(state.reduce(logInStatusRequiredAction: Async.success(result)));
          emit(state.reduce(logInStatusRequiredAction: const Async.initial()));
        }
      },
      onError: (errorMessage) {
        emit(state.reduce(
          logInStatusRequiredAction: Async.failure(errorMessage),
          errorMessage: errorMessage,
        ));
      },
    );
  }
}
