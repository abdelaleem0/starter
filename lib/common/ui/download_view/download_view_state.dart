import 'package:starter/common/base/async.dart';
import 'package:equatable/equatable.dart';

class DownloadViewState extends Equatable {
  final Async<void> downloadState;
  final String errorMessage;

  const DownloadViewState(
      {required this.downloadState, required this.errorMessage});

  const DownloadViewState.initial()
      : this(errorMessage: "", downloadState: const Async.initial());

  DownloadViewState reduce({
    Async<void>? downloadState,
    String? errorMessage,
  }) {
    return DownloadViewState(
        downloadState: downloadState ?? this.downloadState,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [downloadState, errorMessage];
}
