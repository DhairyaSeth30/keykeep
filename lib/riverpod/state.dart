
enum DataStatus { idle, loading, success, error }

class PasswordFormState<T> {
  final T? data;
  final DataStatus status;
  final String? message;

  PasswordFormState({
    this.status = DataStatus.idle,
    this.message,
    this.data
  });

  PasswordFormState<T> copyWith({
    T? data,
    DataStatus? status,
    String ? message,
  }) {
    return PasswordFormState<T>(
      data: data ?? this.data,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
