import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/self_update/application/cubit/i_self_update_cubit.dart';

abstract class ISelfUpdateHandler {
  IPackageManager get packageManager;
  ISelfUpdateCubit get selfUpdateCubit;
  IThemeCubit get themeCubit;

  /// Handler to download the lastest vesrion of dapp store available
  Future<bool> triggerUpdate();
}
