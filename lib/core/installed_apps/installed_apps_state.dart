part of 'installed_apps_cubit.dart';

@freezed
class InstalledAppsState with _$InstalledAppsState {
  const factory InstalledAppsState({
    List<AppInfo>? appList,
  }) = _InstalledAppsState;

  factory InstalledAppsState.initial() => const InstalledAppsState(appList: []);
}
