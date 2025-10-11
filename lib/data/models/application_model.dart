class ApplicationModel {
  final String version;
  final DateTime? releaseDate;
  final String currency;
  final String currencySign;
  final bool userDelegationIsEnabled;
  final Map<String, dynamic> features;
  final String compatibleMobileClientVersion;
  final String compatibleWebClientVersion;

  const ApplicationModel({
    this.version = '',
    this.releaseDate,
    this.currency = '',
    this.currencySign = '',
    this.userDelegationIsEnabled = false,
    this.features = const {},
    this.compatibleMobileClientVersion = '',
    this.compatibleWebClientVersion = '',
  });

  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    return ApplicationModel(
      version: json['version'] as String? ?? '',
      releaseDate: json['releaseDate'] != null
          ? DateTime.tryParse(json['releaseDate'] as String)
          : null,
      currency: json['currency'] as String? ?? '',
      currencySign: json['currencySign'] as String? ?? '',
      userDelegationIsEnabled: json['userDelegationIsEnabled'] as bool? ?? false,
      features: (json['features'] as Map<String, dynamic>?) ?? const {},
      compatibleMobileClientVersion: json['compatibleMobileClientVersion'] as String? ?? '',
      compatibleWebClientVersion: json['compatibleWebClientVersion'] as String? ?? '',
    );
  }
}