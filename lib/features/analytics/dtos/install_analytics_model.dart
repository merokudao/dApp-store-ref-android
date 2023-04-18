import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/features/analytics/dtos/install_analytics_model.freezed.dart';
part '../../../generated/features/analytics/dtos/install_analytics_model.g.dart';

@freezed
class InstallAnalyticsDTO with _$InstallAnalyticsDTO {
  factory InstallAnalyticsDTO({
    required String dappId,
    required String userAddress,
    required String timestamp,
    Map<String, dynamic>? metadata,
  }) = _InstallAnalyticsDTO;
  factory InstallAnalyticsDTO.fromJson(Map<String, Object?> json) =>
      _$InstallAnalyticsDTOFromJson(json);
}
