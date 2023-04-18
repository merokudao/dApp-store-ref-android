import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/core/installed_apps/i_installed_apps_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/self_update/application/cubit/i_self_update_cubit.dart';
import 'package:dappstore/features/self_update/infrastructure/models/self_update_data_model.dart';
import 'package:dappstore/features/self_update/infrastructure/repositories/i_self_update_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

part '../../../../generated/features/self_update/application/cubit/self_update_cubit.freezed.dart';
part '../../../../generated/features/self_update/application/cubit/self_update_cubit.g.dart';
part 'self_update_state.dart';

@LazySingleton(as: ISelfUpdateCubit)
class SelfUpdateCubit extends Cubit<SelfUpdateState>
    implements ISelfUpdateCubit {
  @override
  final ISelfUpdateRepo selfUpdateRepo;
  final IInstalledAppsCubit installedAppsCubit;
  IErrorLogger errorLogger;

  SelfUpdateCubit({
    required this.errorLogger,
    required this.selfUpdateRepo,
    required this.installedAppsCubit,
  }) : super(SelfUpdateState.initial());

  @override
  Future<SelfUpdateDataModel?> getLatestBuild() async {
    SelfUpdateDataModel? model = await selfUpdateRepo.getLatestBuild();
    if (model != null) {
      emit(
        state.copyWith(
          updateData: model,
        ),
      );
      return model;
    } else {
      return null;
    }
  }

  @override
  Future<UpdateType?> checkUpdate() async {
    SelfUpdateDataModel? model = await getLatestBuild();
    PackageInfo? package = await getCurrentAppVersion();
    final latestVersion = double.parse(model?.latestBuildNumber ?? "0");
    final appVersion = double.parse(package?.buildNumber ?? "0");

    final minimumSupportedVersion =
        double.parse(model?.minimumSupportedBuildNumber ?? "0");
    await getDappInfoForDappStore();
    UpdateType updateType;
    if (appVersion < minimumSupportedVersion) {
      updateType = UpdateType.hardUpdate;
    } else if (appVersion < latestVersion) {
      updateType = UpdateType.softUpdate;
    } else {
      updateType = UpdateType.noUpdate;
    }
    emit(state.copyWith(
      updateType: updateType,
    ));
    return updateType;
  }

  @override
  UpdateType get updateStatus => state.updateType!;
  @override
  SelfUpdateDataModel? get updateData => state.updateData;
  @override
  Future<DappInfo?> getDappInfoForDappStore() async {
    PackageInfo? package = await selfUpdateRepo.getAppVersion();
    if (package != null) {
      final appInfo =
          await installedAppsCubit.getAppInfo(packageName: package.packageName);

      if (appInfo != null) {
        DappInfo dappStoreInfo = DappInfo(
          name: appInfo.name,
          packageId: appInfo.packageName,
          dappId: appInfo.packageName,
          version: state.updateData?.latestBuildNumber ?? "0",
          availableOnPlatform: ["android"],
        );
        emit(state.copyWith(storeInfo: dappStoreInfo));
        return dappStoreInfo;
      } else {
        return null;
      }
    }
    return null;
  }

  @override
  Future<PackageInfo?> getCurrentAppVersion() async {
    PackageInfo? pacakge = await selfUpdateRepo.getAppVersion();
    if (pacakge != null) {
      emit(
        state.copyWith(
          currentAppVersion: pacakge.version,
        ),
      );
      return pacakge;
    } else {
      return null;
    }
  }
}

enum UpdateType {
  hardUpdate,
  softUpdate,
  noUpdate,
}
