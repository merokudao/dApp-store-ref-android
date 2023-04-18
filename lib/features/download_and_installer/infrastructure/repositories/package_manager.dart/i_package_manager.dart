import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/download_and_installer/domain/package_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/package_manager_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class IPackageManager extends Cubit<PackageManagerState> {
  IPackageManager() : super(PackageManagerState.initial());

  Future<void> init();

  startDownload(
    DappInfo dappInfo,
    String link,
    bool autoInstall,
  );

  triggerInstall(String fileName);

  Future<bool?> openSettings(DappInfo dappInfo);

  Future<bool?> openApp(DappInfo dappInfo);

  reloadPackageManagerData();

  Map<String, PackageInfo> installedAppsList();
}
