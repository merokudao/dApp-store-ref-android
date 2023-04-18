import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_installer/flutter_app_installer.dart';

class Installer {
  static IErrorLogger errorLogger = getIt<IErrorLogger>();
  static Future<bool> installPackage(String apkPath) async {
    try {
      debugPrint(apkPath);
      await AppInstaller.installApk(apkPath, actionRequired: true);
      return true;
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return false;
    }
  }

  //only one call back can be registered
  static void registerCallBack(MethodCallBack callBack) async {
    try {
      AppInstaller.registerHandler(callBack);
    } catch (e, stack) {
      errorLogger.logError(e, stack);
    }
  }
}
