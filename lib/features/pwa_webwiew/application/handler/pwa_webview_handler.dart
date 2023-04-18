import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/handler/i_pwa_webview_handler.dart';
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/i_injected_web3_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/i_pwa_webview_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/infrastructure/models/rpc_mapping.dart';
import 'package:dappstore/features/pwa_webwiew/presentation/widgets/network_selector_popup.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dappstore/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_injected_web3/flutter_injected_web3.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IPwaWebviewHandler)
class PwaWebviewHandler implements IPwaWebviewHandler {
  TxPopupCallback? txPopupCallback;
  TxPopupCallback? chainNotSupportedCallback;

  @override
  IPwaWebviewCubit get webViewCubit => getIt<IPwaWebviewCubit>();

  @override
  IInjectedWeb3Cubit get injectedWeb3Cubit => getIt<IInjectedWeb3Cubit>();

  @override
  IThemeCubit get themeCubit => getIt<IThemeCubit>();

  @override
  IWalletConnectCubit get walletConnectCubit => getIt<IWalletConnectCubit>();

  @override
  void initialise(
    TxPopupCallback callback,
    TxPopupCallback chainNotSupportedCallback,
  ) {
    txPopupCallback = callback;
    this.chainNotSupportedCallback = chainNotSupportedCallback;
  }

  @override
  void unfocus() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    webViewCubit.hideUrlField();
  }

  @override
  void onBackPressed() async {
    debugPrint("On Back pressed");
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    if ((await webViewCubit.webViewController?.canGoBack()) ?? false) {
      webViewCubit.webViewController?.goBack();
    }
  }

  @override
  void onForwardPressed() async {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    if ((await webViewCubit.webViewController?.canGoForward()) ?? false) {
      webViewCubit.webViewController?.goForward();
    }
  }

  @override
  void initWebViewCubit(InAppWebViewController controller) {
    webViewCubit.initWebViewController(controller);
    controller.clearCache();
  }

  @override
  initInjectedWeb3(BuildContext context) {
    injectedWeb3Cubit.started();

    injectedWeb3Cubit.changeChains(1);
  }

  @override
  void clearCookies() {
    webViewCubit.webViewController?.clearCache();
  }

  @override
  void reload() {
    webViewCubit.webViewController?.clearCache();

    webViewCubit.webViewController?.reload();
  }

  @override
  void onProgressChanged(InAppWebViewController controller, int progress) {
    debugPrint('PROGRESS $progress');
    webViewCubit.updateProgress(progress);
  }

  @override
  void onLoadStart(InAppWebViewController controller, Uri? uri) {
    debugPrint('onLoadStart $uri');
    webViewCubit.setLoading(true);
    webViewCubit.updateButtonsState(loadStart: true);
  }

  @override
  void onLoadStop(InAppWebViewController controller, Uri? uri) {
    debugPrint('onLoadStop $uri');
    loadStop();
  }

  @override
  void loadStop() {
    webViewCubit.setLoading(false);
    webViewCubit.updateButtonsState();
  }

  @override
  Future<String> signMessage(
      InAppWebViewController controller, String data, int chainId) async {
    txPopupCallback?.call();
    return injectedWeb3Cubit.signMessage(data);
  }

  @override
  Future<IncomingAccountsModel> requestAccount(
      InAppWebViewController controller, String data, chainId) async {
    return IncomingAccountsModel(
      address: injectedWeb3Cubit.account,
      chainId: int.tryParse(injectedWeb3Cubit.chainId!),
      rpcUrl: injectedWeb3Cubit.state.connectedChainRpc,
    );
  }

  @override
  Future<String> signTransaction(InAppWebViewController controller,
      JsTransactionObject data, chainId) async {
    debugPrint("tx callback ${data.toString()}");
    txPopupCallback?.call();
    return injectedWeb3Cubit.sendTransaction(
      data,
    );
  }

  @override
  Future<String> signTypedMessage(InAppWebViewController controller,
      JsEthSignTypedData data, chainId) async {
    txPopupCallback?.call();

    return injectedWeb3Cubit.signTypedData(
      data,
    );
  }

  @override
  Future<String> signPersonalMessage(
      InAppWebViewController controller, data, chainId) async {
    txPopupCallback?.call();

    return injectedWeb3Cubit.signPersonalMessage(
      data,
    );
  }

  @override
  Future<String> addEthereumChain(InAppWebViewController controller,
      JsAddEthereumChain data, chainId) async {
    final radix = data.chainId?.contains("0x") == true ? 16 : 10;
    final strippedChainId = data.chainId?.contains("0x") == true
        ? data.chainId?.substring(2)
        : data.chainId;
    final parsedChainId = int.parse(strippedChainId ?? "1", radix: radix);
    final chainRpc = RpcMapping.networks[parsedChainId];

    if ((chainRpc == null || chainRpc.rpc == "") &&
        !webViewCubit.isErrorPopupOpen) {
      chainNotSupportedCallback?.call();
      webViewCubit.setErrorPopupState(true);
      return "";
    }
    changeChains(parsedChainId);
    return injectedWeb3Cubit.changeChains(parsedChainId);
  }

  @override
  Future<String> watchAsset(
      InAppWebViewController controller, JsWatchAsset data, chainId) async {
    return "";
  }

  @override
  Future<String> ecRecover(InAppWebViewController controller,
      JsEcRecoverObject data, chainId) async {
    return "";
  }

  @override
  Future<NavigationActionPolicy> shouldOverrideUrlLoading(
      InAppWebViewController controller,
      NavigationAction navigationAction) async {
    final navUrl = webViewCubit.webViewController?.getUrl().toString();
    debugPrint('Browser URL: $navUrl');
    if (navUrl == "") {
      return NavigationActionPolicy.ALLOW;
    } else {
      return NavigationActionPolicy.ALLOW;
    }
  }

  @override
  showNetworkSwitch(BuildContext context) {
    context.showBottomSheet(
      child: NetworkSelectorPopup(
        handler: this,
        theme: themeCubit.theme,
      ),
      theme: themeCubit.theme,
    );
  }

  @override
  changeChains(int chainId) {
    injectedWeb3Cubit.changeChains(chainId);
    webViewCubit.webViewController!.clearCache();
    webViewCubit.webViewController!.reload();
  }
}
