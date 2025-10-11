class TenantResultData {
  final int state;
  final int? tenantId;
  final String? serverRootAddress;
  final String? apiUrl;
  final String? dnsUrl;

  TenantResultData({
    required this.state,
    this.tenantId,
    this.serverRootAddress,
    this.apiUrl,
    this.dnsUrl,
  });

  factory TenantResultData.fromJson(Map<String, dynamic> json) {
    return TenantResultData(
      state: json['state'] as int,
      tenantId: json['tenantId'] as int?,
      serverRootAddress: json['serverRootAddress'] as String?,
      apiUrl: json['apiUrl'] as String?,
      dnsUrl: json['dnsUrl'] as String?,
    );
  }
}

class TenantAvailabilityModel {
  final TenantResultData result;
  final String? targetUrl;
  final bool success;
  final bool unAuthorizedRequest;
  final bool abp;

  TenantAvailabilityModel({
    required this.result,
    this.targetUrl,
    required this.success,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  factory TenantAvailabilityModel.fromJson(Map<String, dynamic> json) {
    return TenantAvailabilityModel(
      result: TenantResultData.fromJson(json['result'] as Map<String, dynamic>),
      targetUrl: json['targetUrl'] as String?,
      success: json['success'] as bool,
      unAuthorizedRequest: json['unAuthorizedRequest'] as bool,
      abp: json['__abp'] as bool,
    );
  }
}