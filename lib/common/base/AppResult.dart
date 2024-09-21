class AppResult<T> {
  final bool success;
  final ResultError? error;
  final T? data;

  AppResult(this.success, this.error, this.data);

  factory AppResult.success(T? data) {
    return AppResult(true, null, data);
  }

  AppResult.successWithoutData(): this(true, null, null);

  factory AppResult.failure(ResultError? error) {
    return AppResult(false, error, null);
  }

  static AppResult<T> serverError<T>() => AppResult<T>(false, ResultError("", 500), null);
}

class ResultError {
  final String errorMessage;
  final int code;

  ResultError(this.errorMessage, this.code);
}