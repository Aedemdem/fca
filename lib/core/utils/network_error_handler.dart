import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fca/core/error/exceptions.dart';

class NetworkErrorHandler {
  static AppException handleDioException(DioException e) {
    String message = 'An unexpected error occurred';
    String code = 'network_error';

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      message = 'Connection timeout';
      code = 'connection_timeout';
    } else if (e.type == DioExceptionType.unknown && e.error is SocketException) {
      message = 'Could not connect to server. Please check your internet connection.';
      code = 'no_internet';
    } else if (e.response != null) {
      // Coba ekstrak pesan dari respons jika tersedia
      final responseData = e.response!.data;
      if (responseData is Map<String, dynamic> && responseData.containsKey('message')) {
        message = responseData['message'] as String;
        code = responseData['code'] as String? ?? 'network_error'; // Gunakan kode dari respons jika ada
      } else {
        message = e.message ?? 'An unexpected error occurred';
      }
    } else {
      message = e.message ?? 'An unexpected error occurred';
    }

    return AppException(message: message, code: code);
  }
}