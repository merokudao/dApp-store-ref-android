import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/download_and_installer/domain/package_info.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/installer/i_installer_cubit.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/saved_dapps/application/i_saved_dapps_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:version/version.dart';

part '../../../generated/features/saved_dapps/application/saved_dapps_cubit.freezed.dart';
part 'saved_dapps_state.dart';

// this cubit mantains a list of installed dapps and the dapps that can be updated
@LazySingleton(as: ISavedDappsCubit)
class SavedDappsCubit extends Cubit<SavedDappsState>
    implements ISavedDappsCubit {
  final IPackageManager packageManager;
  final IInstallerCubit installerCubit;
  final IStoreCubit storeCubit;
  SavedDappsCubit({
    required this.packageManager,
    required this.storeCubit,
    required this.installerCubit,
  }) : super(SavedDappsState.initial());

  //it gets a list of all the packages in the phone and checks if they are served by dappstore
  //or can be updated by dappstore
  @override
  initialise() async {
    emit(state.copyWith(loading: true));
    final installedApps = packageManager.installedAppsList();
    final dappMapping = await storeCubit.queryWithPackageId(
        pacakgeIds: installedApps.values.map((e) => e.packageName!).toList());
    dappMapping.removeWhere((k, v) => v == null);

    final List<DappInfo> nonNullDappInfo =
        dappMapping.values.toList().map((e) => e!).toList();
    final List<DappInfo> toUpdate = [];
    final List<DappInfo> notToUpdate = [];
    for (var element in nonNullDappInfo) {
      Version deviceVersion = Version.parse(
          installedApps[element.packageId!]?.versionName ?? "0.0.0");
      Version availableVersion =
          Version.parse(element.version?.replaceAll("v", "") ?? "0.0.0");
      if (deviceVersion < availableVersion) {
        toUpdate.add(element);
      } else {
        notToUpdate.add(element);
      }
    }
    emit(state.copyWith(
      dappInfoList: nonNullDappInfo,
      loading: false,
      noUpdate: notToUpdate,
      needUpdate: toUpdate,
      installedApps: installedApps,
    ));
    packageManager.stream.listen((event) {
      if ((state.installedApps?.length ?? 0) !=
          packageManager.installedAppsList().length) {
        reloadPackages();
      }
    });
  }

  reloadPackages() async {
    emit(state.copyWith(loading: true));
    final installedApps = packageManager.installedAppsList();
    final dappMapping = await storeCubit.queryWithPackageId(
        pacakgeIds: installedApps.values.map((e) => e.packageName!).toList());
    dappMapping.removeWhere((k, v) => v == null);

    final List<DappInfo> nonNullDappInfo =
        dappMapping.values.toList().map((e) => e!).toList();
    final List<DappInfo> toUpdate = [];
    final List<DappInfo> notToUpdate = [];
    for (var element in nonNullDappInfo) {
      Version deviceVersion = Version.parse(
          installedApps[element.packageId!]?.versionName ?? "0.0.0");
      Version availableVersion =
          Version.parse(element.version?.replaceAll("v", "") ?? "0.0.0");
      if (deviceVersion < availableVersion) {
        toUpdate.add(element);
      } else {
        notToUpdate.add(element);
      }
    }
    emit(state.copyWith(
      dappInfoList: nonNullDappInfo,
      loading: false,
      noUpdate: notToUpdate,
      needUpdate: toUpdate,
    ));
  }

  @override
  List<DappInfo> get toUpdate => state.needUpdate!;
  @override
  int get updateAppCount => state.needUpdate!.length;
  @override
  List<DappInfo> get noUpdate => state.noUpdate!;
  @override
  List<DappInfo> get allApps => state.dappInfoList!;
}
