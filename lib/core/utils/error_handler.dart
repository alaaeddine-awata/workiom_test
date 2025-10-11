import 'package:dio/dio.dart';

class ErrorHandler {
  static String handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = _extractErrorMessage(error.response?.data);
        return 'Error $statusCode: $message';
      case DioExceptionType.cancel:
        return 'Request was cancelled';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';
      case DioExceptionType.badCertificate:
        return 'Certificate error occurred';
      case DioExceptionType.unknown:
        return 'Unknown error occurred';
    }
  }

  static String _extractErrorMessage(dynamic responseData) {
    if (responseData == null) return 'Server error occurred';
    
    if (responseData is Map<String, dynamic>) {
      // Try to extract error message from different possible structures
      if (responseData.containsKey('error')) {
        final error = responseData['error'];
        if (error is Map<String, dynamic> && error.containsKey('message')) {
          return error['message'];
        }
      }
      
      if (responseData.containsKey('message')) {
        return responseData['message'];
      }
      
      if (responseData.containsKey('Message')) {
        return responseData['Message'];
      }
      
      if (responseData.containsKey('error_description')) {
        return responseData['error_description'];
      }
    }
    
    return 'Server error occurred';
  }

  static String handleGenericError(dynamic error) {
    if (error is DioException) {
      return handleDioError(error);
    }
    
    return 'Unexpected error: ${error.toString()}';
  }
}
