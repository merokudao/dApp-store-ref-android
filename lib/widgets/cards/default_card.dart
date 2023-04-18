import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:flutter/material.dart';

class DefaultCard extends StatelessWidget {
  /// A basic card wrapper with  preferred [theme]
  final IThemeSpec theme;
  final Widget child;
  const DefaultCard({super.key, required this.theme, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: theme.cardShape,
      color: theme.cardColor,
      child: child,
    );
  }
}
