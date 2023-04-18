import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/widgets/buttons/customizable_app_button.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';

class InstalledDappsTile extends StatelessWidget {
  /// Creates a Installed Dapp Tile with
  /// [openButton], [installButton] , [updateButton] and [installingButton] buttons
  /// [dappInfo] and [theme] are required and not-null

  final DappInfo dappInfo;
  final IThemeSpec theme;

  const InstalledDappsTile({
    Key? key,
    required this.dappInfo,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leading = SizedBox(
      height: 42,
      width: 42,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: ImageWidgetCached(
          dappInfo.images?.logo! ?? "",
          fit: BoxFit.fill,
          height: 42,
          width: 42,
        ),
      ),
    );
    final title = Text(
      dappInfo.name!,
      style: theme.titleTextStyle,
    );
    final subtitle = Text(
      "${dappInfo.developer?.legalName} · ${dappInfo.category}",
      style: theme.bodyTextStyle,
    );
    final updateButton = Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.rectangle,
        border: Border.all(
          color: theme.appGreen,
        ),
        borderRadius: BorderRadius.circular(36),
      ),
      child: SizedBox(
        width: 80,
        height: 28,
        child: Center(
          child: Text(
            context.getLocale!.update,
            style: theme.whiteBodyTextStyle,
          ),
        ),
      ),
    );
    final openButton = Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.rectangle,
        border: Border.all(
          color: theme.blue,
        ),
        borderRadius: BorderRadius.circular(36),
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
    );

    final installButton = Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.rectangle,
        border: Border.all(
          color: theme.blue,
        ),
        borderRadius: BorderRadius.circular(36),
      ),
      child: SizedBox(
        width: 80,
        height: 28,
        child: Center(
          child: Text(
            context.getLocale!.install,
            style: theme.whiteBodyTextStyle,
          ),
        ),
      ),
    );

    final installingButton = Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.rectangle,
        border: Border.all(
          color: theme.greyBlue,
        ),
        borderRadius: BorderRadius.circular(36),
      ),
      child: SizedBox(
        width: 80,
        height: 28,
        child: Center(
          child: Text(
            context.getLocale!.installing,
            style: theme.whiteBodyTextStyle,
          ),
        ),
      ),
    );

    return ListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: CustomizableAppButton(
        dappInfo: dappInfo,
        theme: theme,
        updateWidget: updateButton,
        openWidget: openButton,
        installWidget: installButton,
        installingWidget: installingButton,
      ),
    );
  }
}
