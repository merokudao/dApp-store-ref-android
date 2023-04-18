import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TermsAndConditions extends StatelessWidget {
  final IThemeSpec theme;
  final bool insideSettings;
  const TermsAndConditions(
      {Key? key, required this.theme, this.insideSettings = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Text.rich(
          TextSpan(
            text: insideSettings ? "" : "${context.getLocale!.byContinuing} ",
            style: theme.secondaryWhiteTextStyle3,
            children: <TextSpan>[
              TextSpan(
                  text: "${context.getLocale!.privacyPolicy} ",
                  style: theme.secondaryGreenTextStyle4,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      await launchUrlString("https://slickwallet.xyz");
                    }),
              TextSpan(
                text: "${context.getLocale!.and} ",
                style: theme.secondaryWhiteTextStyle3,
                children: <TextSpan>[
                  TextSpan(
                      text: "${context.getLocale!.termAndConditions} ",
                      style: theme.secondaryGreenTextStyle4,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          await launchUrlString("https://slickwallet.xyz");
                        })
                ],
              )
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
