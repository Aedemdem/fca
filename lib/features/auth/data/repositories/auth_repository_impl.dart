import 'package:dartz/dartz.dart';
import 'package:fca/core/error/exceptions.dart';
import 'package:fca/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:fca/features/auth/data/models/login_response.dart';
import 'package:fca/features/auth/domain/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:fca/core/utils/network_error_handler.dart'; // Import

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<AppException, LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      final loginResponse = await remoteDatasource.login(email: email, password: password);
      return Right(loginResponse);
    } on DioException catch (e) {
      return Left(NetworkErrorHandler.handleDioException(e));
    } on AppException catch (e) {
      return Left(e);
    }
  }
}