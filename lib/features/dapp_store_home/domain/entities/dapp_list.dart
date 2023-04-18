import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/features/dapp_store_home/domain/entities/dapp_list.freezed.dart';
part '../../../../generated/features/dapp_store_home/domain/entities/dapp_list.g.dart';

@freezed
class DappList with _$DappList {
  const factory DappList({
    int? page,
    int? limit,
    int? pageCount,
    List<DappInfo?>? response,
  }) = _DappList;
  factory DappList.fromJson(Map<String, Object?> json) =>
      _$DappListFromJson(json);
}
