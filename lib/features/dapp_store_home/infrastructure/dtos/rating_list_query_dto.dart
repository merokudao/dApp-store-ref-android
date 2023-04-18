import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/features/dapp_store_home/infrastructure/dtos/rating_list_query_dto.freezed.dart';
part '../../../../generated/features/dapp_store_home/infrastructure/dtos/rating_list_query_dto.g.dart';

@freezed
class RatingListQueryDto with _$RatingListQueryDto {
  const RatingListQueryDto._();

  factory RatingListQueryDto({
    String? dappId,
    int? limit,
    int? page,
    int? pageCount,
  }) = _RatingListQueryDto;
  factory RatingListQueryDto.fromJson(Map<String, Object?> json) =>
      _$RatingListQueryDtoFromJson(json);

  toDomain() => RatingListQueryDto();
}
