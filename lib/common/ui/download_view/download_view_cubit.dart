import 'package:starter/common/domain/use_cases/download_image_use_case.dart';
import 'package:starter/common/domain/use_cases/download_pdf_use_case.dart';
import 'package:starter/common/base/async.dart';
import 'package:starter/common/ui/download_view/download_view_state.dart';
import 'package:starter/common/utils/bloc_utils.dart';
import 'package:starter/common/utils/common.dart';
import 'package:starter/di/app_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadViewCubit extends Cubit<DownloadViewState> {
  late final DownloadPdfUseCase _downloadPdfUseCase;
  late final DownloadImageUseCase _downloadImageUseCase;

  DownloadViewCubit() : super(const DownloadViewState.initial()) {
    _loadUseCases();
  }

  void _loadUseCases() {
    _downloadPdfUseCase = injector();
    _downloadImageUseCase = injector();
  }

  static DownloadViewCubit get(BuildContext context) =>
      BlocProvider.of(context);

  void downloadPdfSketch(
      {required String sketchIdentifier, required String id}) {
    emit(state.reduce(downloadState: const Async.loading()));
    collect(
      task: () async {
        await _downloadPdfUseCase.execute(sketchIdentifier, id);
        emit(state.reduce(downloadState: const Async.successWithoutData()));
      },
      onError: (errorMessage) {
        emit(state.reduce(downloadState: Async.failure(errorMessage)));
        emit(state.reduce(downloadState: const Async.initial()));
      },
      catchError: (errorMessage) {
        logDebug(errorMessage);
      },
    );
  }

  void downloadImageSketch({
    required String sketchIdentifier,
    required String id,
  }) {
    emit(state.reduce(downloadState: const Async.loading()));
    collect(
      task: () async {
        await _downloadImageUseCase.execute(sketchIdentifier, id);
        emit(state.reduce(downloadState: const Async.successWithoutData()));
      },
      onError: (errorMessage) {
        emit(state.reduce(downloadState: Async.failure(errorMessage)));
        emit(state.reduce(downloadState: const Async.initial()));
      },
      catchError: (errorMessage) {
        logDebug(errorMessage);
      },
    );
  }

  @override
  void emit(DownloadViewState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
