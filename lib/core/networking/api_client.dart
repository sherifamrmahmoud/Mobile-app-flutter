// core/network/api_client.dart

import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient(this.dio);

  Future<Response> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) {
    return dio.get(
      path,
      queryParameters: queryParameters,
    );
  }

  Future<Response> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  Future<Response> put({
    required String path,
    dynamic data,
  }) {
    return dio.put(
      path,
      data: data,
    );
  }

  Future<Response> delete({
    required String path,
    dynamic data,
  }) {
    return dio.delete(
      path,
      data: data,
    );
  }
}