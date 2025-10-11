class PasswordComplexityModel {
  final bool requireDigit;
  final bool requireLowercase;
  final bool requireNonAlphanumeric;
  final bool requireUppercase;
  final int requiredLength;

  const PasswordComplexityModel({
    this.requireDigit = false,
    this.requireLowercase = false,
    this.requireNonAlphanumeric = false,
    this.requireUppercase = false,
    this.requiredLength = 8,
  });

  Map<String, dynamic> toJson() {
    return {
      'requireDigit': requireDigit,
      'requireLowercase': requireLowercase,
      'requireNonAlphanumeric': requireNonAlphanumeric,
      'requireUppercase': requireUppercase,
      'requiredLength': requiredLength,
    };
  }

  factory PasswordComplexityModel.fromJson(Map<String, dynamic> json) {
    return PasswordComplexityModel(
      requireDigit: json['requireDigit'] as bool? ?? false,
      requireLowercase: json['requireLowercase'] as bool? ?? false,
      requireNonAlphanumeric: json['requireNonAlphanumeric'] as bool? ?? false,
      requireUppercase: json['requireUppercase'] as bool? ?? false,
      requiredLength: json['requiredLength'] as int? ?? 8,
    );
  }

  PasswordComplexityModel copyWith({
    bool? requireDigit,
    bool? requireLowercase,
    bool? requireNonAlphanumeric,
    bool? requireUppercase,
    int? requiredLength,
  }) {
    return PasswordComplexityModel(
      requireDigit: requireDigit ?? this.requireDigit,
      requireLowercase: requireLowercase ?? this.requireLowercase,
      requireNonAlphanumeric: requireNonAlphanumeric ?? this.requireNonAlphanumeric,
      requireUppercase: requireUppercase ?? this.requireUppercase,
      requiredLength: requiredLength ?? this.requiredLength,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PasswordComplexityModel &&
        other.requireDigit == requireDigit &&
        other.requireLowercase == requireLowercase &&
        other.requireNonAlphanumeric == requireNonAlphanumeric &&
        other.requireUppercase == requireUppercase &&
        other.requiredLength == requiredLength;
  }

  @override
  int get hashCode {
    return Object.hash(
      requireDigit,
      requireLowercase,
      requireNonAlphanumeric,
      requireUppercase,
      requiredLength,
    );
  }

  @override
  String toString() {
    return 'PasswordComplexityModel(requireDigit: $requireDigit, requireLowercase: $requireLowercase, requireNonAlphanumeric: $requireNonAlphanumeric, requireUppercase: $requireUppercase, requiredLength: $requiredLength)';
  }
}

class PasswordComplexityResultModel {
  final PasswordComplexityModel setting;

  const PasswordComplexityResultModel({required this.setting});

  factory PasswordComplexityResultModel.fromJson(Map<String, dynamic> json) {
    return PasswordComplexityResultModel(
      setting: PasswordComplexityModel.fromJson(
          json['setting'] as Map<String, dynamic>),
    );
  }
}

class PasswordComplexityApiResponse {
  final PasswordComplexityResultModel? result;
  final String? targetUrl;
  final bool success;
  final dynamic error;
  final bool unAuthorizedRequest;
  final bool abp;

  const PasswordComplexityApiResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  factory PasswordComplexityApiResponse.fromJson(Map<String, dynamic> json) {
    return PasswordComplexityApiResponse(
      result: json['result'] != null
          ? PasswordComplexityResultModel.fromJson(json['result'] as Map<String, dynamic>)
          : null,
      targetUrl: json['targetUrl'] as String?,
      success: json['success'] as bool,
      error: json['error'],
      unAuthorizedRequest: json['unAuthorizedRequest'] as bool,
      abp: json['__abp'] as bool,
    );
  }
}