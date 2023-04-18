import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/curated_category_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/curated_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/post_rating.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/rating_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/repositories/i_dapp_list_repository.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/rating_list_query_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part '../../../../generated/features/dapp_store_home/application/store_cubit/store_cubit.freezed.dart';
part '../../../../generated/features/dapp_store_home/application/store_cubit/store_cubit.g.dart';
part 'store_state.dart';

@LazySingleton(as: IStoreCubit)
class StoreCubit extends Cubit<StoreState> implements IStoreCubit {
  @override
  IDappListRepo dappListRepo;
  StoreCubit({required this.dappListRepo}) : super(StoreState.initial());

  @override
  Future<void> close() {
    return super.close();
  }

  @override
  started() async {
    getDappList();
    getFeaturedDappsList();
    await getCuratedCategoryList();
    for (var i = 0; i < state.curatedCategoryList!.length; i++) {
      if (state.curatedCategoryList?[i]?.category != null) {
        getFeaturedDappsByCategory(
            category: state.curatedCategoryList![i]!.category!);
      }
    }
  }

  @override
  getDappList() async {
    DappList? dappList =
        await dappListRepo.getDappList(queryParams: GetDappQueryDto(limit: 20));
    emit(state.copyWith(
        dappList: dappList, dappListCurrentPage: dappList?.page));
  }

  @override
  getDappListNextPage() async {
    if (!(state.isLoadingNextDappListPage ?? false)) {
      int nextPage = (state.dappListCurrentPage ?? 0) + 1;
      if (nextPage <= (state.dappList?.pageCount ?? 0)) {
        emit(state.copyWith(isLoadingNextDappListPage: true));

        DappList? dappList = await dappListRepo.getDappList(
            queryParams: GetDappQueryDto(page: nextPage));
        DappList? currentList = state.dappList;
        DappList updatedList = DappList(
            page: dappList?.page,
            limit: dappList?.limit,
            pageCount: dappList?.pageCount,
            response: [...?currentList?.response, ...?dappList?.response]);

        emit(state.copyWith(
          dappList: updatedList,
          dappListCurrentPage: updatedList.page,
          isLoadingNextDappListPage: false,
        ));
      }
    }
  }

  @override
  Future<DappInfo?> getDappInfo({GetDappInfoQueryDto? queryParams}) async {
    DappInfo? dappInfo =
        await dappListRepo.getDappInfo(queryParams: queryParams);
    return dappInfo;
  }

  @override
  setActiveDappId({required String dappId}) {
    emit(state.copyWith(activeDappId: dappId));
  }

  @override
  DappInfo? get getActiveDappInfo {
    return state.dappList?.response?.firstWhere(
        (element) => element?.dappId == state.activeDappId, orElse: () {
      return state.searchResult?.response?.firstWhere(
          (element) => element?.dappId == state.activeDappId, orElse: () {
        return state.selectedCategoryDappList?.response?.firstWhere(
            (element) => element?.dappId == state.activeDappId, orElse: () {
          return state.featuredDappList?.response?.firstWhere(
              (element) => element?.dappId == state.activeDappId, orElse: () {
            return null;
          });
        });
      });
    });
  }

  @override
  getCuratedList() async {
    List<CuratedList>? curatedList = await dappListRepo.getCuratedList();
    emit(state.copyWith(curatedList: curatedList));
  }

  @override
  getSearchDappList({required GetDappQueryDto queryParams}) async {
    DappList? dappList =
        await dappListRepo.getDappList(queryParams: queryParams);
    emit(state.copyWith(
      searchResult: dappList,
      searchPage: dappList?.page,
      searchParams: queryParams,
    ));
  }

  @override
  getSearchDappListNextPage() async {
    if (!(state.isLoadingNextSearchPage ?? false)) {
      GetDappQueryDto queryParams = state.searchParams!;
      int nextPage = (state.searchPage ?? 0) + 1;
      if (nextPage <= (state.searchResult?.pageCount ?? 0)) {
        emit(state.copyWith(isLoadingNextSearchPage: true));

        DappList? searchList = await dappListRepo.getDappList(
            queryParams: queryParams.copyWith(page: nextPage));
        DappList? currentList = state.searchResult;
        DappList updatedList = DappList(
            page: searchList?.page,
            limit: searchList?.limit,
            pageCount: searchList?.pageCount,
            response: [...?currentList?.response, ...?searchList?.response]);

        emit(state.copyWith(
          searchResult: updatedList,
          searchPage: updatedList.page,
          searchParams: queryParams.copyWith(page: nextPage),
          isLoadingNextSearchPage: false,
        ));
      }
    }
  }

  @override
  resetSelectedCategory() async {
    emit(state.copyWith(
      selectedCategoryDappList: null,
      selectedCategoryPage: null,
      categoryParams: null,
      isLoadingNextselectedCategoryPage: false,
    ));
  }

  @override
  getSelectedCategoryDappList({required GetDappQueryDto queryParams}) async {
    emit(state.copyWith(isLoadingNextselectedCategoryPage: true));
    DappList? dappList =
        await dappListRepo.getDappList(queryParams: queryParams);
    emit(state.copyWith(
      selectedCategoryDappList: dappList,
      selectedCategoryPage: dappList?.page,
      categoryParams: queryParams,
      isLoadingNextselectedCategoryPage: false,
    ));
  }

  @override
  getSelectedCategoryDappListNextPage() async {
    if (!(state.isLoadingNextselectedCategoryPage ?? false)) {
      GetDappQueryDto queryParams = state.categoryParams!;
      int nextPage = (state.selectedCategoryPage ?? 0) + 1;
      if (nextPage <= (state.selectedCategoryDappList?.pageCount ?? 0)) {
        emit(state.copyWith(isLoadingNextselectedCategoryPage: true));

        DappList? searchList = await dappListRepo.getDappList(
            queryParams: queryParams.copyWith(page: nextPage));
        DappList? currentList = state.selectedCategoryDappList;
        DappList updatedList = DappList(
            page: searchList?.page,
            limit: searchList?.limit,
            pageCount: searchList?.pageCount,
            response: [...?currentList?.response, ...?searchList?.response]);

        emit(state.copyWith(
          selectedCategoryDappList: updatedList,
          selectedCategoryPage: updatedList.page,
          categoryParams: queryParams.copyWith(page: nextPage),
          isLoadingNextselectedCategoryPage: false,
        ));
      }
    }
  }

  @override
  getCuratedCategoryList() async {
    List<CuratedCategoryList>? curatedCategoryList =
        await dappListRepo.getCuratedCategoryList();
    emit(state.copyWith(curatedCategoryList: curatedCategoryList));
  }

  @override
  getFeaturedDappsByCategory({required String category}) async {
    DappList? dappList =
        await dappListRepo.getFeaturedDappsByCategory(category: category);
    Map<String, DappList?> map = Map.of(state.featuredDappsByCategory ?? {});
    map[category] = dappList;

    emit(state.copyWith(featuredDappsByCategory: map));
  }

  @override
  getFeaturedDappsList() async {
    DappList? dappList = await dappListRepo.getFeaturedDappsList();
    emit(state.copyWith(featuredDappList: dappList));
  }

  @override
  getBuildUrl(String dappId, String address) {
    String? build = dappListRepo.getBuildUrl(dappId, address);
    return build;
  }

  @override
  String getPwaRedirectionUrl(String dappId, String walletAddress) {
    String? url = dappListRepo.getPwaRedirectionUrl(dappId, walletAddress);
    return url;
  }

  @override
  Future<Map<String, DappInfo?>> queryWithPackageId(
      {required List<String> pacakgeIds}) async {
    final Map<String, DappInfo?> mapping =
        await dappListRepo.queryWithPackageId(pacakgeIds: pacakgeIds);
    return mapping;
  }

  @override
  Future<bool> postRating({required PostRating ratingData}) async {
    final bool status = await dappListRepo.postRating(ratingData: ratingData);

    return status;
  }

  @override
  Future<RatingList?> getRating({
    required RatingListQueryDto params,
  }) async {
    final RatingList? ratingList = await dappListRepo.getRating(params: params);
    return ratingList;
  }

  @override
  Future<PostRating?> getUserRating({
    required String dappId,
    required String address,
  }) async {
    final PostRating? ratingList =
        await dappListRepo.getUserRating(dappId: dappId, address: address);
    return ratingList;
  }

  StoreState? fromJson(Map<String, dynamic> json) {
    final storedState = StoreState.fromJson(json);
    emit(storedState);
    return storedState;
  }

  Map<String, dynamic>? toJson(StoreState state) {
    return state.toJson();
  }
}
