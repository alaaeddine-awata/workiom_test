import 'package:dio/dio.dart';
import '../models/auth_models.dart';
import '../models/login_info_model.dart';
import '../models/password_complexity_model.dart';
import '../services/api_service.dart';
import '../../core/network/api_result.dart';
import '../../core/network/dio_client.dart';
import '../../core/utils/error_handler.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository({
    required ApiService apiService,
    required DioClient dioClient,
  }) : _apiService = apiService;
  Future<ApiResult<LoginInfoApiResponseModel>> getCurrentLoginInformations() async {
    try {
      final response = await _apiService.getCurrentLoginInformations();
      return ApiResult.success(response);
    } on DioException catch (e) {
      return ApiResult.failure(_handleDioError(e));
    } catch (e) {
      return ApiResult.failure('Unexpected error: ${e.toString()}');
    }
  }

  Future<ApiResult<AuthenticateResponse>> authenticate({
    required String email,
    required String password,
    required String tenantName,
    required String timeZone,
  }) async {
    try {
      final request = AuthenticateRequest(
        ianaTimeZone: timeZone,
        password: password,
        rememberClient: false,
        returnUrl: '',
        singleSignIn: false,
        tenantName: tenantName,
        userNameOrEmailAddress: email,
      );

      final response = await _apiService.authenticate(request);
      
      return ApiResult.success(response.result ?? AuthenticateResponse());
    } on DioException catch (e) {
      return ApiResult.failure(_handleDioError(e));
    } catch (e) {
      return ApiResult.failure('Unexpected error: ${e.toString()}');
    }
  }

  Future<ApiResult<void>> registerTenant({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String tenantName,
    required int editionId,
    required String timeZone,
  }) async {
    try {
      final request = RegisterTenantRequest(
        adminEmailAddress: email,
        adminFirstName: firstName,
        adminLastName: lastName,
        adminPassword: password,
        captchaResponse: '',
        editionId: editionId,
        name: tenantName,
        tenancyName: tenantName,
      );

      await _apiService.registerTenant(timeZone, request);
      return ApiResult.success(null);
    } on DioException catch (e) {
      return ApiResult.failure(_handleDioError(e));
    } catch (e) {
      return ApiResult.failure('Unexpected error: ${e.toString()}');
    }
  }

  Future<ApiResult<bool>> isTenantAvailable(String tenancyName) async {
    try {
      final request = IsTenantAvailableRequest(tenancyName: tenancyName);
      final response = await _apiService.isTenantAvailable(request);
      final isAvailable = response.result.tenantId == null;
      return ApiResult.success(isAvailable);
    } on DioException catch (e) {
      return ApiResult.failure(_handleDioError(e));
    } catch (e) {
      return ApiResult.failure('Unexpected error: ${e.toString()}');
    }
  }

  Future<ApiResult<PasswordComplexityApiResponse>> getPasswordComplexitySetting() async {
    try {
      final response = await _apiService.getPasswordComplexitySetting();
      return ApiResult.success(response);
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
