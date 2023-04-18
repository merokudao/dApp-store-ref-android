import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final IThemeSpec theme;
  final String btnLabel;
  final String message;
  final VoidCallback? onRefresh;
  const ErrorView({
    Key? key,
    required this.theme,
    this.btnLabel = 'Refresh',
    this.message = 'Something went wrong!',
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          message,
          textAlign: TextAlign.center,
          style: theme.normalTextStyle.copyWith(fontSize: 16.0),
        ),
        const SizedBox(height: 8.0),
        TextButton(
          onPressed: onRefresh,
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
              side: BorderSide(
                color: theme.blue,
              ),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
            foregroundColor: theme.blue.withOpacity(0.9),
            backgroundColor: Colors.transparent,
            textStyle: theme.normalTextStyle.copyWith(
              fontSize: 15.0,
              letterSpacing: 0.5,
            ),
          ),
          child: Text(btnLabel),
        ),
      ],
    );
  }
}
