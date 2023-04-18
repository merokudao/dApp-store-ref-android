import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/utils/image_constants.dart';
import 'package:dappstore/widgets/error_widgets/error_view.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CustomErrorScreen extends StatefulWidget {
  /// Default error screen of the app
  /// user shoudl be redirected here if an error occurs at any stage
  /// [details] and [theme] are required
  final FlutterErrorDetails details;
  final IThemeSpec theme;
  const CustomErrorScreen({
    Key? key,
    required this.details,
    required this.theme,
  }) : super(key: key);

  @override
  State<CustomErrorScreen> createState() => _CustomErrorScreenState();
}

class _CustomErrorScreenState extends State<CustomErrorScreen> {
  bool networkIssue = false;
  @override
  void initState() {
    InternetConnectionChecker().hasConnection.then((value) {
      setState(() {
        networkIssue = !value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Image.asset(
                networkIssue
                    ? ImageConstants.networkError
                    : ImageConstants.errorCactus,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.6,
              ),
            ),
            Text(
              (networkIssue
                  ? context.getLocale!.networkIssue
                  : kDebugMode
                      ? widget.details.summary.toString()
                      : context.getLocale!.oopsSomethingWentWrong),
              textAlign: TextAlign.center,
              style: widget.theme.titleTextStyle,
            ),
            ErrorView(
              theme: widget.theme,
              btnLabel: context.getLocale!.goBack,
              message: networkIssue
                  ? context.getLocale!.checkNetwork
                  : context.getLocale!.notifiedEngineers,
              onRefresh: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Phoenix.rebirth(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
