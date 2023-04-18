import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_title_tile_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/i_pwa_webview_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/presentation/screens/pwa_webview_screen.dart';
import 'package:dappstore/features/saved_pwa/application/i_saved_pwa_cubit.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dappstore/widgets/snacbar/snacbar_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IDappTitleTileHandler)
class DappTitleTileHandler implements IDappTitleTileHandler {
  @override
  IPackageManager get packageManager => getIt<IPackageManager>();
  @override
  IPwaWebviewCubit get pwaWebviewCubit => getIt<IPwaWebviewCubit>();
  @override
  IStoreCubit get storeCubit => getIt<IStoreCubit>();
  @override
  IWalletConnectCubit get walletConnectCubit => getIt<IWalletConnectCubit>();
  @override
  ISavedPwaCubit get savedPwaCubit => getIt<ISavedPwaCubit>();

  @override
  startDownload(DappInfo dappInfo, BuildContext context) async {
    final url = storeCubit.getBuildUrl(
        dappInfo.dappId!, walletConnectCubit.getActiveAdddress() ?? "");
    if (url != null) {
      await packageManager.startDownload(dappInfo, url, true);
    } else {
      // ignore: use_build_context_synchronously
      context.showMsgBar(context.getLocale!.apkFetchFail);
    }
  }

  @override
  openPwaApp(BuildContext context, DappInfo dappInfo) async {
    if (walletConnectCubit.signClient?.session.keys.isNotEmpty ?? false) {
      String url = storeCubit.getPwaRedirectionUrl(
          dappInfo.dappId!, walletConnectCubit.getActiveAdddress()!);
      debugPrint(url);
      pwaWebviewCubit.setUrl(url);
      context.pushRoute(PwaWebView(
        dappName: dappInfo.name!,
      ));
    } else {
      //TODO: show popup
    }
  }

  @override
  openApp(DappInfo dappInfo) async {
    await packageManager.openApp(dappInfo);
  }

  @override
  saveDapp(DappInfo dappInfo) async {
    await savedPwaCubit.savePwa(dappInfo);
  }

  @override
  isDappSaved(DappInfo dappInfo) {
    savedPwaCubit.isPwaSaved(dappInfo.dappId!);
  }

  @override
  unsaveDapp(DappInfo dappInfo) async {
    await savedPwaCubit.removePwa(dappInfo.dappId!);
  }

  @override
  triggerInstall(DappInfo dappInfo) async {
    await packageManager.triggerInstall("${dappInfo.packageId}.apk");
  }
}
