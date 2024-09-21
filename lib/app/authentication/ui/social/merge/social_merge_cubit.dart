import 'package:starter/app/authentication/domain/models/social/merge/social_merge_input.dart';
import 'package:starter/common/base/async.dart';
import 'package:starter/common/utils/bloc_utils.dart';
import 'package:starter/di/app_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_case/social/social_merge_use_case.dart';
import 'social_merge_state.dart';

class SocialMergeCubit extends Cubit<SocialMergeState> {
  SocialMergeCubit() : super(const SocialMergeState.initial()) {
    _loadUseCases();
  }

  late final SocialMergeUseCase _socialMergeUseCase;

  static SocialMergeCubit of(BuildContext context) {
    return BlocProvider.of(context);
  }

  void _loadUseCases() {
    _socialMergeUseCase = injector();
  }

  void merge(SocialMergeInput input) async {
    emit(state.reduce(mergeState: const Async.loading()));
    await collect(
      task: () async {
        final appUserModel= await _socialMergeUseCase.execute(input);
        emit(state.reduce(mergeState: Async.success(appUserModel)));
        emit(state.reduce(mergeState: const Async.initial()));
      },
      onError: (errorMessage) {
        emit(state.reduce(
          mergeState: Async.failure(errorMessage),
          errorMessage: errorMessage,
        ));
      },
    );
  }

}
