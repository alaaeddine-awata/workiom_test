class TenantEditionModel {
  final String name;
  final String displayName;
  final int type;
  final int id;

  const TenantEditionModel({
    this.name = '',
    this.displayName = '',
    this.type = 0,
    this.id = 0,
  });

  factory TenantEditionModel.fromJson(Map<String, dynamic> json) {
    return TenantEditionModel(
      name: json['name'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      type: json['type'] as int? ?? 0,
      id: json['id'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'displayName': displayName,
    'type': type,
    'id': id,
  };
}

class TenantModel {
  final int id;
  final String tenancyName;
  final String name;
  final int ownerId;
  final String? logoUrl;
  final String? watermarkUrl;
  final DateTime? creationTime;
  final TenantEditionModel? edition;
  final bool isInReadOnlyMode;
  final bool isSubscribed;
  final String? paymentPeriodType;
  final DateTime? subscriptionEndDateUtc;
  final DateTime? subscriptionCancelDateUtc;
  final bool isSubscriptionCanceled;
  final bool isInTrialPeriod;
  final String? apiUrl;
  final String? dnsUrl;
  final String? customerId;


  const TenantModel({
    this.id = 0,
    this.tenancyName = '',
    this.name = '',
    this.ownerId = 0,
    this.logoUrl,
    this.watermarkUrl,
    this.creationTime,
    this.edition,
    this.isInReadOnlyMode = false,
    this.isSubscribed = false,
    this.paymentPeriodType,
    this.subscriptionEndDateUtc,
    this.subscriptionCancelDateUtc,
    this.isSubscriptionCanceled = false,
    this.isInTrialPeriod = false,
    this.apiUrl,
    this.dnsUrl,
    this.customerId,
  });

  factory TenantModel.fromJson(Map<String, dynamic> json) {
    return TenantModel(
      id: json['id'] as int? ?? 0,
      tenancyName: json['tenancyName'] as String? ?? '',
      name: json['name'] as String? ?? '',
      ownerId: json['ownerId'] as int? ?? 0,
      logoUrl: json['logoUrl'] as String?,
      watermarkUrl: json['watermarkUrl'] as String?,
      creationTime: json['creationTime'] != null
          ? DateTime.tryParse(json['creationTime'] as String)
          : null,
      edition: json['edition'] != null
          ? TenantEditionModel.fromJson(json['edition'] as Map<String, dynamic>)
          : null,
      isInReadOnlyMode: json['isInReadOnlyMode'] as bool? ?? false,
      isSubscribed: json['isSubscribed'] as bool? ?? false,
      paymentPeriodType: json['paymentPeriodType'] as String?,
      subscriptionEndDateUtc: json['subscriptionEndDateUtc'] != null
          ? DateTime.tryParse(json['subscriptionEndDateUtc'] as String) // Assuming null or string date
          : null,
      subscriptionCancelDateUtc: json['subscriptionCancelDateUtc'] != null
          ? DateTime.tryParse(json['subscriptionCancelDateUtc'] as String)
          : null,
      isSubscriptionCanceled: json['isSubscriptionCanceled'] as bool? ?? false,
      isInTrialPeriod: json['isInTrialPeriod'] as bool? ?? false,
      apiUrl: json['apiUrl'] as String?,
      dnsUrl: json['dnsUrl'] as String?,
      customerId: json['customerId'] as String?,
    );
  }
}