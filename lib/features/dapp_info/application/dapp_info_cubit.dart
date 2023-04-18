import 'dart:developer';

import 'package:dappstore/features/dapp_info/application/i_dapp_info_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/post_rating.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/rating_list.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/rating_list_query_dto.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/features/dapp_info/application/dapp_info_cubit.freezed.dart';
part '../../../generated/features/dapp_info/application/dapp_info_cubit.g.dart';
part 'dapp_info_state.dart';

class DappInfoCubit extends Cubit<DappInfoState> implements IDappInfoCubit {
  final IStoreCubit storeCubit;
  final IWalletConnectCubit walletConnectCubit;
  DappInfoCubit({
    required this.storeCubit,
    required this.walletConnectCubit,
  }) : super(DappInfoState.initial()) {
    final dappInfo = storeCubit.getActiveDappInfo;
    if (dappInfo != null) {
      emit(
        state.copyWith(
          activeDappId: storeCubit.state.activeDappId,
          dappInfo: dappInfo,
          loading: false,
        ),
      );
    } else {
      if (storeCubit.state.activeDappId != null) {
        getDappInfo(
            queryParams:
                GetDappInfoQueryDto(dappId: storeCubit.state.activeDappId));
      }
    }
    if (storeCubit.state.activeDappId != null) {
      getRatings(
        params: RatingListQueryDto(
          dappId: storeCubit.state.activeDappId,
        ),
      );

      getUserRating(
        dappId: storeCubit.state.activeDappId!,
      );
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }

  @override
  Future<DappInfo?> getDappInfo({GetDappInfoQueryDto? queryParams}) async {
    emit(state.copyWith(loading: true));

    DappInfo? dappInfo = await storeCubit.getDappInfo(queryParams: queryParams);
    log(dappInfo.toString());
    if (dappInfo != null) {
      emit(state.copyWith(dappInfo: dappInfo, loading: false));
    }
    return dappInfo;
  }

  // @override
  // Future<List<PostRating>> getRatings({required String dappId}) async {
  //   List<PostRating> ratings = await storeCubit.getRating(dappId: dappId);
  //   log(ratings.toString());
  //   emit(state.copyWith(
  //     ratings: ratings,
  //   ));

  //   return ratings;
  // }
  @override
  getRatings({required RatingListQueryDto params}) async {
    emit(state.copyWith(isLoadingNextRating: true));
    RatingList? ratingsList = await storeCubit.getRating(params: params);
    emit(state.copyWith(
      ratingList: ratingsList,
      ratingsPage: ratingsList?.page,
      ratingQueryParams: params,
      isLoadingNextRating: false,
    ));
  }

  @override
  getRatingListNextPage() async {
    if (!(state.isLoadingNextRating ?? false)) {
      RatingListQueryDto queryParams = state.ratingQueryParams!;
      int nextPage = (state.ratingsPage ?? 0) + 1;
      if (nextPage <= (state.ratingList?.pageCount ?? 0)) {
        emit(state.copyWith(isLoadingNextRating: true));

        RatingList? searchList = await storeCubit.getRating(
            params: queryParams.copyWith(page: nextPage));
        RatingList? currentList = state.ratingList;
        RatingList updatedList = RatingList(
            page: searchList?.page,
            limit: searchList?.limit,
            pageCount: searchList?.pageCount,
            response: [...?currentList?.response, ...?searchList?.response]);

        emit(state.copyWith(
          ratingList: updatedList,
          ratingsPage: updatedList.page,
          ratingQueryParams: queryParams.copyWith(page: nextPage),
          isLoadingNextRating: false,
        ));
      }
    }
  }

  @override
  Future<bool> updateUserRating({required PostRating data}) async {
    emit(state.copyWith(
      selfRating: data,
    ));
    return true;
  }

  @override
  Future<bool> postUserRating({required PostRating data}) async {
    bool ratingStatus = await storeCubit.postRating(ratingData: data);
    if ((ratingStatus)) {
      updateUserRating(data: data);
    }
    return ratingStatus;
  }

  @override
  Future<PostRating?> getUserRating({required String dappId}) async {
    final userAddress = walletConnectCubit.getActiveAdddress();
    if (userAddress != null) {
      PostRating? rating =
          await storeCubit.getUserRating(dappId: dappId, address: userAddress);
      log(rating.toString());
      if (rating != null) {
        emit(state.copyWith(
          selfRating: rating,
        ));
      }

      return rating;
    }
    return null;
  }
}
