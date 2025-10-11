part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  tenantNotSelected,
  registrationSuccess,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final LoginInfoModel? loginInfo;
  final AuthenticateResponse? authResponse;
  final bool checkTenantAvailability;
  final bool tenantAvailability;
  final PasswordComplexityModel? passwordComplexity;
  final String? email;
  final String? password;
  final String? error;

  const AuthState({
    this.status = AuthStatus.initial,
    this.loginInfo,
    this.authResponse,
    this.tenantAvailability = false,
    this.checkTenantAvailability = false,
    this.passwordComplexity,
    this.error,
    this.email,
    this.password,
  });

  AuthState copyWith({
    AuthStatus? status,
    LoginInfoModel? loginInfo,
    AuthenticateResponse? authResponse,
    bool? tenantAvailability,
    bool? checkTenantAvailability,
    PasswordComplexityModel? passwordComplexity,
    String? error,
    String? email,
    String? password,
  }) {
    return AuthState(
      status: status ?? this.status,
      loginInfo: loginInfo ?? this.loginInfo,
      authResponse: authResponse ?? this.authResponse,
      tenantAvailability: tenantAvailability ?? this.tenantAvailability,
      checkTenantAvailability: checkTenantAvailability ?? this.checkTenantAvailability,
      passwordComplexity: passwordComplexity ?? this.passwordComplexity,
      error: error ?? this.error,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [
    status,
    loginInfo,
    authResponse,
    tenantAvailability,
    checkTenantAvailability,
    passwordComplexity,
    error,
    email,
    password,
  ];
}
