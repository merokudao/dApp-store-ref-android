import 'package:dappstore/features/dapp_store_home/domain/entities/curated_category_list.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/features/dapp_store_home/infrastructure/dtos/curated_category_list_dto.freezed.dart';
part '../../../../generated/features/dapp_store_home/infrastructure/dtos/curated_category_list_dto.g.dart';

@freezed
class CuratedCategoryListDto with _$CuratedCategoryListDto {
  const CuratedCategoryListDto._();
  factory CuratedCategoryListDto({
    String? category,
    String? image,
  }) = _CuratedCategoryListDto;
  factory CuratedCategoryListDto.fromJson(Map<String, Object?> json) =>
      _$CuratedCategoryListDtoFromJson(json);

  toDomain() => CuratedCategoryList.fromJson(toJson());
}
