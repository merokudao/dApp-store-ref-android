import 'package:dappstore/core/application/i_app_handler.dart';
import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/router/custom_route_observer.dart';
import 'package:dappstore/features/dapp_store_home/presentation/screen/homepage.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dappstore/features/wallet_connect/presentation/wallet_connect_screen.dart';
import 'package:dappstore/widgets/error_widgets/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  late IAppHandler appHandler;
  late Locale localeToUse;
  @override
  void initState() {
    appHandler = getIt<IAppHandler>();
    Size size = WidgetsBinding.instance.window.physicalSize;
    appHandler.themeCubit.initialise(height: size.height, width: size.width);
    WidgetsBinding.instance.addObserver(this);

    /// To check the current brightness settings for the user and setting Dark and light theme basis of that
    /// currently we only support dark mode theme
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    if (brightness == Brightness.dark &&
        appHandler.isFollowingSystemBrightness) {
      appHandler.setDarkTheme();
      debugPrint("Switching to dark theme");
    } else if (brightness == Brightness.light &&
        appHandler.isFollowingSystemBrightness) {
      appHandler.setLightTheme();
      debugPrint("Switching to Light theme");
    }

    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    /// To actively check for mobile dark/light theme changes
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    if (brightness == Brightness.dark &&
        appHandler.isFollowingSystemBrightness) {
      appHandler.setDarkTheme();
      debugPrint("Switching to dark theme");
    } else if (brightness == Brightness.light &&
        appHandler.isFollowingSystemBrightness) {
      appHandler.setLightTheme();
      debugPrint("Switching to Light theme");
    }
    super.didChangePlatformBrightness();
  }

  MaterialColor white = const MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      500: Color(0xFFFFFFFF),
      600: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
      800: Color(0xFFFFFFFF),
      900: Color(0xFFFFFFFF),
    },
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      navigatorObservers: [
        getIt<CustomRouteObserver>(),
      ],
      debugShowCheckedModeBanner: false,
      title: "dApp Store",
      theme: ThemeData(
        primarySwatch: white,
        backgroundColor: Colors.white,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        primarySwatch: white,
        backgroundColor: Colors.black,
        useMaterial3: true,
      ),
      themeMode: appHandler.themeCubit.theme.isDarkTheme
          ? ThemeMode.dark
          : ThemeMode.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates.toList(),
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (BuildContext context, Widget? widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          debugPrint('${errorDetails.stack}');
          return CustomErrorScreen(
            details: errorDetails,
            theme: appHandler.themeCubit.theme,
          );
        };
        return widget!;
      },

      /// Checks if user is signed in or not and than redirect to the respective screen
      home: (getIt<IWalletConnectCubit>().state.connected &&
              getIt<IWalletConnectCubit>().state.signVerified)
          ? const HomePage()
          : const WalletConnectScreen(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      appHandler.reloadPackages();
      appHandler.checkUpdates();
    }
    super.didChangeAppLifecycleState(state);
  }
}
