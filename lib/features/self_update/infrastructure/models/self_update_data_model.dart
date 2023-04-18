import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/features/self_update/infrastructure/models/self_update_data_model.freezed.dart';
part '../../../../generated/features/self_update/infrastructure/models/self_update_data_model.g.dart';

@freezed
class SelfUpdateDataModel with _$SelfUpdateDataModel {
  const factory SelfUpdateDataModel({
    String? latestBuildNumber,
    String? downloadUrl,
    String? minimumSupportedBuildNumber,
  }) = _SelfUpdateDataModel;
  factory SelfUpdateDataModel.fromJson(Map<String, Object?> json) =>
      _$SelfUpdateDataModelFromJson(json);
}
