import 'package:starter/common/base/async.dart';
import 'package:starter/common/utils/bloc_utils.dart';
import 'package:starter/di/app_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/models/social/check_provider_status/social_check_provider_status_input.dart';
import '../../../domain/use_case/social/check_social_provider_status_use_case.dart';
import 'social_email_page_state.dart';

class SocialEmailPageCubit extends Cubit<SocialEmailPageState> {
  SocialEmailPageCubit() : super(const SocialEmailPageState.initial()) {
    _loadUseCases();
  }
  late final CheckSocialStatusUseCase _checkSocialStatusUseCase;

  static SocialEmailPageCubit of(BuildContext context) {
    return BlocProvider.of(context);
  }

  void _loadUseCases() {
    _checkSocialStatusUseCase = injector();
  }

  void checkStatus(SocialCheckProviderStatusInput input) async {
    emit(state.reduce(checkStatus: const Async.loading()));
    await collect(
      task: () async {
        final result = await _checkSocialStatusUseCase.execute(input);
        emit(state.reduce(checkStatus: Async.success(result)));
      },
      onError: (errorMessage) {
        emit(state.reduce(
          checkStatus: Async.failure(errorMessage),
          errorMessage: errorMessage,
        ));
      },
    );
  }
}
