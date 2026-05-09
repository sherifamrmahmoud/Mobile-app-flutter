// core/network/dio_factory.dart

import 'package:dio/dio.dart';
import 'network_interceptor.dart';

class DioFactory {
  DioFactory._();

  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        responseType: ResponseType.json,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(NetworkInterceptor());

    return dio;
  }
}