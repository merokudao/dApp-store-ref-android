import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/widgets/white_gradient_line.dart';
import 'package:flutter/material.dart';

extension BottomSheet on BuildContext {
  /// A [BuildContext] extension to open bottom sheet from anywhere in the app

  showBottomSheet({
    required IThemeSpec theme,
    required Widget child,
    bool dismissable = true,
    String? routeName,
    Function? callback,
  }) {
    showModalBottomSheet(
      clipBehavior: Clip.antiAlias, // or hardEdge must
      backgroundColor: Colors.transparent,
      context: this,
      elevation: 10,
      isDismissible: dismissable,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(80),
        ),
      ),
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return dismissable;
          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(this).viewInsets.bottom,
              ),
              color: Colors.transparent,
              margin: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    clipBehavior: Clip.hardEdge,
                    shape: theme.sheetCardShape,
                    color: theme.sheetBackgroundColor,
                    child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 2.0),
                              child: WhiteGradientLine(),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 28.0),
                              child: Container(
                                width: 88,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: theme.ratingGrey,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            child,
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).whenComplete(() {
      callback?.call();
    });
  }
}
