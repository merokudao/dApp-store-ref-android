import 'package:dappstore/features/download_and_installer/infrastructure/datasources/installer.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/installer/i_installer_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app_installer/flutter_app_installer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part '../../../../../generated/features/download_and_installer/infrastructure/repositories/installer/installer_cubit.freezed.dart';
part 'installer_state.dart';

@LazySingleton(as: IInstallerCubit)
class InstallerCubit extends Cubit<InstallerState> implements IInstallerCubit {
  InstallerCubit() : super(InstallerState.initial());

  @override
  installApp(String apkPath) async {
    debugPrint("calling installer");
    await Installer.installPackage(apkPath);
  }

  @override
  registerCallBack(MethodCallBack callBack) async {
    Installer.registerCallBack(callBack);
  }
}
