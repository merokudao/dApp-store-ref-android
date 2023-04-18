import 'package:dappstore/core/localisation/i_localisation_cubit.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/saved_dapps/application/i_saved_dapps_cubit.dart';

abstract class IAppHandler {
  IThemeCubit get themeCubit;

  ILocaleCubit get localeCubit;

  IPackageManager get packageManager;

  ISavedDappsCubit get savedDappsCubit;

  setDarkTheme();

  setLightTheme() {
    themeCubit.setLightTheme();
  }

  bool get isFollowingSystemBrightness;

  reloadPackages();
  checkUpdates();
}
