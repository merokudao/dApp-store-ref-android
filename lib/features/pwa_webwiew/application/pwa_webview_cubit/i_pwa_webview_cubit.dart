import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/pwa_webview_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

abstract class IPwaWebviewCubit extends Cubit<PwaWebviewState> {
  IPwaWebviewCubit(super.initialState);

  InAppWebViewController? get webViewController;

  initWebViewController(InAppWebViewController controller);

  updateButtonsState({
    bool loadStart = false,
  });
  @override
  void onChange(change);

  showUrlField();

  hideUrlField();

  updateUrlField(bool value);

  updateProgress(int value);

  setLoading(bool value);

  setUrl(String url);

  void setErrorPopupState(bool popupState);
  bool get isErrorPopupOpen;
}
