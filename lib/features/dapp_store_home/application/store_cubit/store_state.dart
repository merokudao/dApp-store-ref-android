part of 'store_cubit.dart';

@freezed
class StoreState with _$StoreState {
  const factory StoreState({
    DappList? dappList,
    DappList? searchResult,
    DappList? featuredDappList,
    DappList? selectedCategoryDappList,
    List<CuratedCategoryList?>? curatedCategoryList,
    List<CuratedList?>? curatedList,
    Map<String, DappList?>? featuredDappsByCategory,
    int? dappListCurrentPage,
    int? searchPage,
    int? selectedCategoryPage,
    GetDappQueryDto? searchParams,
    GetDappQueryDto? categoryParams,
    String? activeDappId,
    bool? isLoadingNextSearchPage,
    bool? isLoadingNextDappListPage,
    bool? isLoadingNextselectedCategoryPage,
  }) = _StoreState;

  factory StoreState.initial() => const _StoreState(
        featuredDappsByCategory: {},
      );

  factory StoreState.fromJson(Map<String, dynamic> json) =>
      _$StoreStateFromJson(json);
}
