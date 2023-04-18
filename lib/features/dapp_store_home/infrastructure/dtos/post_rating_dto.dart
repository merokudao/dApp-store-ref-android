import 'package:dappstore/features/dapp_store_home/domain/entities/post_rating.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part '../../../../generated/features/dapp_store_home/infrastructure/dtos/post_rating_dto.freezed.dart';
part '../../../../generated/features/dapp_store_home/infrastructure/dtos/post_rating_dto.g.dart';

@freezed
class PostRatingDto with _$PostRatingDto {
  const PostRatingDto._();

  factory PostRatingDto({
    String? dappId,
    int? rating,
    String? comment,
    String? userId,
    String? userName,
    String? userAddress,
  }) = _PostRatingDto;
  factory PostRatingDto.fromJson(Map<String, Object?> json) =>
      _$PostRatingDtoFromJson(json);
  toDomain() => PostRating(
        dappId: dappId,
        rating: rating,
        comment: comment,
        userId: userId,
        userName: userName,
        userAddress: userAddress,
      );
}
