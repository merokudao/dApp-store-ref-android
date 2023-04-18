import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/features/dapp_store_home/infrastructure/dtos/dapp_info_dto.freezed.dart';
part '../../../../generated/features/dapp_store_home/infrastructure/dtos/dapp_info_dto.g.dart';

@freezed
class DappInfoDto with _$DappInfoDto {
  const DappInfoDto._();

  factory DappInfoDto({
    String? name,
    String? description,
    String? appUrl,
    String? packageId,
    ImagesDto? images,
    String? repoUrl,
    String? dappId,
    int? minAge,
    bool? isForMatureAudience,
    bool? isSelfModerated,
    String? language,
    String? version,
    bool? isListed,
    String? listDate,
    List<String?>? availableOnPlatform,
    GeoRestrictionsDto? geoRestrictions,
    DeveloperDto? developer,
    List<String?>? tags,
    List<int?>? chains,
    String? category,
    MetricsDto? metrics,
  }) = _DappInfoDto;
  factory DappInfoDto.fromJson(Map<String, Object?> json) =>
      _$DappInfoDtoFromJson(json);

  toDomain() => DappInfo.fromJson(toJson());
}

@freezed
class ImagesDto with _$ImagesDto {
  factory ImagesDto({
    String? logo,
    String? banner,
    List<String?>? screenshots,
  }) = _ImagesDto;
  factory ImagesDto.fromJson(Map<String, Object?> json) =>
      _$ImagesDtoFromJson(json);
}

@freezed
class GeoRestrictionsDto with _$GeoRestrictionsDto {
  factory GeoRestrictionsDto({
    List<String?>? allowedCountries,
    List<String?>? blockedCountries,
  }) = _GeoRestrictionsDto;
  factory GeoRestrictionsDto.fromJson(Map<String, Object?> json) =>
      _$GeoRestrictionsDtoFromJson(json);
}

@freezed
class DeveloperDto with _$DeveloperDto {
  factory DeveloperDto({
    String? legalName,
    String? logo,
    String? website,
    String? privacyPolicyUrl,
    SupportDto? support,
    String? githubID,
  }) = _DeveloperDto;
  factory DeveloperDto.fromJson(Map<String, Object?> json) =>
      _$DeveloperDtoFromJson(json);
}

@freezed
class SupportDto with _$SupportDto {
  factory SupportDto({
    String? url,
    String? email,
  }) = _SupportDto;
  factory SupportDto.fromJson(Map<String, Object?> json) =>
      _$SupportDtoFromJson(json);
}

@freezed
class MetricsDto with _$MetricsDto {
  factory MetricsDto({
    String? dappId,
    int? downloads,
    int? installs,
    int? uninstalls,
    int? ratingsCount,
    int? visits,
    double? rating,
  }) = _MetricsDto;
  factory MetricsDto.fromJson(Map<String, Object?> json) =>
      _$MetricsDtoFromJson(json);
}
