sealed class Result<T> {
  const Result();

  factory Result.success(T values) = Success;
  factory Result.failed(String message) = Failed;

  bool get isSuccess => this is Success;
  bool get isFailed => this is Failed;

  T? get resultValue => isSuccess ? (this as Success).values : null;
  String? get errorMessage => isFailed ? (this as Failed).message : null;
}

class Success<T> extends Result<T> {
  final T values;

  const Success(this.values);
}

class Failed<T> extends Result<T> {
  final String message;

  const Failed(this.message);
}
