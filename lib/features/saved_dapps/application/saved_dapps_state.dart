part of 'saved_dapps_cubit.dart';

@freezed
class SavedDappsState with _$SavedDappsState {
  const factory SavedDappsState({
    bool? loading,
    List<DappInfo>? dappInfoList,
    List<DappInfo>? needUpdate,
    List<DappInfo>? noUpdate,
    Map<String, PackageInfo>? installedApps,
  }) = _SavedDappsState;

  factory SavedDappsState.initial() => const SavedDappsState(
        loading: false,
        dappInfoList: [],
        installedApps: {},
        needUpdate: [],
        noUpdate: [],
      );
}
