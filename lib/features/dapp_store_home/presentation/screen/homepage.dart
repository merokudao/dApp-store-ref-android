// ignore_for_file: use_build_context_synchronously

import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/permissions/i_permissions_cubit.dart';
import 'package:dappstore/core/router/constants/routes.dart';
import 'package:dappstore/core/router/interface/route.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/explore_by_categories.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/explore_card.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/expolre_more_card.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/featured_dapp_infinite_scroll.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/featured_dapps_list.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/home_appbar.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/saved_dapps_card.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/top_category_list.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/update_available_card.dart';
import 'package:dappstore/features/profile/application/handler/profile_handler.dart';
import 'package:dappstore/features/self_update/application/cubit/self_update_cubit.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dappstore/utils/image_constants.dart';
import 'package:dappstore/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:dappstore/widgets/self_update_handler/update_popup_widget.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulScreen {
  /// Creates the dapp store homepage
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  @override
  String get route => Routes.home;
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late final IDappStoreHandler storeHandler;
  late final IPermissions permissions;
  bool isShowingInstallDialog = false;
  bool isShowingNotificationDialog = false;
  @override
  void initState() {
    super.initState();
    storeHandler = DappStoreHandler();
    permissions = getIt<IPermissions>();
    storeHandler.started();
    WidgetsBinding.instance.addObserver(this);

    ProfileHandler()
        .getProfile(address: getIt<IWalletConnectCubit>().state.activeAddress!);
    storeHandler.selfUpdateCubit.checkUpdate().then(
      (value) {
        bool dismissable = true;
        if (value == UpdateType.hardUpdate) {
          dismissable = false;
        }
        if (value != UpdateType.noUpdate) {
          context.showBottomSheet(
            child: UpdateWidget(
              isHardUpdate: !dismissable,
            ),
            theme: storeHandler.theme,
            dismissable: dismissable,
          );
        }
      },
    );
    getPermission();
  }

  getPermission() async {
    /// to check if user have given all the requrired permission to dappstore or not
    /// if no, then ask user to give permission before using the app
    await permissions.checkAllPermissions().then((value) =>
        showPermissions(context: context, theme: storeHandler.theme));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getIt<IPermissions>().checkAllPermissions().then((value) =>
          showPermissions(context: context, theme: storeHandler.theme));
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: storeHandler.theme.backgroundColor,
      appBar: const HomeAppbar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        addAutomaticKeepAlives: true,
        cacheExtent: 20,
        children: [
          Stack(
            children: [
              Positioned.fill(
                right: -200,
                top: -300,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: storeHandler.theme.wcBlue,
                      gradient: RadialGradient(
                        colors: [
                          storeHandler.theme.wcBlue.withOpacity(0.4),
                          storeHandler.theme.wcBlue.withOpacity(0),
                        ],
                      )),
                  height: 500,
                ),
              ),
              Column(
                children: const [
                  ExploreCard(),
                  FeaturedDappsList(),
                ],
              ),
            ],
          ),
          const SavedDappscard(),
          const ExploreBycategories(),
          const ExploreMoreCard(),
          const UpdateAvailableCard(),
          const TopCategoriesList(),
          const FeaturedDappInfiniteScroll(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(
              ImageConstants.slickLogo,
              scale: 2,
            ),
          ),
        ],
      ),
    );
  }

  showPermissions({required BuildContext context, required IThemeSpec theme}) {
    IPermissions permissions = getIt<IPermissions>();

    if (!permissions.state.isShowingNotificationDialog &&
        permissions.state.notificationPermission != PermissionStatus.granted) {
      permissions.changeShowingNotificationDialog(true);
      context.showBottomSheet(
        theme: theme,
        dismissable: false,
        child: dialog(
            theme: theme,
            title: context.getLocale!.allowAppNotification,
            body: context.getLocale!.allowAppNotificationDesc,
            onPressed: () async {
              await permissions.requestNotificationPermission();
              context.popRoute();
              permissions.changeShowingNotificationDialog(false);
            }),
      );
    }
    if (!permissions.state.isShowingInstallDialog &&
        permissions.state.appInstallation != PermissionStatus.granted) {
      permissions.changeShowingInstallDialog(true);
      context.showBottomSheet(
        theme: theme,
        dismissable: false,
        child: dialog(
            theme: theme,
            title: context.getLocale!.allowAppInstall,
            body: context.getLocale!.allowAppInstallDesc,
            onPressed: () async {
              PermissionStatus? status =
                  await permissions.requestAppInstallationPermission();
              if (status == PermissionStatus.granted) {
                context.popRoute();
                permissions.changeShowingInstallDialog(false);
              }
            }),
      );
    }
  }

  Widget dialog(
      {required String title,
      required String body,
      required void Function()? onPressed,
      required IThemeSpec theme}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: theme.biggerTitleTextStyle,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            body,
            style: theme.bodyTextStyle,
          ),
          const SizedBox(
            height: 24,
          ),
          TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                backgroundColor: theme.wcBlue,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: theme.appGreen,
                  ),
                  borderRadius: BorderRadius.circular(
                    theme.buttonRadius,
                  ),
                ),
              ),
              child: Text(context.getLocale!.goToSettings,
                  style: theme.buttonTextStyle)),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
