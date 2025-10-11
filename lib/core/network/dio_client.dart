import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../constants/app_constants.dart';
import '../storage/token_storage.dart';

class DioClient {
  static DioClient? _instance;
  late Dio _dio;
  
  DioClient._internal() {
    _dio = Dio();
    _setupInterceptors();
  }
  
  static DioClient get instance {
    _instance ??= DioClient._internal();
    return _instance!;
  }
  
  Dio get dio => _dio;
  
  void _setupInterceptors() {
    _dio.options.baseUrl = AppConstants.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);
    
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
    ));
    
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await TokenStorage.getToken();
        if (token != null && await TokenStorage.isTokenValid()) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          await TokenStorage.clearToken();
        }
        handler.next(error);
      },
    ));
  }
  
  Future<void> setAuthToken(String token) async {
    await TokenStorage.saveToken(token: token);
  }
  
  Future<void> clearAuthToken() async {
    await TokenStorage.clearToken();
  }
}
