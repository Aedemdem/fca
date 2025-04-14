import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart'; // Import Dio
import 'package:fca/core/network/dio_client.dart';
import 'package:fca/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:fca/features/auth/data/datasources/remote/auth_remote_datasource_impl.dart';
import 'package:fca/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fca/features/auth/domain/repositories/auth_repository.dart';
import 'package:fca/features/auth/domain/usecases/login_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // DioClient
  sl.registerLazySingleton<DioClient>(() {
    final dio = Dio();
    // Config Dio
    dio.options.baseUrl = 'http://192.168.6.186/crud/api.php';
    // dio.interceptors.add(LogInterceptor());
    return DioClient(dio: dio);
  });

  // Data sources
  sl.registerLazySingleton<AuthRemoteDatasource>(
        () => AuthRemoteDatasourceImpl(dioClient: sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(remoteDatasource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
}

