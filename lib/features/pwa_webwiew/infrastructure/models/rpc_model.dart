import 'package:freezed_annotation/freezed_annotation.dart';
part '../../../../generated/features/pwa_webwiew/infrastructure/models/rpc_model.freezed.dart';

@freezed
class RpcModel with _$RpcModel {
  const factory RpcModel({
    required String name,
    required String icon,
    required String rpc,
  }) = _RpcModel;
}
