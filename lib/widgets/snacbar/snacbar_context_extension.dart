import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:flutter/material.dart';

extension LocaleExtension on BuildContext {
  /// creates and show a error snackBar
  /// [message] and [theme] should be non-null
  showErrorBar(String message, IThemeSpec theme) {
    final snackBar = SnackBar(
      backgroundColor: theme.errorRed,
      content: Text(message),
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }

  /// creates and show a normal snackBar
  /// [message] should be non-null

  showMsgBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
