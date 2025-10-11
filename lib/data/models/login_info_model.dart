import 'application_model.dart';
import 'user_model.dart';
import 'tenant_model.dart';

class LoginInfoModel {
  final UserModel? user;
  final TenantModel? tenant;
  final ApplicationModel application;

  const LoginInfoModel({
    this.user,
    this.tenant,
    this.application = const ApplicationModel(),
  });

  factory LoginInfoModel.fromJson(Map<String, dynamic> json) {
    return LoginInfoModel(
      user: json['user'] != null ? UserModel.fromJson(json['user'] as Map<String, dynamic>) : null,
      tenant: json['tenant'] != null ? TenantModel.fromJson(json['tenant'] as Map<String, dynamic>) : null,
      application: json['application'] != null
          ? ApplicationModel.fromJson(json['application'] as Map<String, dynamic>)
          : const ApplicationModel(),
    );
  }

  LoginInfoModel copyWith({
    UserModel? user,
    TenantModel? tenant,
    ApplicationModel? application,
  }) {
    return LoginInfoModel(
      user: user ?? this.user,
      tenant: tenant ?? this.tenant,
      application: application ?? this.application,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoginInfoModel &&
        other.user == user &&
        other.tenant == tenant &&
        other.application == application;
  }

  @override
  int get hashCode {
    return user.hashCode ^
    tenant.hashCode ^
    application.hashCode;
  }

  @override
  String toString() {
    return 'LoginInfoModel(user: $user, tenant: $tenant, application: $application)';
  }
}

class LoginInfoApiResponseModel {
  final LoginInfoModel? result;
  final String? targetUrl;
  final bool success;
  final dynamic error;
  final bool unAuthorizedRequest;
  final bool abp;

  const LoginInfoApiResponseModel({
    this.result,
    this.targetUrl,
    this.success = false,
    this.error,
    this.unAuthorizedRequest = false,
    this.abp = false,
  });

  factory LoginInfoApiResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginInfoApiResponseModel(
      result: json['result'] != null
          ? LoginInfoModel.fromJson(json['result'] as Map<String, dynamic>)
          : null,
      targetUrl: json['targetUrl'] as String?,
      success: json['success'] as bool? ?? false,
      error: json['error'], // Keeping this as dynamic to handle null or Map/String
      unAuthorizedRequest: json['unAuthorizedRequest'] as bool? ?? false,
      abp: json['__abp'] as bool? ?? false,
    );
  }

}