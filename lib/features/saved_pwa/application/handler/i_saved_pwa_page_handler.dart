import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/i_pwa_webview_cubit.dart';
import 'package:dappstore/features/saved_pwa/application/i_saved_pwa_cubit.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:flutter/material.dart';

abstract class ISavedPwaPageHandler {
  IThemeCubit get themeCubit;
  IStoreCubit get storeCubit;
  ISavedPwaCubit get savedPwaCubit;
  IWalletConnectCubit get walletConnectCubit;
  IPwaWebviewCubit get pwaWebviewCubit;
  openPwaApp(BuildContext context, String dappId);
}
