import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/i_pwa_webview_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/presentation/screens/pwa_webview_screen.dart';
import 'package:dappstore/features/saved_pwa/application/handler/i_saved_pwa_page_handler.dart';
import 'package:dappstore/features/saved_pwa/application/i_saved_pwa_cubit.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dappstore/widgets/bottom_sheet/error_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISavedPwaPageHandler)
class SavedPwaPageHandler implements ISavedPwaPageHandler {
  @override
  IThemeCubit get themeCubit => getIt<IThemeCubit>();
  @override
  IStoreCubit get storeCubit => getIt<IStoreCubit>();
  @override
  ISavedPwaCubit get savedPwaCubit => getIt<ISavedPwaCubit>();
  @override
  IWalletConnectCubit get walletConnectCubit => getIt<IWalletConnectCubit>();
  @override
  IPwaWebviewCubit get pwaWebviewCubit => getIt<IPwaWebviewCubit>();
  @override
  openPwaApp(BuildContext context, String dappId) async {
    try {
      final dappInfo = await storeCubit.getDappInfo(
          queryParams: GetDappInfoQueryDto(dappId: dappId));

      if (walletConnectCubit.signClient?.session.keys.isNotEmpty ?? false) {
        String url = storeCubit.getPwaRedirectionUrl(
            dappInfo.dappId!, walletConnectCubit.getActiveAdddress()!);
        debugPrint(url);
        pwaWebviewCubit.setUrl(url);
        // ignore: use_build_context_synchronously
        context.pushRoute(PwaWebView(
          dappName: dappInfo.name!,
        ));
      } else {
        // ignore: use_build_context_synchronously
        context.showErrorSheet(
            title: context.getLocale!.noWallet,
            subtitle: context.getLocale!.connectWallet,
            theme: themeCubit.theme);
      }
    } catch (e, stack) {
      getIt<IErrorLogger>().logError(e, stack);

      context.showErrorSheet(
          title: context.getLocale!.somethingWentWrong,
          subtitle: context.getLocale!.tryAgain,
          theme: themeCubit.theme);
    }
  }
}
