// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dappstore/core/application/app_handler.dart' as _i7;
import 'package:dappstore/core/application/i_app_handler.dart' as _i6;
import 'package:dappstore/core/error/error_logger.dart' as _i15;
import 'package:dappstore/core/error/i_error_logger.dart' as _i14;
import 'package:dappstore/core/installed_apps/i_installed_apps_cubit.dart'
    as _i16;
import 'package:dappstore/core/installed_apps/installed_apps_cubit.dart'
    as _i17;
import 'package:dappstore/core/localisation/i_localisation_cubit.dart' as _i56;
import 'package:dappstore/core/localisation/localisation_cubit.dart' as _i57;
import 'package:dappstore/core/localisation/store/i_localisation_store.dart'
    as _i22;
import 'package:dappstore/core/localisation/store/localisation_store.dart'
    as _i23;
import 'package:dappstore/core/permissions/i_permissions_cubit.dart' as _i24;
import 'package:dappstore/core/permissions/permissions_cubit.dart' as _i25;
import 'package:dappstore/core/platform_channel/i_platform_channel_cubit.dart'
    as _i26;
import 'package:dappstore/core/platform_channel/platform_channel_cubit.dart'
    as _i27;
import 'package:dappstore/core/router/custom_route_observer.dart' as _i3;
import 'package:dappstore/core/store/cache_store.dart' as _i9;
import 'package:dappstore/core/store/i_cache_store.dart' as _i8;
import 'package:dappstore/core/theme/i_theme_cubit.dart' as _i68;
import 'package:dappstore/core/theme/store/i_theme_store.dart' as _i46;
import 'package:dappstore/core/theme/store/theme_store.dart' as _i47;
import 'package:dappstore/core/theme/theme_cubit.dart' as _i69;
import 'package:dappstore/features/analytics/handler/analytics_handler.dart'
    as _i51;
import 'package:dappstore/features/analytics/handler/i_analytics_handler.dart'
    as _i50;
import 'package:dappstore/features/dapp_info/application/handler/dapp_title_tile_handler.dart'
    as _i13;
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_title_tile_handler.dart'
    as _i12;
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart'
    as _i44;
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart'
    as _i45;
import 'package:dappstore/features/dapp_store_home/domain/repositories/i_dapp_list_repository.dart'
    as _i10;
import 'package:dappstore/features/dapp_store_home/infrastructure/repositories/dapp_list_repository_impl.dart'
    as _i11;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/downloader/downloader_cubit.dart'
    as _i53;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/downloader/i_downloader_cubit.dart'
    as _i52;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/foreground_service/foreground_service_cubit.dart'
    as _i55;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/foreground_service/i_foreground_service_cubit.dart'
    as _i54;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/installer/i_installer_cubit.dart'
    as _i20;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/installer/installer_cubit.dart'
    as _i21;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/i_package_manager.dart'
    as _i58;
import 'package:dappstore/features/download_and_installer/infrastructure/repositories/package_manager.dart/package_manager_cubit.dart'
    as _i59;
import 'package:dappstore/features/profile/application/cubit/i_profile_cubit.dart'
    as _i74;
import 'package:dappstore/features/profile/application/cubit/profile_cubit.dart'
    as _i75;
import 'package:dappstore/features/profile/infrastructure/repositories/i_profile_repository.dart'
    as _i60;
import 'package:dappstore/features/profile/infrastructure/repositories/profile_repository.dart'
    as _i61;
import 'package:dappstore/features/profile/infrastructure/store/i_profile_store.dart'
    as _i28;
import 'package:dappstore/features/profile/infrastructure/store/profile_store.dart'
    as _i29;
import 'package:dappstore/features/pwa_webwiew/application/handler/i_pwa_webview_handler.dart'
    as _i32;
import 'package:dappstore/features/pwa_webwiew/application/handler/pwa_webview_handler.dart'
    as _i33;
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/i_injected_web3_cubit.dart'
    as _i72;
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit.dart'
    as _i73;
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/i_pwa_webview_cubit.dart'
    as _i30;
import 'package:dappstore/features/pwa_webwiew/application/pwa_webview_cubit/pwa_webview_cubit.dart'
    as _i31;
import 'package:dappstore/features/saved_dapps/application/handler/i_saved_dapps_handler.dart'
    as _i34;
import 'package:dappstore/features/saved_dapps/application/handler/saved_dapps_handler.dart'
    as _i35;
import 'package:dappstore/features/saved_dapps/application/i_saved_dapps_cubit.dart'
    as _i62;
import 'package:dappstore/features/saved_dapps/application/saved_dapps_cubit.dart'
    as _i63;
import 'package:dappstore/features/saved_pwa/application/handler/i_saved_pwa_page_handler.dart'
    as _i36;
import 'package:dappstore/features/saved_pwa/application/handler/saved_pwa_page_handler.dart'
    as _i37;
import 'package:dappstore/features/saved_pwa/application/i_saved_pwa_cubit.dart'
    as _i64;
import 'package:dappstore/features/saved_pwa/application/saved_pwa_cubit.dart'
    as _i65;
import 'package:dappstore/features/saved_pwa/infrastructure/store/i_saved_pwa_store.dart'
    as _i38;
import 'package:dappstore/features/saved_pwa/infrastructure/store/saved_pwa_store.dart'
    as _i39;
import 'package:dappstore/features/self_update/application/cubit/i_self_update_cubit.dart'
    as _i66;
import 'package:dappstore/features/self_update/application/cubit/self_update_cubit.dart'
    as _i67;
import 'package:dappstore/features/self_update/application/handler/i_self_update_handler.dart'
    as _i40;
import 'package:dappstore/features/self_update/application/handler/self_update_handler.dart'
    as _i41;
import 'package:dappstore/features/self_update/infrastructure/repositories/i_self_update_repository.dart'
    as _i42;
import 'package:dappstore/features/self_update/infrastructure/repositories/self_update_repository.dart'
    as _i43;
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart'
    as _i70;
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/wallet_connect_cubit.dart'
    as _i71;
import 'package:dappstore/features/wallet_connect/infrastructure/store/i_wallet_connect_store.dart'
    as _i48;
import 'package:dappstore/features/wallet_connect/infrastructure/store/wallet_connect_store.dart'
    as _i49;
import 'package:dappstore/widgets/buttons/app_button_handler/app_button_handler.dart'
    as _i5;
import 'package:dappstore/widgets/buttons/app_button_handler/i_app_button_handler.dart'
    as _i4;
import 'package:dappstore/widgets/installed_dapps_tiles/i_installed_dapps_tile_handler.dart'
    as _i18;
import 'package:dappstore/widgets/installed_dapps_tiles/installed_dapps_tile_handler.dart'
    as _i19;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.CustomRouteObserver>(() => _i3.CustomRouteObserver());
  gh.lazySingleton<_i4.IAppButtonHandler>(() => _i5.AppButtonHandler());
  gh.lazySingleton<_i6.IAppHandler>(() => _i7.AppHandler());
  gh.lazySingleton<_i8.ICacheStore>(() => _i9.CacheStore());
  gh.lazySingleton<_i10.IDappListRepo>(
      () => _i11.DappListRepoImpl(cacheStore: gh<_i8.ICacheStore>()));
  gh.lazySingleton<_i12.IDappTitleTileHandler>(
      () => _i13.DappTitleTileHandler());
  gh.lazySingleton<_i14.IErrorLogger>(() => _i15.ErrorLogger());
  gh.lazySingleton<_i16.IInstalledAppsCubit>(() => _i17.InstalledAppsCubit());
  gh.lazySingleton<_i18.IInstalledDappsTileHandler>(
      () => _i19.InstalledDappsTileHandler());
  gh.lazySingleton<_i20.IInstallerCubit>(() => _i21.InstallerCubit());
  gh.lazySingleton<_i22.ILocalisationStore>(() => _i23.LocalisationStore());
  gh.lazySingleton<_i24.IPermissions>(() => _i25.Permissions());
  gh.lazySingleton<_i26.IPlatformChannelCubit>(
      () => _i27.PlatformChannelCubit());
  gh.lazySingleton<_i28.IProfileStore>(
      () => _i29.ProfileStore(errorLogger: gh<_i14.IErrorLogger>()));
  gh.lazySingleton<_i30.IPwaWebviewCubit>(() => _i31.PwaWebviewCubit());
  gh.lazySingleton<_i32.IPwaWebviewHandler>(() => _i33.PwaWebviewHandler());
  gh.lazySingleton<_i34.ISavedDappsHandler>(() => _i35.SavedDappsHandler());
  gh.lazySingleton<_i36.ISavedPwaPageHandler>(() => _i37.SavedPwaPageHandler());
  gh.lazySingleton<_i38.ISavedPwaStore>(
      () => _i39.SavedPwaStore(errorLogger: gh<_i14.IErrorLogger>()));
  gh.lazySingleton<_i40.ISelfUpdateHandler>(() => _i41.SelfUpdateHandler());
  gh.lazySingleton<_i42.ISelfUpdateRepo>(() => _i43.SelfUpdateRepoImpl(
        cacheStore: gh<_i8.ICacheStore>(),
        errorLogger: gh<_i14.IErrorLogger>(),
      ));
  gh.lazySingleton<_i44.IStoreCubit>(
      () => _i45.StoreCubit(dappListRepo: gh<_i10.IDappListRepo>()));
  gh.lazySingleton<_i46.IThemeStore>(() => _i47.ThemeStore());
  gh.lazySingleton<_i48.IWalletConnectStore>(
      () => _i49.WalletConnectStore(errorLogger: gh<_i14.IErrorLogger>()));
  gh.lazySingleton<_i50.IAnalyticsHandler>(
      () => _i51.AnalyticsHandler(cacheStore: gh<_i8.ICacheStore>()));
  gh.lazySingleton<_i52.IDownloader>(() => _i53.DownloaderCubit(
        permissionsCubit: gh<_i24.IPermissions>(),
        installerCubit: gh<_i20.IInstallerCubit>(),
      ));
  gh.lazySingleton<_i54.IForegroundService>(() => _i55.ForegroundService(
      platformChannelCubit: gh<_i26.IPlatformChannelCubit>()));
  gh.lazySingleton<_i56.ILocaleCubit>(
      () => _i57.LocaleCubit(localisationStore: gh<_i22.ILocalisationStore>()));
  gh.lazySingleton<_i58.IPackageManager>(() => _i59.PackageManager(
        installer: gh<_i20.IInstallerCubit>(),
        downloader: gh<_i52.IDownloader>(),
        foregroundService: gh<_i54.IForegroundService>(),
        installedApps: gh<_i16.IInstalledAppsCubit>(),
        analyticsHandler: gh<_i50.IAnalyticsHandler>(),
        storeCubit: gh<_i44.IStoreCubit>(),
      ));
  gh.lazySingleton<_i60.IProfileRepo>(() => _i61.ProfileRepoImpl(
        profileStore: gh<_i28.IProfileStore>(),
        cacheStore: gh<_i8.ICacheStore>(),
      ));
  gh.lazySingleton<_i62.ISavedDappsCubit>(() => _i63.SavedDappsCubit(
        packageManager: gh<_i58.IPackageManager>(),
        storeCubit: gh<_i44.IStoreCubit>(),
        installerCubit: gh<_i20.IInstallerCubit>(),
      ));
  gh.lazySingleton<_i64.ISavedPwaCubit>(
      () => _i65.SavedPwaCubit(savedPwaStore: gh<_i38.ISavedPwaStore>()));
  gh.lazySingleton<_i66.ISelfUpdateCubit>(() => _i67.SelfUpdateCubit(
        errorLogger: gh<_i14.IErrorLogger>(),
        selfUpdateRepo: gh<_i42.ISelfUpdateRepo>(),
        installedAppsCubit: gh<_i16.IInstalledAppsCubit>(),
      ));
  gh.lazySingleton<_i68.IThemeCubit>(
      () => _i69.ThemeCubit(themeStore: gh<_i46.IThemeStore>()));
  gh.lazySingleton<_i70.IWalletConnectCubit>(() => _i71.WalletConnectCubit(
        errorLogger: gh<_i14.IErrorLogger>(),
        wcStore: gh<_i48.IWalletConnectStore>(),
      ));
  gh.lazySingleton<_i72.IInjectedWeb3Cubit>(() => _i73.InjectedWeb3Cubit(
        signer: gh<_i70.IWalletConnectCubit>(),
        errorLogger: gh<_i14.IErrorLogger>(),
      ));
  gh.lazySingleton<_i74.IProfileCubit>(() => _i75.ProfileCubit(
        errorLogger: gh<_i14.IErrorLogger>(),
        profileRepo: gh<_i60.IProfileRepo>(),
      ));
  return getIt;
}
