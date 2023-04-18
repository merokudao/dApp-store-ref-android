import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:dappstore/widgets/bottom_sheet/dailog_tile_item.dart';
import 'package:flutter/material.dart';

extension ErrorPopup on BuildContext {
  /// A [BuildContext] extension to open error bottom sheet from anywhere in the app
  showErrorSheet({
    required IThemeSpec theme,
    required String title,
    required String subtitle,
  }) {
    this.showBottomSheet(
      theme: theme,
      child: Center(
        child: DialogTileItem(
          title: title,
          subtitle: subtitle,
          theme: theme,
          error: true,
        ),
      ),
    );
  }
}
