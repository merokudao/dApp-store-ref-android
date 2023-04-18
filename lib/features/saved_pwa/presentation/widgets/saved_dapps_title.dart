import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_info/presentation/screens/dapp_info.dart';
import 'package:dappstore/features/saved_pwa/application/handler/i_saved_pwa_page_handler.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';

class SavedDappsTile extends StatelessWidget {
  final String? name;
  final String? subtitle;
  final String? image;
  final String? dappId;
  final IThemeSpec theme;
  final ISavedPwaPageHandler handler;

  const SavedDappsTile({
    super.key,
    required this.name,
    required this.subtitle,
    required this.image,
    required this.dappId,
    required this.theme,
    required this.handler,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        handler.storeCubit.setActiveDappId(dappId: dappId!);
        context.pushRoute(const DappInfoPage());
      },
      child: ListTile(
        leading: SizedBox(
          height: 48,
          width: 48,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ImageWidgetCached(
              image ?? "",
              fit: BoxFit.fill,
              height: 48,
              width: 48,
            ),
          ),
        ),
        title: Text(
          name!,
          style: theme.titleTextStyle,
        ),
        subtitle: Text(
          subtitle ?? "",
          style: theme.secondaryTextStyle2,
        ),
        trailing: TextButton(
          onPressed: () {
            handler.openPwaApp(context, dappId!);
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: theme.appGreen,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: theme.appGreen,
              ),
              borderRadius: BorderRadius.circular(36),
            ),
          ),
          child: SizedBox(
            width: 80,
            height: 28,
            child: Center(
              child: Text(
                context.getLocale!.open,
                style: theme.whiteBodyTextStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
