class FeatureValueModel {
  final String name;
  final String value;

  const FeatureValueModel({required this.name, required this.value});

  factory FeatureValueModel.fromJson(Map<String, dynamic> json) {
    return FeatureValueModel(
      name: json['name'] as String,
      value: json['value'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'value': value};
  }
}

class EditionModel {
  final String name;
  final String displayName;
  final String? publicDescription;
  final int id;

  const EditionModel({
    required this.name,
    required this.displayName,
    this.publicDescription,
    required this.id,
  });

  factory EditionModel.fromJson(Map<String, dynamic> json) {
    return EditionModel(
      name: json['name'] as String,
      displayName: json['displayName'] as String,
      publicDescription: json['publicDescription'] as String?,
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'displayName': displayName,
      'publicDescription': publicDescription,
      'id': id,
    };
  }
}

class EditionWithFeaturesModel {
  final EditionModel edition;
  final List<FeatureValueModel> featureValues;

  const EditionWithFeaturesModel({
    required this.edition,
    this.featureValues = const [],
  });

  factory EditionWithFeaturesModel.fromJson(Map<String, dynamic> json) {
    return EditionWithFeaturesModel(
      edition: EditionModel.fromJson(json['edition'] as Map<String, dynamic>),
      featureValues:
          (json['featureValues'] as List<dynamic>?)
              ?.map(
                (e) => FeatureValueModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'edition': edition.toJson(),
      'featureValues': featureValues.map((e) => e.toJson()).toList(),
    };
  }
}

class FeatureModel {
  final String name;
  final String displayName;

  const FeatureModel({required this.name, required this.displayName});

  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return FeatureModel(
      name: json['name'] as String,
      displayName: json['displayName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'displayName': displayName};
  }
}

class EditionsForSelectResultModel {
  final List<FeatureModel> allFeatures;
  final List<EditionWithFeaturesModel> editionsWithFeatures;
  final int? tenantEditionId;

  const EditionsForSelectResultModel({
    this.allFeatures = const [],
    this.editionsWithFeatures = const [],
    this.tenantEditionId,
  });

  factory EditionsForSelectResultModel.fromJson(Map<String, dynamic> json) {
    return EditionsForSelectResultModel(
      allFeatures:
          (json['allFeatures'] as List<dynamic>?)
              ?.map((e) => FeatureModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      editionsWithFeatures:
          (json['editionsWithFeatures'] as List<dynamic>?)
              ?.map(
                (e) => EditionWithFeaturesModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      tenantEditionId: json['tenantEditionId'] as int?,
    );
  }
}

class EditionModelApiResponse {
  final EditionsForSelectResultModel? result;
  final String? targetUrl;
  final bool success;
  final dynamic error;
  final bool unAuthorizedRequest;
  final bool abp;

  const EditionModelApiResponse({
    this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  factory EditionModelApiResponse.fromJson(Map<String, dynamic> json) {
    return EditionModelApiResponse(
      result: json['result'] != null
          ? EditionsForSelectResultModel.fromJson(
          json['result'] as Map<String, dynamic>)
          : null,
      targetUrl: json['targetUrl'] as String?,
      success: json['success'] as bool,
      error: json['error'],
      unAuthorizedRequest: json['unAuthorizedRequest'] as bool,
      abp: json['__abp'] as bool,
    );
  }
}
