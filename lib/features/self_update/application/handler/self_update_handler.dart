import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/self_update/application/cubit/i_self_update_cubit.dart';
import 'package:dappstore/features/self_update/application/cubit/self_update_cubit.dart';
import 'package:dappstore/features/self_update/application/handler/i_self_update_handler.dart';
import 'package:dappstore/features/self_update/infrastructure/models/self_update_data_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISelfUpdateHandler)
class SelfUpdateHandler implements ISelfUpdateHandler {
  @override
  IPackageManager get packageManager => getIt<IPackageManager>();

  @override
  ISelfUpdateCubit get selfUpdateCubit => getIt<ISelfUpdateCubit>();

  @override
  IThemeCubit get themeCubit => getIt<IThemeCubit>();

  /// Handler to download the lastest vesrion of dapp store available
  @override
  Future<bool> triggerUpdate() async {
    final updateStatus = selfUpdateCubit.updateStatus;
    final SelfUpdateDataModel? data = selfUpdateCubit.updateData;
    final info = await selfUpdateCubit.getDappInfoForDappStore();

    if (updateStatus != UpdateType.noUpdate &&
        data?.downloadUrl != null &&
        info != null) {
      packageManager.startDownload(info, data!.downloadUrl!, false);
      return true;
    }
    return false;
  }
}
