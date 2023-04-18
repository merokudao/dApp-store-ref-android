import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/i_pwa_webview_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part '../../../../generated/features/pwa_webwiew/application/pwa_webview_cubit/pwa_webview_cubit.freezed.dart';
part 'pwa_webview_state.dart';

//this cubit handles state of website that is opened in webview
@LazySingleton(as: IPwaWebviewCubit)
class PwaWebviewCubit extends Cubit<PwaWebviewState>
    implements IPwaWebviewCubit {
  PwaWebviewCubit() : super(PwaWebviewState.initial());

  InAppWebViewController? _webViewController;

  @override
  InAppWebViewController? get webViewController => _webViewController;

  @override
  initWebViewController(InAppWebViewController controller) {
    _webViewController = controller;
  }

  @override
  updateButtonsState({
    bool loadStart = false,
  }) async {
    final enableBack = await _webViewController!.canGoBack();
    final enableForward = await _webViewController!.canGoForward();
    final title = await _webViewController!.getTitle() ?? '';
    emit(state.copyWith(
      enableBack: enableBack,
      enableForward: enableForward,
      title: title,
    ));
  }

  @override
  void onChange(change) {
    debugPrint('onChange $change');
    super.onChange(change);
  }

  @override
  void setErrorPopupState(bool popupState) {
    emit(state.copyWith(errorPopup: popupState));
  }

  @override
  bool get isErrorPopupOpen => state.errorPopup;

  @override
  showUrlField() {
    debugPrint('showUrlField PREV: ${state.enableUrlField}');
    emit(state.copyWith(enableUrlField: true));
  }

  @override
  hideUrlField() {
    debugPrint('hideUrlField PREV: ${state.enableUrlField}');
    emit(state.copyWith(enableUrlField: false));
  }

  @override
  updateUrlField(bool value) {
    emit(state.copyWith(enableUrlField: value));
  }

  @override
  updateProgress(int value) {
    emit(state.copyWith(progress: value));
  }

  @override
  setLoading(bool value) {
    emit(state.copyWith(loading: value));
  }

  @override
  setUrl(String url) {
    emit(state.copyWith(url: url));
  }
}
