import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fca/core/di/injection.dart';
import 'package:fca/features/auth/domain/repositories/auth_repository.dart';

part 'repository_providers.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return sl<AuthRepository>();
}