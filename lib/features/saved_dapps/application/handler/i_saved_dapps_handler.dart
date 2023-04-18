import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart';
import 'package:dappstore/features/saved_dapps/application/i_saved_dapps_cubit.dart';
import 'package:dappstore/features/saved_pwa/application/i_saved_pwa_cubit.dart';

abstract class ISavedDappsHandler {
  IThemeCubit get themeCubit;
  IStoreCubit get storeCubit;
  ISavedPwaCubit get savedPwaCubit;
  IPackageManager get packageManager;
  ISavedDappsCubit get savedDappsCubit;
}
