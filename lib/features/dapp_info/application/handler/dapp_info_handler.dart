import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/dapp_info/application/dapp_info_cubit.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_info_handler.dart';
import 'package:dappstore/features/dapp_info/application/i_dapp_info_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/post_rating.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/rating_list_query_dto.dart';
import 'package:dappstore/features/profile/application/cubit/i_profile_cubit.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dappstore/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';

class DappInfoHandler implements IDappInfoHandler {
  late IDappInfoCubit _dappInfoCubit;
  DappInfoHandler() {
    _dappInfoCubit = DappInfoCubit(
        storeCubit: getIt<IStoreCubit>(),
        walletConnectCubit: walletConnectCubit);
  }

  @override
  IThemeCubit get themeCubit => getIt<IThemeCubit>();

  @override
  IWalletConnectCubit get walletConnectCubit => getIt<IWalletConnectCubit>();

  @override
  IProfileCubit get profileCubit => getIt<IProfileCubit>();

  @override
  String? get name => profileCubit.state.name ?? "";

  @override
  String? get address => walletConnectCubit.getActiveAdddress();

  @override
  IStoreCubit get storeCubit => getIt<IStoreCubit>();

  @override
  IDappInfoCubit get dappInfoCubit => _dappInfoCubit;

  @override
  showRatingPopup(BuildContext context, Widget ratingDialog) async {
    context.showBottomSheet(
      child: ratingDialog,
      theme: themeCubit.theme,
    );
  }

  @override
  Future<bool> postRating(
    double rating,
    String comment,
    String dappId,
  ) async {
    final profile = await profileCubit.getProfile(
        address: walletConnectCubit.getActiveAdddress() ?? "");
    PostRating data = PostRating(
      rating: rating.toInt(),
      comment: comment,
      dappId: dappId,
      userAddress: walletConnectCubit.getActiveAdddress() ?? "",
      userName: profile?.name ?? "",
    );
    bool res = await dappInfoCubit.postUserRating(data: data);

    getRatings(params: RatingListQueryDto(dappId: dappId));
    return res;
  }

  @override
  getRatings({required RatingListQueryDto params}) async {
    dappInfoCubit.getRatings(params: params);
  }

  @override
  getRatingListNextPage() async {
    dappInfoCubit.getRatingListNextPage();
  }
}
