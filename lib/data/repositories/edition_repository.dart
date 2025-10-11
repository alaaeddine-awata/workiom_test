import 'package:dio/dio.dart';
import '../models/edition_model.dart';
import '../models/password_complexity_model.dart';
import '../services/api_service.dart';
import '../../core/network/api_result.dart';
import '../../core/utils/error_handler.dart';

class EditionRepository {
  final ApiService _apiService;

  EditionRepository({required ApiService apiService}) : _apiService = apiService;

  Future<ApiResult<EditionModelApiResponse>> getEditionsForSelect() async {
    try {
      final response = await _apiService.getEditionsForSelect();
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(_handleDioError(e));
    } catch (e) {
      return ApiResult.failure('Unexpected error: ${e.toString()}');
    }
  }

  Future<ApiResult<PasswordComplexityModel>> getPasswordComplexitySetting() async {
    try {
      final response = await _apiService.getPasswordComplexitySetting();
      return ApiResult.success(response.result?.setting ?? PasswordComplexityModel());
    } on DioException catch (e) {
      return ApiResult.failure(_handleDioError(e));
    } catch (e) {
      return ApiResult.failure('Unexpected error: ${e.toString()}');
    }
  }

  String _handleDioError(DioException error) {
    return ErrorHandler.handleDioError(error);
  }
}
