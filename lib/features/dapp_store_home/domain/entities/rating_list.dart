import 'package:dappstore/features/dapp_store_home/domain/entities/post_rating.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/features/dapp_store_home/domain/entities/rating_list.freezed.dart';
part '../../../../generated/features/dapp_store_home/domain/entities/rating_list.g.dart';

@freezed
class RatingList with _$RatingList {
  const factory RatingList({
    int? page,
    int? limit,
    int? pageCount,
    List<PostRating?>? response,
  }) = _RatingList;
  factory RatingList.fromJson(Map<String, Object?> json) =>
      _$RatingListFromJson(json);
}
