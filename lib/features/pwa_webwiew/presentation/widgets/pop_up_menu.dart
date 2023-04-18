import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/pwa_webwiew/presentation/widgets/pwa_webview_app_bar.dart';
import 'package:flutter/material.dart';

class PwaWebViewPopupMenu extends StatelessWidget {
  /// Creates menu items for PWA screen
  NavigationCallback forward;
  NavigationCallback backwards;
  NavigationCallback reload;
  NavigationCallback clearCache;
  IThemeSpec theme;
  PwaWebViewPopupMenu({
    Key? key,
    required this.forward,
    required this.backwards,
    required this.reload,
    required this.clearCache,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
        switch (value) {
          case "/back":
            {
              backwards();
              break;
            }
          case "/forward":
            {
              forward();
              break;
            }

          case "/clearCache":
            {
              clearCache();
              reload();
              break;
            }
        }
      },
      color: theme.whiteColor,
      position: PopupMenuPosition.over,
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            theme.buttonRadius,
          ),
        ),
      ),
      icon: Icon(
        Icons.menu,
        color: theme.whiteColor,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: '/back',
            child: Row(
              children: const [
                Icon(Icons.arrow_back_ios_new_sharp),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("Back"),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: '/forward',
            child: Row(
              children: const [
                Icon(Icons.arrow_forward_ios_sharp),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("Forward"),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: '/clearCache',
            child: Row(
              children: const [
                Icon(Icons.clear_all_outlined),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("Clear cache"),
                ),
              ],
            ),
          ),
        ];
      },
    );
  }
}
