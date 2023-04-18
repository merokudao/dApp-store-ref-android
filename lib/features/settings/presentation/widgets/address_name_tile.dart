// ignore_for_file: use_build_context_synchronously

import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/localisation/store/i_localisation_store.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/core/theme/store/i_theme_store.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/profile/application/cubit/i_profile_cubit.dart';
import 'package:dappstore/features/profile/application/cubit/profile_cubit.dart';
import 'package:dappstore/features/profile/infrastructure/store/i_profile_store.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dappstore/features/wallet_connect/presentation/wallet_connect_screen.dart';
import 'package:dappstore/utils/address_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_avatar/random_avatar.dart';

class AddressNameTile extends StatelessWidget {
  /// Creates a tile with user avatar, user name and logout button

  final IThemeSpec theme;
  const AddressNameTile({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        randomAvatar(
            getIt<IWalletConnectCubit>().getActiveAdddress().toString(),
            height: 50,
            width: 50),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<IProfileCubit, ProfileState>(
                bloc: getIt<IProfileCubit>(),
                builder: (context, state) {
                  return Text(
                    state.name ?? "",
                    style: theme.secondaryTitleTextStyle,
                  );
                }),
            const SizedBox(
              height: 8,
            ),
            Text(
              AddressUtil.getClippedAddress(
                  getIt<IWalletConnectCubit>().getActiveAdddress().toString()),
              style: theme.bodyTextStyle,
            ),
          ],
        ),
        const Expanded(child: SizedBox()),
        TextButton(
            onPressed: () async {
              await getIt<IWalletConnectCubit>().disconnectAll();
              await getIt<IProfileStore>().clearBox();
              await getIt<ILocalisationStore>().clearBox();
              await getIt<IThemeStore>().clearBox();

              context.popRoute();
              context.replaceRoute(const WalletConnectScreen());
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: theme.buttonRed,
                ),
                borderRadius: BorderRadius.circular(
                  theme.buttonRadius,
                ),
              ),
            ),
            child: Text(
              context.getLocale!.logout,
              style: theme.redButtonText,
            )),
      ],
    );
  }
}
