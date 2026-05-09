// core/di/dependency_injection.dart

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:nti5/core/networking/api_client.dart';
import 'package:nti5/core/networking/dio_factory.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  final Dio dio = DioFactory.createDio();

  getIt.registerLazySingleton<Dio>(() => dio);
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt<Dio>()));

  // Register other dependencies here
  }