import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/settings/presentation/settings_dialog.dart';
import 'package:dappstore/utils/image_constants.dart';
import 'package:dappstore/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:dappstore/widgets/buttons/search_button/search_button.dart';
import 'package:dappstore/widgets/white_gradient_line.dart';
import 'package:flutter/material.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    IDappStoreHandler handler = DappStoreHandler();
    return AppBar(
      backgroundColor: handler.theme.appBarBackgroundColor,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Image.asset(
          ImageConstants.slickLogo,
        ),
      ),
      // title: TextField(),
      actions: [
        SearchButton(),
        IconButton(
            onPressed: () {
              context.showBottomSheet(
                  theme: handler.theme,
                  child: SettingsDialog(
                    theme: handler.theme,
                  ));
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            )),
      ],
      bottom: const WhiteGradientLine(),
    );
  }

  @override
  final Size preferredSize = const Size.fromHeight(52.0);
}
