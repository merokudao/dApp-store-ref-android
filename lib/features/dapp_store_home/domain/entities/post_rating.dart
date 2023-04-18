import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/post_rating_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part '../../../../generated/features/dapp_store_home/domain/entities/post_rating.freezed.dart';
part '../../../../generated/features/dapp_store_home/domain/entities/post_rating.g.dart';

@freezed
class PostRating with _$PostRating {
  const PostRating._();

  factory PostRating({
    String? dappId,
    int? rating,
    String? comment,
    String? userId,
    String? userName,
    String? userAddress,
  }) = _PostRating;
  factory PostRating.fromJson(Map<String, Object?> json) =>
      _$PostRatingFromJson(json);
  toDto() => PostRatingDto(
        dappId: dappId,
        rating: rating,
        comment: comment,
        userId: userId,
        userName: userName,
        userAddress: userAddress,
      );
}
