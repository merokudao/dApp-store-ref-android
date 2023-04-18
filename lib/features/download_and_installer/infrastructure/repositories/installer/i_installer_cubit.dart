import 'package:flutter_app_installer/flutter_app_installer.dart';

abstract class IInstallerCubit {
  installApp(String apkPath);
  registerCallBack(MethodCallBack callBack);
}
