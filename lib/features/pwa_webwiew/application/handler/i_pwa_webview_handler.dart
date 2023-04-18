import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/i_injected_web3_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/i_pwa_webview_cubit.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_injected_web3/flutter_injected_web3.dart';

typedef TxPopupCallback = Function();

abstract class IPwaWebviewHandler {
  IPwaWebviewCubit get webViewCubit;
  IInjectedWeb3Cubit get injectedWeb3Cubit;
  IWalletConnectCubit get walletConnectCubit;
  void initialise(
    TxPopupCallback callback,
    TxPopupCallback chainNotSupportedCallback,
  );
  void unfocus();
  void onBackPressed();
  void onForwardPressed();
  void initWebViewCubit(InAppWebViewController controller);
  initInjectedWeb3(BuildContext context);
  void clearCookies();
  void reload();
  void onLoadStop(InAppWebViewController controller, Uri? uri);

  IThemeCubit get themeCubit;

  void loadStop();

  void onProgressChanged(InAppWebViewController controller, int progress);

  void onLoadStart(InAppWebViewController controller, Uri? uri);

  Future<String> signMessage(
      InAppWebViewController controller, String data, int chainId);

  Future<IncomingAccountsModel> requestAccount(
      InAppWebViewController controller, String data, int chainId);

  Future<String> signTransaction(
      InAppWebViewController controller, JsTransactionObject data, int chainId);

  Future<String> signTypedMessage(
      InAppWebViewController controller, JsEthSignTypedData data, int chainId);

  Future<String> signPersonalMessage(
      InAppWebViewController controller, String data, int chainId);

  Future<String> addEthereumChain(
      InAppWebViewController controller, JsAddEthereumChain data, int chainId);

  Future<String> watchAsset(
      InAppWebViewController controller, JsWatchAsset data, int chainId);

  Future<String> ecRecover(
      InAppWebViewController controller, JsEcRecoverObject data, int chainId);

  Future<NavigationActionPolicy> shouldOverrideUrlLoading(
      InAppWebViewController controller, NavigationAction action);
  showNetworkSwitch(BuildContext context);
  changeChains(int chainId);
}
