import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fca/core/di/injection.dart';
import 'package:fca/features/auth/domain/usecases/login_use_case.dart';
import 'package:fca/features/auth/presentation/providers/repository_providers.dart';

part 'use_case_providers.g.dart';

@riverpod
LoginUseCase loginUseCase(Ref ref) {
  return sl<LoginUseCase>();
}