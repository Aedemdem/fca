import 'package:dartz/dartz.dart';
import 'package:fca/core/error/exceptions.dart';
import 'package:fca/features/auth/data/models/login_response.dart';
import 'package:fca/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<AppException, LoginResponse>> call({
    required String email,
    required String password,
  }) async {
    // Anda dapat menambahkan validasi input di sini jika diperlukan
    return await repository.login(email: email, password: password);
  }
}