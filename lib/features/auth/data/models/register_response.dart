import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_response.freezed.dart';
part 'register_response.g.dart';

@freezed
abstract class RegisterResponse with _$RegisterResponse {
  const factory RegisterResponse({
    required bool status,
    String? message,
    Map<String, dynamic>? errors,
  }) = _RegisterResponse;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
}