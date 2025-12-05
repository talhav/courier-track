import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../services/auth_service.dart';
import 'api_config.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio dio(AuthService authService) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectionTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add auth interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add token to all requests except login
          if (authService.token != null && !options.path.contains('/login')) {
            options.headers['Authorization'] = 'Bearer ${authService.token}';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) {
          // Handle 401 Unauthorized - token expired
          if (error.response?.statusCode == 401) {
            // Token expired, logout user
            authService.logout();
          }
          return handler.next(error);
        },
      ),
    );

    // Add logging interceptor for development
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
      ),
    );

    return dio;
  }
}
