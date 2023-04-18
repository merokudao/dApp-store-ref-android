import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/constants/routes.dart';
import 'package:dappstore/core/router/interface/route.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/in_screen_appbar.dart';
import 'package:dappstore/features/saved_dapps/application/handler/i_saved_dapps_handler.dart';
import 'package:dappstore/features/saved_dapps/presentation/widgets/installed_dapps_list.dart';
import 'package:dappstore/features/saved_pwa/presentation/widgets/saved_pwa_page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SavedDappsPage extends StatefulScreen {
  /// Creates a tab view for installed dapps and saved PWA
  int selectedTab;
  SavedDappsPage({
    super.key,
    this.selectedTab = 0,
  });

  @override
  State<SavedDappsPage> createState() => _SavedDappsPageState();

  @override
  String get route => Routes.savedDappsPage;
}

class _SavedDappsPageState extends State<SavedDappsPage>
    with TickerProviderStateMixin {
  late ISavedDappsHandler handler;
  late IThemeCubit themeCubit;
  late IThemeSpec theme;
  late TabController tabController;
  int index = 0;

  @override
  void initState() {
    index = widget.selectedTab;
    handler = getIt<ISavedDappsHandler>();
    themeCubit = getIt<IThemeCubit>();
    theme = themeCubit.theme;
    tabController = TabController(
      initialIndex: widget.selectedTab,
      length: 2,
      vsync: this,
    );
    tabController.addListener(() {
      setState(() {
        index = tabController.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tabWidth = MediaQuery.of(context).size.width * 0.46;
    const double height = 34;
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: InScreenAppBar(
        themeSpec: theme,
        title: context.getLocale!.manageDapps,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: theme.tabGrey,
              ),
              child: SizedBox(
                height: height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    tabController.index == 0
                        ? Container(
                            width: tabWidth,
                            height: height,
                            decoration: BoxDecoration(
                              color: theme.whiteColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                context.getLocale!.installedDapps,
                                style: theme.titleTextStyle.copyWith(
                                  color: theme.black,
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () => tabController.animateTo(0),
                            child: SizedBox(
                              width: tabWidth,
                              height: height,
                              child: Center(
                                child: SizedBox(
                                  child: Text(
                                    context.getLocale!.installedDapps,
                                    style: theme.titleTextStyle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    tabController.index == 1
                        ? Container(
                            decoration: BoxDecoration(
                              color: theme.whiteColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: SizedBox(
                              width: tabWidth,
                              height: height,
                              child: Center(
                                child: Text(
                                  context.getLocale!.pwas,
                                  style: theme.titleTextStyle.copyWith(
                                    color: theme.black,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () => tabController.animateTo(1),
                            child: SizedBox(
                              width: tabWidth,
                              height: height,
                              child: Center(
                                child: Text(
                                  context.getLocale!.pwas,
                                  style: theme.titleTextStyle,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                InstalledDappsList(handler: handler),
                SavedPwas(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
