import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fca/core/error/exceptions.dart';
import 'package:fca/features/auth/data/models/login_response.dart';
import 'package:fca/features/auth/domain/usecases/login_use_case.dart';
import 'package:fca/features/auth/presentation/providers/use_case_providers.dart'; // Tambahkan ini

part 'login_provider.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  Future<LoginState> build() {
    return Future.value(LoginState()); // State awal
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading(); // Memulai loading
    final result = await ref.read(loginUseCaseProvider)(email: email, password: password);
    state = await result.fold(
          (failure) async => AsyncError(failure.message, StackTrace.current),
          (response) async => AsyncData(LoginState(loginResponse: response)),
    );
  }
}

class LoginState {
  final LoginResponse? loginResponse;

  LoginState({this.loginResponse});
}