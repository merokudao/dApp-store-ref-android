part of 'pwa_webview_cubit.dart';

@freezed
class PwaWebviewState with _$PwaWebviewState {
  const factory PwaWebviewState({
    required String url,
    required String title,
    required int progress,
    required bool enableBack,
    required bool enableForward,
    required bool loading,
    required bool enableUrlField,
    required bool errorPopup,
  }) = _PwaWebviewState;
  factory PwaWebviewState.initial() => const _PwaWebviewState(
        url: 'https://dappradar.com/',
        title: '',
        progress: 0,
        enableBack: false,
        enableForward: false,
        loading: false,
        enableUrlField: false,
        errorPopup: false,
      );
}
