sealed class Result<T> {
  const Result();

  factory Result.success(T values) = Success;
  factory Result.failed(String message) = Failed;

  bool get isSuccess => this is Success;
  bool get isFailed => this is Failed;

  T? get resultValue => isSuccess ? (this as Success<T>).values : null;
  String? get errorMessage => isFailed ? (this as Failed<T>).message : null;
}

class Success<T> extends Result<T> {
  final T values;
  Success(this.values);
}

class Failed<T> extends Result<T> {
  final String message;
  Failed(this.message);
}
