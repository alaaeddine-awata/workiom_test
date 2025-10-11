import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/auth_models.dart';
import '../models/edition_model.dart';
import '../models/login_info_model.dart';
import '../models/password_complexity_model.dart';
import '../models/tenant_availability_model.dart';
import '../../core/network/dio_client.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/api/services/app/Session/GetCurrentLoginInformations')
  Future<LoginInfoApiResponseModel> getCurrentLoginInformations();

  @GET('/api/services/app/TenantRegistration/GetEditionsForSelect')
  Future<EditionModelApiResponse> getEditionsForSelect();

  @GET('/api/services/app/Profile/GetPasswordComplexitySetting')
  Future<PasswordComplexityApiResponse> getPasswordComplexitySetting();

  @POST('/api/services/app/Account/IsTenantAvailable')
  Future<TenantAvailabilityModel> isTenantAvailable(
    @Body() IsTenantAvailableRequest request,
  );

  @POST('/api/services/app/TenantRegistration/RegisterTenant')
  Future<void> registerTenant(
    @Query('timeZone') String timeZone,
    @Body() RegisterTenantRequest request,
  );

  @POST('/api/TokenAuth/Authenticate')
  Future<AuthApiResponse> authenticate(
    @Body() AuthenticateRequest request,
  );
}

class ApiServiceProvider {
  static ApiService get instance {
    return ApiService(DioClient.instance.dio);
  }
}
