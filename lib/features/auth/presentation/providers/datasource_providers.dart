import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fca/core/di/injection.dart';
import 'package:fca/features/auth/data/datasources/remote/auth_remote_datasource.dart';

part 'datasource_providers.g.dart';

@riverpod
AuthRemoteDatasource authRemoteDatasource(Ref ref) {
  return sl<AuthRemoteDatasource>();
}