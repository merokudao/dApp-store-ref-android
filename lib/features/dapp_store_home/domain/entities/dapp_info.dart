import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/features/dapp_store_home/domain/entities/dapp_info.freezed.dart';
part '../../../../generated/features/dapp_store_home/domain/entities/dapp_info.g.dart';

@freezed
class DappInfo with _$DappInfo {
  factory DappInfo({
    String? name,
    String? description,
    String? appUrl,
    Images? images,
    String? repoUrl,
    String? dappId,
    int? minAge,
    bool? isForMatureAudience,
    bool? isSelfModerated,
    String? packageId,
    String? language,
    String? version,
    bool? isListed,
    String? listDate,
    List<String?>? availableOnPlatform,
    GeoRestrictions? geoRestrictions,
    Developer? developer,
    List<String?>? tags,
    List<int?>? chains,
    String? category,
    Metrics? metrics,
  }) = _DappInfo;
  factory DappInfo.fromJson(Map<String, Object?> json) =>
      _$DappInfoFromJson(json);
}

@freezed
class Images with _$Images {
  factory Images({
    String? logo,
    String? banner,
    List<String>? screenshots,
  }) = _Images;
  factory Images.fromJson(Map<String, Object?> json) => _$ImagesFromJson(json);
}

@freezed
class GeoRestrictions with _$GeoRestrictions {
  factory GeoRestrictions({
    List<String?>? allowedCountries,
    List<String?>? blockedCountries,
  }) = _GeoRestrictions;
  factory GeoRestrictions.fromJson(Map<String, Object?> json) =>
      _$GeoRestrictionsFromJson(json);
}

@freezed
class Developer with _$Developer {
  factory Developer({
    String? legalName,
    String? logo,
    String? website,
    String? privacyPolicyUrl,
    Support? support,
    String? githubID,
  }) = _Developer;
  factory Developer.fromJson(Map<String, Object?> json) =>
      _$DeveloperFromJson(json);
}

@freezed
class Support with _$Support {
  factory Support({
    String? url,
    String? email,
  }) = _Support;
  factory Support.fromJson(Map<String, Object?> json) =>
      _$SupportFromJson(json);
}

@freezed
class Metrics with _$Metrics {
  factory Metrics({
    String? dappId,
    int? downloads,
    int? installs,
    int? uninstalls,
    int? ratingsCount,
    int? visits,
    double? rating,
  }) = _Metrics;
  factory Metrics.fromJson(Map<String, Object?> json) =>
      _$MetricsFromJson(json);
}
