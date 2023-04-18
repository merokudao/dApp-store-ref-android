import 'package:installed_apps/app_info.dart';

abstract class IInstalledAppsCubit {
  Future<List<AppInfo>?> getInstalledApps(
      {required bool excludeSystemApps,
      required bool withIcon,
      required String packageNamePrefix});

  Future<AppInfo?> getAppInfo({required String packageName});

  Future<bool?> startApp({required String packageName});

  Future<bool?> openSettings({required String packageName});

  Future<bool?> isSystemApp({required String packageName});
}
