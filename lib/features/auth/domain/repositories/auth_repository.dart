import 'package:dartz/dartz.dart';
import 'package:fca/core/error/exceptions.dart';
import 'package:fca/features/auth/data/models/login_response.dart';

abstract class AuthRepository {
  Future<Either<AppException, LoginResponse>> login({
    required String email,
    required String password,
  });
}