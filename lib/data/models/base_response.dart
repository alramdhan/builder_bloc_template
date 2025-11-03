class BaseResponse<T, K> {
  final bool success;
  final int? status;
  final String? message;
  final K? data;

  const BaseResponse({
    required this.success,
    this.status,
    this.message,
    this.data
  });
}