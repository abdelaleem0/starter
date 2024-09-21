import 'dart:async';
import 'package:starter/common/utils/bloc_utils.dart';
import 'package:bloc/bloc.dart';

class CancellableCubit<T> extends Cubit<T> {
  CancellableCubit(super.initialState);

  Completer<void>? _cancelCompleter;

  void cancel() {
    if (_cancelCompleter != null && !_cancelCompleter!.isCompleted) {
      _cancelCompleter!.complete();
      _cancelCompleter = null;
    }
  }

  Future<void> cancellableCollect<T>({
    required Future<T> Function() task,
    required FutureOr<void> Function(T) whenTaskCompleted,
    void Function(String)? onError,
    void Function(dynamic)? catchError,
  }) async {
    cancel();
    final cancelCompleter = Completer<void>();
    _cancelCompleter = cancelCompleter;

    await collect(
      task: () async{
        final data = await task();

        if (!cancelCompleter.isCompleted) {
          whenTaskCompleted(data);
        }
      },
      onError: (e) {
        if(onError != null && !cancelCompleter.isCompleted){
          onError(e);
        }
      },
      catchError: (e) {
        if(catchError != null && !cancelCompleter.isCompleted){
          catchError(e);
        }
      },
    );

    if (_cancelCompleter == cancelCompleter) {
      _cancelCompleter = null;
    }
  }
}