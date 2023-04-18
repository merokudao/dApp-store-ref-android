import 'package:dappstore/features/dapp_store_home/domain/entities/curated_list.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/features/dapp_store_home/infrastructure/dtos/curated_list_dto.freezed.dart';
part '../../../../generated/features/dapp_store_home/infrastructure/dtos/curated_list_dto.g.dart';

@freezed
class CuratedListDto with _$CuratedListDto {
  const CuratedListDto._();
  factory CuratedListDto({
    String? title,
    List<String?>? dappIds,
    String? description,
    String? key,
  }) = _CuratedListDto;
  factory CuratedListDto.fromJson(Map<String, Object?> json) =>
      _$CuratedListDtoFromJson(json);

  toDomain() => CuratedList.fromJson(toJson());
}
