import 'package:dappstore/core/application/i_app_handler.dart';
import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/localisation/i_localisation_cubit.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/saved_dapps/application/i_saved_dapps_cubit.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAppHandler)
class AppHandler implements IAppHandler {
  @override
  IThemeCubit get themeCubit => getIt<IThemeCubit>();

  @override
  ILocaleCubit get localeCubit => getIt<ILocaleCubit>();

  @override
  IPackageManager get packageManager => getIt<IPackageManager>();
  @override
  ISavedDappsCubit get savedDappsCubit => getIt<ISavedDappsCubit>();
  @override
  setDarkTheme() {
    themeCubit.setDarkTheme();
  }

  @override
  setLightTheme() {
    themeCubit.setLightTheme();
  }

  @override
  bool get isFollowingSystemBrightness =>
      getIt<IThemeCubit>().state.shouldFollowSystem ?? false;

  @override
  reloadPackages() => packageManager.reloadPackageManagerData();

  @override
  checkUpdates() => savedDappsCubit.initialise();
}
