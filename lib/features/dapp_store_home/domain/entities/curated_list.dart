import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/features/dapp_store_home/domain/entities/curated_list.freezed.dart';
part '../../../../generated/features/dapp_store_home/domain/entities/curated_list.g.dart';

@freezed
class CuratedList with _$CuratedList {
  factory CuratedList({
    String? title,
    List<String?>? dappIds,
    String? description,
    String? key,
  }) = _CuratedList;
  factory CuratedList.fromJson(Map<String, Object?> json) =>
      _$CuratedListFromJson(json);
}
