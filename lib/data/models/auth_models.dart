class RegisterTenantRequest {
  final String adminEmailAddress;
  final String adminFirstName;
  final String adminLastName;
  final String adminPassword;
  final String captchaResponse;
  final int editionId;
  final String name;
  final String tenancyName;

  const RegisterTenantRequest({
    this.adminEmailAddress = '',
    this.adminFirstName = '',
    this.adminLastName = '',
    this.adminPassword = '',
    this.captchaResponse = '',
    this.editionId = 0,
    this.name = '',
    this.tenancyName = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'adminEmailAddress': adminEmailAddress,
      'adminFirstName': adminFirstName,
      'adminLastName': adminLastName,
      'adminPassword': adminPassword,
      'captchaResponse': captchaResponse,
      'editionId': editionId,
      'name': name,
      'tenancyName': tenancyName,
    };
  }

  factory RegisterTenantRequest.fromJson(Map<String, dynamic> json) {
    return RegisterTenantRequest(
      adminEmailAddress: json['adminEmailAddress'] as String? ?? '',
      adminFirstName: json['adminFirstName'] as String? ?? '',
      adminLastName: json['adminLastName'] as String? ?? '',
      adminPassword: json['adminPassword'] as String? ?? '',
      captchaResponse: json['captchaResponse'] as String? ?? '',
      editionId: json['editionId'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      tenancyName: json['tenancyName'] as String? ?? '',
    );
  }

  RegisterTenantRequest copyWith({
    String? adminEmailAddress,
    String? adminFirstName,
    String? adminLastName,
    String? adminPassword,
    String? captchaResponse,
    int? editionId,
    String? name,
    String? tenancyName,
  }) {
    return RegisterTenantRequest(
      adminEmailAddress: adminEmailAddress ?? this.adminEmailAddress,
      adminFirstName: adminFirstName ?? this.adminFirstName,
      adminLastName: adminLastName ?? this.adminLastName,
      adminPassword: adminPassword ?? this.adminPassword,
      captchaResponse: captchaResponse ?? this.captchaResponse,
      editionId: editionId ?? this.editionId,
      name: name ?? this.name,
      tenancyName: tenancyName ?? this.tenancyName,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RegisterTenantRequest &&
        other.adminEmailAddress == adminEmailAddress &&
        other.adminFirstName == adminFirstName &&
        other.adminLastName == adminLastName &&
        other.adminPassword == adminPassword &&
        other.captchaResponse == captchaResponse &&
        other.editionId == editionId &&
        other.name == name &&
        other.tenancyName == tenancyName;
  }

  @override
  int get hashCode {
    return Object.hash(
      adminEmailAddress,
      adminFirstName,
      adminLastName,
      adminPassword,
      captchaResponse,
      editionId,
      name,
      tenancyName,
    );
  }

  @override
  String toString() {
    return 'RegisterTenantRequest(adminEmailAddress: $adminEmailAddress, adminFirstName: $adminFirstName, adminLastName: $adminLastName, adminPassword: $adminPassword, captchaResponse: $captchaResponse, editionId: $editionId, name: $name, tenancyName: $tenancyName)';
  }
}

class AuthenticateRequest {
  final String ianaTimeZone;
  final String password;
  final bool rememberClient;
  final String returnUrl;
  final bool singleSignIn;
  final String tenantName;
  final String userNameOrEmailAddress;

  const AuthenticateRequest({
    this.ianaTimeZone = '',
    this.password = '',
    this.rememberClient = false,
    this.returnUrl = '',
    this.singleSignIn = false,
    this.tenantName = '',
    this.userNameOrEmailAddress = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'ianaTimeZone': ianaTimeZone,
      'password': password,
      'rememberClient': rememberClient,
      'returnUrl': returnUrl,
      'singleSignIn': singleSignIn,
      'tenantName': tenantName,
      'userNameOrEmailAddress': userNameOrEmailAddress,
    };
  }

  factory AuthenticateRequest.fromJson(Map<String, dynamic> json) {
    return AuthenticateRequest(
      ianaTimeZone: json['ianaTimeZone'] as String? ?? '',
      password: json['password'] as String? ?? '',
      rememberClient: json['rememberClient'] as bool? ?? false,
      returnUrl: json['returnUrl'] as String? ?? '',
      singleSignIn: json['singleSignIn'] as bool? ?? false,
      tenantName: json['tenantName'] as String? ?? '',
      userNameOrEmailAddress: json['userNameOrEmailAddress'] as String? ?? '',
    );
  }

  AuthenticateRequest copyWith({
    String? ianaTimeZone,
    String? password,
    bool? rememberClient,
    String? returnUrl,
    bool? singleSignIn,
    String? tenantName,
    String? userNameOrEmailAddress,
  }) {
    return AuthenticateRequest(
      ianaTimeZone: ianaTimeZone ?? this.ianaTimeZone,
      password: password ?? this.password,
      rememberClient: rememberClient ?? this.rememberClient,
      returnUrl: returnUrl ?? this.returnUrl,
      singleSignIn: singleSignIn ?? this.singleSignIn,
      tenantName: tenantName ?? this.tenantName,
      userNameOrEmailAddress: userNameOrEmailAddress ?? this.userNameOrEmailAddress,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthenticateRequest &&
        other.ianaTimeZone == ianaTimeZone &&
        other.password == password &&
        other.rememberClient == rememberClient &&
        other.returnUrl == returnUrl &&
        other.singleSignIn == singleSignIn &&
        other.tenantName == tenantName &&
        other.userNameOrEmailAddress == userNameOrEmailAddress;
  }

  @override
  int get hashCode {
    return Object.hash(
      ianaTimeZone,
      password,
      rememberClient,
      returnUrl,
      singleSignIn,
      tenantName,
      userNameOrEmailAddress,
    );
  }

  @override
  String toString() {
    return 'AuthenticateRequest(ianaTimeZone: $ianaTimeZone, password: $password, rememberClient: $rememberClient, returnUrl: $returnUrl, singleSignIn: $singleSignIn, tenantName: $tenantName, userNameOrEmailAddress: $userNameOrEmailAddress)';
  }
}

class AuthApiResponse {
  final AuthenticateResponse? result;
  final String? targetUrl;
  final bool success;
  final dynamic error;
  final bool unAuthorizedRequest;
  final bool abp;

  const AuthApiResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  factory AuthApiResponse.fromJson(Map<String, dynamic> json) {
    return AuthApiResponse(
      result: json['result'] != null
          ? AuthenticateResponse.fromJson(json['result'] as Map<String, dynamic>)
          : null,
      targetUrl: json['targetUrl'] as String?,
      success: json['success'] as bool,
      error: json['error'],
      unAuthorizedRequest: json['unAuthorizedRequest'] as bool,
      abp: json['__abp'] as bool,
    );
  }
}

class AuthenticateResponse {
  final String accessToken;
  final String encryptedAccessToken;
  final int expireInSeconds;
  final bool shouldResetPassword;
  final String passwordResetCode;
  final int userId;
  final bool requiresTwoFactorVerification;
  final List<String> twoFactorAuthProviders;
  final String twoFactorRememberClientToken;
  final String returnUrl;
  final String refreshToken;
  final int refreshTokenExpireInSeconds;

  const AuthenticateResponse({
    this.accessToken = '',
    this.encryptedAccessToken = '',
    this.expireInSeconds = 0,
    this.shouldResetPassword = false,
    this.passwordResetCode = '',
    this.userId = 0,
    this.requiresTwoFactorVerification = false,
    this.twoFactorAuthProviders = const [],
    this.twoFactorRememberClientToken = '',
    this.returnUrl = '',
    this.refreshToken = '',
    this.refreshTokenExpireInSeconds = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'encryptedAccessToken': encryptedAccessToken,
      'expireInSeconds': expireInSeconds,
      'shouldResetPassword': shouldResetPassword,
      'passwordResetCode': passwordResetCode,
      'userId': userId,
      'requiresTwoFactorVerification': requiresTwoFactorVerification,
      'twoFactorAuthProviders': twoFactorAuthProviders,
      'twoFactorRememberClientToken': twoFactorRememberClientToken,
      'returnUrl': returnUrl,
      'refreshToken': refreshToken,
      'refreshTokenExpireInSeconds': refreshTokenExpireInSeconds,
    };
  }

  factory AuthenticateResponse.fromJson(Map<String, dynamic> json) {
    return AuthenticateResponse(
      accessToken: json['accessToken'] as String? ?? '',
      encryptedAccessToken: json['encryptedAccessToken'] as String? ?? '',
      expireInSeconds: json['expireInSeconds'] as int? ?? 0,
      shouldResetPassword: json['shouldResetPassword'] as bool? ?? false,
      passwordResetCode: json['passwordResetCode'] as String? ?? '',
      userId: json['userId'] as int? ?? 0,
      requiresTwoFactorVerification: json['requiresTwoFactorVerification'] as bool? ?? false,
      twoFactorAuthProviders: (json['twoFactorAuthProviders'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? [],
      twoFactorRememberClientToken: json['twoFactorRememberClientToken'] as String? ?? '',
      returnUrl: json['returnUrl'] as String? ?? '',
      refreshToken: json['refreshToken'] as String? ?? '',
      refreshTokenExpireInSeconds: json['refreshTokenExpireInSeconds'] as int? ?? 0,
    );
  }

  AuthenticateResponse copyWith({
    String? accessToken,
    String? encryptedAccessToken,
    int? expireInSeconds,
    bool? shouldResetPassword,
    String? passwordResetCode,
    int? userId,
    bool? requiresTwoFactorVerification,
    List<String>? twoFactorAuthProviders,
    String? twoFactorRememberClientToken,
    String? returnUrl,
    String? refreshToken,
    int? refreshTokenExpireInSeconds,
  }) {
    return AuthenticateResponse(
      accessToken: accessToken ?? this.accessToken,
      encryptedAccessToken: encryptedAccessToken ?? this.encryptedAccessToken,
      expireInSeconds: expireInSeconds ?? this.expireInSeconds,
      shouldResetPassword: shouldResetPassword ?? this.shouldResetPassword,
      passwordResetCode: passwordResetCode ?? this.passwordResetCode,
      userId: userId ?? this.userId,
      requiresTwoFactorVerification: requiresTwoFactorVerification ?? this.requiresTwoFactorVerification,
      twoFactorAuthProviders: twoFactorAuthProviders ?? this.twoFactorAuthProviders,
      twoFactorRememberClientToken: twoFactorRememberClientToken ?? this.twoFactorRememberClientToken,
      returnUrl: returnUrl ?? this.returnUrl,
      refreshToken: refreshToken ?? this.refreshToken,
      refreshTokenExpireInSeconds: refreshTokenExpireInSeconds ?? this.refreshTokenExpireInSeconds,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthenticateResponse &&
        other.accessToken == accessToken &&
        other.encryptedAccessToken == encryptedAccessToken &&
        other.expireInSeconds == expireInSeconds &&
        other.shouldResetPassword == shouldResetPassword &&
        other.passwordResetCode == passwordResetCode &&
        other.userId == userId &&
        other.requiresTwoFactorVerification == requiresTwoFactorVerification &&
        other.twoFactorAuthProviders == twoFactorAuthProviders &&
        other.twoFactorRememberClientToken == twoFactorRememberClientToken &&
        other.returnUrl == returnUrl &&
        other.refreshToken == refreshToken &&
        other.refreshTokenExpireInSeconds == refreshTokenExpireInSeconds;
  }

  @override
  int get hashCode {
    return Object.hash(
      accessToken,
      encryptedAccessToken,
      expireInSeconds,
      shouldResetPassword,
      passwordResetCode,
      userId,
      requiresTwoFactorVerification,
      twoFactorAuthProviders,
      twoFactorRememberClientToken,
      returnUrl,
      refreshToken,
      refreshTokenExpireInSeconds,
    );
  }

  @override
  String toString() {
    return 'AuthenticateResponse(accessToken: $accessToken, encryptedAccessToken: $encryptedAccessToken, expireInSeconds: $expireInSeconds, shouldResetPassword: $shouldResetPassword, passwordResetCode: $passwordResetCode, userId: $userId, requiresTwoFactorVerification: $requiresTwoFactorVerification, twoFactorAuthProviders: $twoFactorAuthProviders, twoFactorRememberClientToken: $twoFactorRememberClientToken, returnUrl: $returnUrl, refreshToken: $refreshToken, refreshTokenExpireInSeconds: $refreshTokenExpireInSeconds)';
  }
}

class IsTenantAvailableRequest {
  final String tenancyName;

  const IsTenantAvailableRequest({
    this.tenancyName = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'tenancyName': tenancyName,
    };
  }

  factory IsTenantAvailableRequest.fromJson(Map<String, dynamic> json) {
    return IsTenantAvailableRequest(
      tenancyName: json['tenancyName'] as String? ?? '',
    );
  }

  IsTenantAvailableRequest copyWith({
    String? tenancyName,
  }) {
    return IsTenantAvailableRequest(
      tenancyName: tenancyName ?? this.tenancyName,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is IsTenantAvailableRequest &&
        other.tenancyName == tenancyName;
  }

  @override
  int get hashCode {
    return tenancyName.hashCode;
  }

  @override
  String toString() {
    return 'IsTenantAvailableRequest(tenancyName: $tenancyName)';
  }
}