import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
part '../../../../generated/features/saved_pwa/infrastructure/entities/saved_dapp_model.g.dart';
part '../../../../generated/features/saved_pwa/infrastructure/entities/saved_dapp_model.freezed.dart';

@freezed
@HiveType(typeId: 3)
class SavedPwaModel with _$SavedPwaModel {
  const factory SavedPwaModel({
    @HiveField(1) required String dappId,
    @HiveField(2) required String name,
    @HiveField(3) String? logo,
    @HiveField(4) String? banner,
    @HiveField(5) String? subtitle,
  }) = _SavedPwaModel;
  factory SavedPwaModel.fromJson(Map<String, Object?> json) =>
      _$SavedPwaModelFromJson(json);
}
