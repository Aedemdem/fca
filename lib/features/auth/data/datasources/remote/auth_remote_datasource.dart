import 'package:fca/features/auth/data/models/login_response.dart';

abstract class AuthRemoteDatasource {
  Future<LoginResponse> login({
    required String email,
    required String password,
  });
}