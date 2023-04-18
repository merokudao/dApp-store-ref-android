// ignore_for_file: use_build_context_synchronously

import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/saved_dapps/presentation/pages/saved_dapps_page.dart';
import 'package:dappstore/features/settings/presentation/widgets/address_name_tile.dart';
import 'package:dappstore/features/wallet_connect/presentation/widget/terms_and_condition.dart';
import 'package:dappstore/utils/icon_constants.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsDialog extends StatefulWidget {
  /// Create the setting dialog, with addresa bar and other options
  final IThemeSpec theme;
  const SettingsDialog({super.key, required this.theme});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  PackageInfo? package;

  @override
  void didChangeDependencies() async {
    package = await PackageInfo.fromPlatform();
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SettingsDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AddressNameTile(
            theme: widget.theme,
          ),
          const SizedBox(
            height: 12,
          ),
          Divider(
            color: widget.theme.whiteColor.withOpacity(0.08),
            height: 1,
          ),
          buildTile(
              iconAsset: IconConstants.categoryIcon,
              text: context.getLocale!.manageDapps,
              onTap: () => context.pushRoute(SavedDappsPage())),
          Divider(
            color: widget.theme.whiteColor.withOpacity(0.08),
            height: 1,
          ),
          buildTile(
              iconAsset: IconConstants.chatIcon,
              text: context.getLocale!.helpAndFeedback,
              onTap: () => {}),
          Divider(
            color: widget.theme.whiteColor.withOpacity(0.08),
            height: 1,
          ),
          const SizedBox(
            height: 30,
          ),
          TermsAndConditions(
            theme: widget.theme,
            insideSettings: true,
          ),
          Text(
            "v${package?.version ?? ''} +${package?.buildNumber ?? ''}",
            style: widget.theme.bodyTextStyle,
          ),
        ],
      ),
    );
  }

  Widget buildTile(
      {required String iconAsset,
      required String text,
      void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              iconAsset,
              height: 20,
              width: 20,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              text,
              style: widget.theme.normalTextStyle2,
            )
          ],
        ),
      ),
    );
  }
}
