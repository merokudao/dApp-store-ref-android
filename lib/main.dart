import 'package:dappstore/config/config.dart';
import 'package:dappstore/core/application/app.dart';
import 'package:dappstore/core/application/init/init.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  /// You only need to call this method if you need the binding to be
  /// initialized before calling [runApp].
  WidgetsFlutterBinding.ensureInitialized();

  /// To initialise all the app level stores, cubit and logger before the app is launched
  /// Android native splash screen is shown until the app is initialised
  /// to improve take a deeper dive into [initialise]
  await initialise();

  /// To configure the Sentry for error logging
  /// you can use any other error logger here as per the need
  /// just dont forgot to add that to [ErrorLogger]
  await SentryFlutter.init(
    (options) {
      options.dsn = Config.sentryDSN;
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production
      options.sendDefaultPii = false;
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const App()),
  );
}
