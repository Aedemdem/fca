// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:mockito/annotations.dart';
// import 'package:fca/core/error/exceptions.dart';
// import 'package:fca/core/network/dio_client.dart';
// import 'package:fca/features/auth/data/datasources/remote/auth_remote_datasource.dart';
// import 'package:fca/features/auth/data/models/login_response.dart';
//
// // Generate a MockDioClient using mockito
// class MockDioClient extends Mock implements DioClient {}
//
// @GenerateMocks([DioClient])
// void main() {
//   late AuthRemoteDatasource datasource;
//   late MockDioClient mockDioClient;
//
//   setUp(() {
//     mockDioClient = MockDioClient();
//     datasource = AuthRemoteDatasource(dioClient: mockDioClient);
//   });
//
//   group('login', () {
//     const tEmail = 'test@example.com';
//     const tPassword = 'password';
//
//     test('should return LoginResponse when the login is successful', () async {
//       // arrange
//       final tResponse = Response(
//         data: {'status': true, 'message': 'Login successful'},
//         statusCode: 200,
//         requestOptions: RequestOptions(path: '/login'),
//       );
//       when(mockDioClient.dio.post("", data: anyNamed('data')))
//           .thenAnswer((_) async => tResponse);
//       // act
//       final result = await datasource.login(email: tEmail, password: tPassword);
//       // assert
//       expect(result, isA<LoginResponse>());
//       expect(result.status, true);
//       expect(result.message, 'Login successful');
//       verify(mockDioClient.dio.post('/login', data: {'email': tEmail, 'password': tPassword})).called(1);
//     });
//
//     test('should throw AppException when the login fails', () async {
//       // arrange
//       final tResponse = Response(
//         data: {'status': false, 'message': 'Invalid credentials', 'errors': {'code': 'invalid_credentials'}},
//         statusCode: 401,
//         requestOptions: RequestOptions(path: '/login'),
//       );
//       when(mockDioClient.dio.post("", data: anyNamed('data')))
//           .thenAnswer((_) async => tResponse);
//       // act
//       final call = datasource.login(email: tEmail, password: tPassword);
//       // assert
//       expect(() => call, throwsA(isA<AppException>()));
//       verify(mockDioClient.dio.post('/login', data: {'email': tEmail, 'password': tPassword})).called(1);
//     });
//
//     test('should throw AppException when there is a network error', () async {
//       // arrange
//       when(mockDioClient.dio.post("", data: anyNamed('data')))
//           .thenThrow(DioException(requestOptions: RequestOptions(path: '/login'), type: DioExceptionType.connectionTimeout));
//       // act
//       final call = datasource.login(email: tEmail, password: tPassword);
//       // assert
//       expect(() => call, throwsA(isA<AppException>()));
//       verify(mockDioClient.dio.post('/login', data: {'email': tEmail, 'password': tPassword})).called(1);
//     });
//   });
// }