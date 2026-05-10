// core/errors/api_error_model.dart

class ApiErrorModel {
  final String message;
  final int? statusCode;
  final List<String> errors;

  ApiErrorModel({
    required this.message,
    this.statusCode,
    this.errors = const [],
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      message: json['message'] ?? 'Something went wrong',
      statusCode: json['statusCode'],
      errors: json['errors'] is List
          ? List<String>.from(json['errors'])
          : const [],
    );
  }
}