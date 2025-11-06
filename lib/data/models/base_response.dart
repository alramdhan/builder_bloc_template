import 'package:equatable/equatable.dart';

sealed class BaseResponse<T> extends Equatable {
  final bool success;
  final T? response;
  const BaseResponse({required this.success, this.response});
}

class SuccessResponse<T> extends BaseResponse<T> {
  final T data;
  const SuccessResponse(this.data) : super(success: true, response: data);
  
  @override
  List<Object?> get props => [super.success, data];
}

class FailureResponse<T> extends BaseResponse<T> {
  final String message;
  final int? statusCode;

  const FailureResponse({required this.message, this.statusCode}) : super(success: false);

  factory FailureResponse.fromJson(Map<String, dynamic> json) {
    return FailureResponse(
      message: json['message'] ?? 'Terjadi kesalahan',
      statusCode: json['statusCode']
    );
  }
  
  @override
  List<Object?> get props => [super.success, message, statusCode];
}