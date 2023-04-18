import 'package:dappstore/core/installed_apps/datasource/installed_app.dart';
import 'package:dappstore/core/installed_apps/i_installed_apps_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:installed_apps/app_info.dart';
part '../../generated/core/installed_apps/installed_apps_cubit.freezed.dart';
part 'installed_apps_state.dart';

@LazySingleton(as: IInstalledAppsCubit)
class InstalledAppsCubit extends Cubit<InstalledAppsState>
    implements IInstalledAppsCubit {
  InstalledAppsCubit() : super(InstalledAppsState.initial());

  @override
  Future<List<AppInfo>?> getInstalledApps(
      {required bool excludeSystemApps,
      required bool withIcon,
      required String packageNamePrefix}) async {
    List<AppInfo>? apps = await InstalledAppsUtils.getInstalledApps(
      excludeSystemApps: excludeSystemApps,
      withIcon: withIcon,
      packageNamePrefix: packageNamePrefix,
    );
    if (apps != null) {
      emit(state.copyWith(appList: apps));
    }
    return apps;
  }

  @override
  Future<AppInfo?> getAppInfo({required String packageName}) async {
    AppInfo? appInfo =
        await InstalledAppsUtils.getAppInfo(packageName: packageName);
    return appInfo;
  }

  @override
  Future<bool?> startApp({required String packageName}) async {
    bool? status = await InstalledAppsUtils.startApp(packageName: packageName);
    return status;
  }

  @override
  Future<bool?> openSettings({required String packageName}) async {
    bool? status =
        await InstalledAppsUtils.openSettings(packageName: packageName);
    return status;
  }

  @override
  Future<bool?> isSystemApp({required String packageName}) async {
    bool? isSystemApp =
        await InstalledAppsUtils.isSystemApp(packageName: packageName);
    return isSystemApp;
  }
}
