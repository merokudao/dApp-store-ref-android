part of 'dapp_info_cubit.dart';

@freezed
class DappInfoState with _$DappInfoState {
  const factory DappInfoState({
    bool? loading,
    DappInfo? dappInfo,
    String? activeDappId,
    PostRating? selfRating,
    RatingList? ratingList,
    int? ratingsPage,
    RatingListQueryDto? ratingQueryParams,
    bool? isLoadingNextRating,
  }) = _DappInfoState;

  factory DappInfoState.initial() => const _DappInfoState(
        loading: true,
      );

  factory DappInfoState.fromJson(Map<String, dynamic> json) =>
      _$DappInfoStateFromJson(json);
}
