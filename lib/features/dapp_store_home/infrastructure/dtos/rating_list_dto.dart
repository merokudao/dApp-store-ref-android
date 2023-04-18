import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/rating_list.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/post_rating_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/features/dapp_store_home/infrastructure/dtos/rating_list_dto.freezed.dart';
part '../../../../generated/features/dapp_store_home/infrastructure/dtos/rating_list_dto.g.dart';

@freezed
class RatingListDto with _$RatingListDto {
  const RatingListDto._();
  const factory RatingListDto({
    int? page,
    int? limit,
    int? pageCount,
    List<PostRatingDto?>? response,
  }) = _RatingListDto;
  factory RatingListDto.fromJson(Map<String, Object?> json) =>
      _$RatingListDtoFromJson(json);

  toDomain() => RatingList.fromJson(toJson());
}
