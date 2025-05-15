class BaseResponseEntity {
  final bool success;
  final String message;
  BaseResponseEntity({required this.success, required this.message});
}

class BaseResponseEntity1<T> {
  final bool success;
  final String message;
  final T? data;

  BaseResponseEntity1({
    required this.success,
    required this.message,
    this.data,
  });
}
