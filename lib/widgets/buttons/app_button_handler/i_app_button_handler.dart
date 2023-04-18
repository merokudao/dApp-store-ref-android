import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/i_pwa_webview_cubit.dart';
import 'package:dappstore/features/saved_pwa/application/i_saved_pwa_cubit.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:flutter/material.dart';

abstract class IAppButtonHandler {
  IPackageManager get packageManager;
  IPwaWebviewCubit get pwaWebviewCubit;
  IStoreCubit get storeCubit;
  IWalletConnectCubit get walletConnectCubit;
  ISavedPwaCubit get savedPwaCubit;

  startDownload(DappInfo dappInfo, BuildContext context);

  openPwaApp(BuildContext context, DappInfo dappInfo);

  openApp(DappInfo dappInfo);

  triggerInstall(DappInfo dappInfo);

  unsaveDapp(DappInfo dappInfo);

  isDappSaved(DappInfo dappInfo);

  saveDapp(DappInfo dappInfo);
}
