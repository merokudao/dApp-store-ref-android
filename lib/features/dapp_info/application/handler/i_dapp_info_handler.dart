import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/dapp_info/application/i_dapp_info_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/rating_list_query_dto.dart';
import 'package:dappstore/features/profile/application/cubit/i_profile_cubit.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:flutter/material.dart';

abstract class IDappInfoHandler {
  IThemeCubit get themeCubit;
  IStoreCubit get storeCubit;
  IDappInfoCubit get dappInfoCubit;

  IWalletConnectCubit get walletConnectCubit;

  IProfileCubit get profileCubit;

  String? get name;

  String? get address;

  showRatingPopup(
    BuildContext context,
    Widget ratingDialog,
  );
  Future<bool> postRating(
    double rating,
    String comment,
    String dappId,
  );

  getRatings({required RatingListQueryDto params});

  getRatingListNextPage();
}
