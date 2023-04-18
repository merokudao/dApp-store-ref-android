import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:flutter/material.dart';

class WhiteGradientLine extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a White Gradient Line that is used in dialogs and all appbar.

  const WhiteGradientLine({super.key});

  @override
  Widget build(BuildContext context) {
    IThemeSpec theme = getIt<IThemeCubit>().theme;
    return Container(
      width: double.maxFinite,
      height: 1,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        theme.black,
        theme.whiteColor,
        theme.black,
      ])),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(2.0);
}
