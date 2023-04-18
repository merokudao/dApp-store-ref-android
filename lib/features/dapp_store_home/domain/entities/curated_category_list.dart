import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/features/dapp_store_home/domain/entities/curated_category_list.freezed.dart';
part '../../../../generated/features/dapp_store_home/domain/entities/curated_category_list.g.dart';

@freezed
class CuratedCategoryList with _$CuratedCategoryList {
  const CuratedCategoryList._();
  factory CuratedCategoryList({
    String? category,
    String? image,
  }) = _CuratedCategoryList;
  factory CuratedCategoryList.fromJson(Map<String, Object?> json) =>
      _$CuratedCategoryListFromJson(json);
}
