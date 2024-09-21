import 'package:equatable/equatable.dart';

class Async<T> extends Equatable {
  final T? data;
  final String? errorMessage;
  final bool _successWithoutData;
  final bool? _loading;
  final bool? _isInitial;

  const Async._(
      this.data, this.errorMessage, this._successWithoutData, this._loading,this._isInitial);

  bool get isInitial => _isInitial ?? false;

  bool get isLoading => _loading ?? false;

  bool get isSuccess =>
      (_successWithoutData || data != null) && (errorMessage == null);

  bool get isFailure => errorMessage != null;

  const Async.loading() : this._(null, null, false, true,false);
  const Async.success(T data) : this._(data, null, false, false,false);
  const Async.successWithoutData() : this._(null, null, true, false,false);
  const Async.failure(String errorMessage)
      : this._(null, errorMessage, false, false,false);
  const Async.initial() : this._(null, null, false, null,true);

  @override
  List<Object?> get props =>
      [data, errorMessage, _successWithoutData, _loading,_isInitial];
}
