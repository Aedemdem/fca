class AppException implements Exception {
  final String message;
  final String code;
  final Map<String, dynamic>? errors;

  AppException({required this.message, required this.code, this.errors});

  @override
  String toString() => 'AppException: $message (code: $code, errors: $errors)';
}