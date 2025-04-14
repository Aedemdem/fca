import 'package:dio/dio.dart';
import 'package:fca/core/error/exceptions.dart';
import 'package:fca/core/network/dio_client.dart';
import 'package:fca/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:fca/features/auth/data/models/login_response.dart';
import 'package:fca/core/utils/network_error_handler.dart';
import 'package:logger/logger.dart'; // Import logger

import '../../../../../core/constants/api_endpoints.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final DioClient dioClient;
  final Logger logger = Logger(); // Inisialisasi logger

  AuthRemoteDatasourceImpl({required this.dioClient});

  @override
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      logger.i('Attempting login for email: $email'); // Log percobaan login
      final response = await dioClient.dio.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      logger.d('Received response: ${response.statusCode} - ${response.data}'); // Log respons

      // Respons seharusnya selalu memiliki statusCode 200 di sini
      final responseData = response.data;
      if (responseData != null && responseData is Map<String, dynamic>) {
        // Periksa apakah respons memiliki status sukses (misalnya, 'status': true)
        if (responseData.containsKey('status') && responseData['status'] == true) {
          final loginResponse = LoginResponse.fromJson(responseData);
          logger.t('Login successful: $loginResponse'); // Log respons sukses (trace)
          return loginResponse;
        } else {
          // Jika status tidak sukses, lemparkan AppException dengan pesan dari respons
          final errorMessage = responseData['message'] ?? 'Login failed';
          final errorCode = responseData['code'] ?? 'login_failed';
          logger.w('Login failed (status false): $errorMessage - $errorCode'); // Log peringatan
          throw AppException(
            message: errorMessage,
            code: errorCode,
          );
        }
      } else {
        // Jika data respons tidak valid, lemparkan AppException
        logger.e('Invalid response data'); // Log error
        throw AppException(
          message: 'Invalid response data',
          code: 'invalid_response',
        );
      }
    } on DioException catch (e) {
      // Tangani kesalahan jaringan menggunakan NetworkErrorHandler
      final exception = NetworkErrorHandler.handleDioException(e);
      logger.e('DioException: ${exception.message} - ${exception.code}'); // Log DioException
      throw exception;
    } catch (e) {
      // Tangani kesalahan lain yang mungkin terjadi
      logger.e('Unexpected error: $e'); // Log kesalahan tak terduga
      throw AppException(
        message: e.toString(),
        code: 'unexpected_error',
      );
    }
  }
}