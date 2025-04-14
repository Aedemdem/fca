import 'package:dio/dio.dart';
import 'package:fca/core/error/exceptions.dart';

AppException handleDioException(DioException e) {
  String message = 'An error occurred';
  String code = 'network_error';
  Map<String, dynamic>? errors;

  if (e.type == DioExceptionType.connectionTimeout) {
    message = 'Connection timeout';
    code = 'connection_timeout';
  } else if (e.response != null) {
    message = e.response?.data['message'] ?? 'An error occurred';
    code = e.response?.data['errors']?['code'] ?? 'api_error';
    errors = e.response?.data['errors'];
  } else {
    message = e.message ?? 'An error occurred';
  }

  return AppException(message: message, code: code, errors: errors);
}