import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/saved_dapps/application/handler/i_saved_dapps_handler.dart';
import 'package:dappstore/features/saved_dapps/application/i_saved_dapps_cubit.dart';
import 'package:dappstore/features/saved_pwa/application/i_saved_pwa_cubit.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISavedDappsHandler)
class SavedDappsHandler implements ISavedDappsHandler {
  @override
  IThemeCubit get themeCubit => getIt<IThemeCubit>();
  @override
  IStoreCubit get storeCubit => getIt<IStoreCubit>();
  @override
  ISavedPwaCubit get savedPwaCubit => getIt<ISavedPwaCubit>();
  @override
  IPackageManager get packageManager => getIt<IPackageManager>();

  @override
  ISavedDappsCubit get savedDappsCubit => getIt<ISavedDappsCubit>();
}
