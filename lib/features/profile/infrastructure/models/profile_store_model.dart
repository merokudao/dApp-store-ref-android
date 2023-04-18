import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part '../../../../generated/features/profile/infrastructure/models/profile_store_model.freezed.dart';
part '../../../../generated/features/profile/infrastructure/models/profile_store_model.g.dart';

@freezed
@HiveType(typeId: 5)
class ProfileStoreModel with _$ProfileStoreModel {
  const factory ProfileStoreModel({
    @HiveField(1) required String address,
    @HiveField(2) required String name,
  }) = _ProfileStoreModel;
  factory ProfileStoreModel.fromJson(Map<String, Object?> json) =>
      _$ProfileStoreModelFromJson(json);

  // ProfileModel toModel() {
  //   return ProfileModel(name: name, address: address);
  // }
}
