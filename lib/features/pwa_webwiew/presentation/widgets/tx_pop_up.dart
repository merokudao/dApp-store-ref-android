import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/wallet_connect_cubit.dart';
import 'package:dappstore/utils/icon_constants.dart';
import 'package:dappstore/widgets/bottom_sheet/dailog_tile_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TxPopup extends StatelessWidget {
  /// Creates the transaction popup shown during any transaction made in PWA screen
  final IThemeSpec theme;
  final IWalletConnectCubit walletConnectCubit;
  const TxPopup(
      {super.key, required this.theme, required this.walletConnectCubit});

  @override
  Widget build(BuildContext context) {
    return Center(
      //   child: BlocCo(
      child: BlocConsumer<IWalletConnectCubit, WalletConnectState>(
          bloc: walletConnectCubit,
          listener: (context, state) {
            if (state.txSucesess) {
              context.popRoute();
            }
          },
          builder: (context, state) {
            return DialogTileItem(
              title: context.getLocale!.approveRequest,
              subtitle: context.getLocale!.approveRequestSubtitle,
              theme: theme,
              leading: Image.asset(IconConstants.walletConnectLogo,
                  height: theme.wcIconSize),
              success: state.txSucesess,
              loading: state.txLoading,
              error: state.txFailure,
            );
          }),
    );
  }
}

class ChainNotSupportedPopup extends StatelessWidget {
  final IThemeSpec theme;
  final IWalletConnectCubit walletConnectCubit;
  const ChainNotSupportedPopup(
      {super.key, required this.theme, required this.walletConnectCubit});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DialogTileItem(
        title: context.getLocale!.ohno,
        subtitle: context.getLocale!.chainNotSupportedPopup,
        theme: theme,
        leading: Image.asset(IconConstants.walletConnectLogo,
            height: theme.wcIconSize),
        error: true,
      ),
    );
  }
}
