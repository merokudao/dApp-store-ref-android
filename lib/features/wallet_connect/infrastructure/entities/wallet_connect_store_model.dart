import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part '../../../../generated/features/wallet_connect/infrastructure/entities/wallet_connect_store_model.freezed.dart';
part '../../../../generated/features/wallet_connect/infrastructure/entities/wallet_connect_store_model.g.dart';

@freezed
@HiveType(typeId: 4)
class WalletConnectStoreModel with _$WalletConnectStoreModel {
  const factory WalletConnectStoreModel({
    @HiveField(1) required String topidID,
    @HiveField(2) required String signature,
  }) = _WalletConnectStoreModel;
  factory WalletConnectStoreModel.fromJson(Map<String, Object?> json) =>
      _$WalletConnectStoreModelFromJson(json);
}
