// ignore_for_file: use_build_context_synchronously

import 'package:dappstore/config/config.dart';
import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/localisation/store/i_localisation_store.dart';
import 'package:dappstore/core/router/constants/routes.dart';
import 'package:dappstore/core/router/interface/route.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/core/theme/store/i_theme_store.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/presentation/screen/homepage.dart';
import 'package:dappstore/features/profile/application/handler/i_profile_handler.dart';
import 'package:dappstore/features/profile/application/handler/profile_handler.dart';
import 'package:dappstore/features/profile/infrastructure/store/i_profile_store.dart';
import 'package:dappstore/features/self_update/application/cubit/i_self_update_cubit.dart';
import 'package:dappstore/features/self_update/application/cubit/self_update_cubit.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/wallet_connect_cubit.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/store/i_wallet_connect_store.dart';
import 'package:dappstore/features/wallet_connect/presentation/widget/terms_and_condition.dart';
import 'package:dappstore/utils/icon_constants.dart';
import 'package:dappstore/utils/image_constants.dart';
import 'package:dappstore/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:dappstore/widgets/bottom_sheet/error_bottom_sheet.dart';
import 'package:dappstore/widgets/self_update_handler/update_popup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class WalletConnectScreen extends StatefulScreen {
  /// App login screen
  const WalletConnectScreen({super.key});

  @override
  State<WalletConnectScreen> createState() => _WalletConnectScreenState();

  @override
  String get route => Routes.home;
}

class _WalletConnectScreenState extends State<WalletConnectScreen> {
  late final IThemeSpec theme;
  late final IWalletConnectCubit cubit;
  late final IWalletConnectStore wcStore;
  late final IProfileHandler profileHandler;
  late final ISelfUpdateCubit selfUpdateCubit;
  bool checkForUpdate = true;
  @override
  void initState() {
    super.initState();
    theme = getIt<IThemeCubit>().theme;
    cubit = getIt<IWalletConnectCubit>();
    wcStore = getIt<IWalletConnectStore>();
    selfUpdateCubit = getIt<ISelfUpdateCubit>();
    profileHandler = ProfileHandler();

    /// Checking dapp store self update bottom sheet will be opened
    /// if soft update or hard update is available
    if (checkForUpdate) {
      selfUpdateCubit.checkUpdate().then((value) {
        checkForUpdate = false;
        bool dismissable = true;
        if (value == UpdateType.hardUpdate) {
          dismissable = false;
          context.showBottomSheet(
              child: UpdateWidget(
                isHardUpdate: !dismissable,
              ),
              theme: theme,
              dismissable: dismissable);
        }
      });
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IWalletConnectCubit, WalletConnectState>(
        bloc: cubit,
        listenWhen: (previous, current) =>
            previous.connected != current.connected ||
            previous.signVerified != current.signVerified ||
            previous.failureConnection != current.failureConnection ||
            previous.loadingConnection != current.loadingConnection ||
            previous.loadingSign != current.loadingSign ||
            previous.failureSign != current.failureSign,
        listener: (context, state) async {
          if (state.connected && state.signVerified) {
            context.pushAndPopUntilRoot(const HomePage());
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: theme.backgroundColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Expanded(
                  child: Image.asset(ImageConstants.slickLogo),
                ),
                const SizedBox(
                  height: 60,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        context.getLocale!.signUpTo,
                        style: theme.headingTextStyle,
                      ),
                      Text(
                        context.getLocale!.welcomeToSlick,
                        style: theme.bodyTextStyle,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 44,
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(horizontal: 33),
                        child: TextButton(
                          onPressed: () {
                            context.showBottomSheet(
                                theme: theme, child: dialog());
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: theme.wcBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(theme.buttonRadius),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(IconConstants.walletConnectLogo,
                                  height: theme.wcIconSize),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                context.getLocale!.useWalletConnect,
                                style: theme.buttonTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  child: TermsAndConditions(
                    theme: theme,
                  ),
                )
              ],
            ),
          );
        });
  }

  dialog() {
    return BlocConsumer<IWalletConnectCubit, WalletConnectState>(
        bloc: cubit,
        buildWhen: (previous, current) =>
            previous.connected != current.connected ||
            previous.signVerified != current.signVerified ||
            previous.failureConnection != current.failureConnection ||
            previous.loadingConnection != current.loadingConnection ||
            previous.loadingSign != current.loadingSign ||
            previous.failureSign != current.failureSign,
        listenWhen: (previous, current) =>
            previous.connected != current.connected ||
            previous.signVerified != current.signVerified ||
            previous.failureConnection != current.failureConnection ||
            previous.loadingConnection != current.loadingConnection ||
            previous.loadingSign != current.loadingSign ||
            previous.failureSign != current.failureSign,
        listener: (context, state) async {
          /// Listening to state changes if wallet is conected and login message is not signed by the user
          /// if so it will automatically send the [getLoginEthSign]
          if (state.connected &&
              !state.signVerified &&
              !state.loadingSign &&
              !state.failureSign) {
            await Future.delayed(const Duration(seconds: 1), () async {
              final message =
                  cubit.getMessageToSign(WalletConnectConfig.signMessageData);
              cubit.getLoginEthSign(message);
            });
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  context.getLocale!.youWillReceivetwo,
                  style: theme.titleTextStyle.copyWith(fontSize: 14.0),
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _DialogTileItem(
                        leading: '1',
                        title: context.getLocale!.connectWallet,
                        subtitle:
                            context.getLocale!.connectUsignAnyWalletConnect,
                        theme: theme,
                        loading: state.loadingConnection,
                        success: state.connected,
                        error: state.failureConnection,
                      ),
                    ),
                    if (state.connected)
                      InkWell(
                          onTap: () async {
                            await getIt<IWalletConnectCubit>().disconnectAll();
                            await getIt<IProfileStore>().clearBox();
                            await getIt<ILocalisationStore>().clearBox();
                            await getIt<IThemeStore>().clearBox();
                            context.popRoute();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.close,
                              color: theme.buttonRed,
                            ),
                          )),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: _DialogTileItem(
                  leading: '2',
                  title: context.getLocale!.signMessage,
                  subtitle: context.getLocale!.confirmThatYouAreOwner,
                  theme: theme,
                  loading: state.loadingSign,
                  success: state.signVerified,
                  error: state.failureSign,
                ),
              ),
              if (state.loadingSign)
                Container(
                    width: double.maxFinite,
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(theme.buttonRadius),
                        color: theme.cardGrey),
                    child: Text(
                      "${context.getLocale!.goBackToWallet} ",
                      style: theme.normalTextStyle,
                      textAlign: TextAlign.center,
                    )),
              if (!state.loadingSign &&
                  (!state.connected ||
                      state.failureSign ||
                      state.failureConnection ||
                      !state.signVerified))
                TextButton(
                  onPressed: () async {
                    /// Handles the sendig walletConnect request and sign login message request
                    bool internet =
                        await InternetConnectionChecker().hasConnection;
                    if (internet) {
                      if (!state.connected || state.failureConnection) {
                        cubit.getConnectRequest(
                            WalletConnectConfig.connectingChain);
                      } else {
                        final message = cubit.getMessageToSign(
                          WalletConnectConfig.signMessageData,
                        );
                        cubit.getLoginEthSign(message);
                      }
                    } else {
                      context.showErrorSheet(
                          title: context.getLocale!.networkIssue,
                          subtitle: context.getLocale!.checkNetwork,
                          theme: theme);
                    }
                  },
                  child: Text(
                    context.getLocale!.sendRequest,
                    style: theme.buttonTextStyle,
                  ),
                ),
            ],
          );
        });
  }

// not used
  showBottom() {
    return showModalBottomSheet(
        context: context,
        elevation: 12,
        backgroundColor: theme.backgroundCardColor,
        barrierColor: theme.backgroundCardColor.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(theme.cardRadius),
        ),
        builder: ((context) {
          return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Text(
                    context.getLocale!.connectWallet,
                    style: theme.headingTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ]);
        }));
  }
}

class _DialogTileItem extends StatelessWidget {
  final String leading;
  final String title;
  final String subtitle;
  final bool loading;
  final bool success;
  final bool error;
  final IThemeSpec theme;
  const _DialogTileItem({
    Key? key,
    required this.leading,
    required this.title,
    required this.subtitle,
    this.loading = false,
    this.success = false,
    this.error = false,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50.0,
            width: 50.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.backgroundColor,
            ),
            child: loading
                ? SizedBox(
                    height: 18.0,
                    width: 18.0,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: theme.whiteColor,
                        strokeWidth: 2.5,
                      ),
                    ),
                  )
                : success
                    ? Icon(
                        Icons.check_rounded,
                        size: 24.0,
                        color: theme.appGreen,
                      )
                    : error
                        ? Icon(
                            Icons.close_rounded,
                            size: 24.0,
                            color: theme.errorRed,
                          )
                        : Text(
                            leading,
                            style: theme.buttonTextStyle.copyWith(
                              fontSize: 24.0,
                            ),
                          ),
          ),
          const SizedBox(width: 24.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.buttonTextStyle.copyWith(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  subtitle,
                  style: theme.bodyTextStyle.copyWith(
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
