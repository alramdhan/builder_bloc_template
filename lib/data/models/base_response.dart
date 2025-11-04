import 'package:equatable/equatable.dart';

sealed class BaseResponse<T> extends Equatable {
  final bool success;
  const BaseResponse({required this.success});
}

class SuccessResponse<T> extends BaseResponse<T> {
  final T data;
  const SuccessResponse(this.data) : super(success: true);
  
  @override
  List<Object?> get props => [super.success, data];
}

class FailureResponse<T> extends BaseResponse<T> {
  final ErrorResponse? error;
  const FailureResponse(this.error) : super(success: false);
  
  @override
  List<Object?> get props => [super.success, error];
}

class ErrorResponse {
  final String message;
  final int? statusCode;

  const ErrorResponse({required this.message, this.statusCode});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      message: json['message'] ?? 'Terjadi kesalahan',
      statusCode: json['statusCode']
    );
  }
}