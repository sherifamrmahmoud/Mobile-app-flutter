// core/errors/failure.dart

class Failure {
  final String message;
  final int? statusCode;

  const Failure({
    required this.message,
    this.statusCode,
  });
}