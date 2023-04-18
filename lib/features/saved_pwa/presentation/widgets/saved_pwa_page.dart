import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/saved_pwa/application/handler/i_saved_pwa_page_handler.dart';
import 'package:dappstore/features/saved_pwa/application/i_saved_pwa_cubit.dart';
import 'package:dappstore/features/saved_pwa/application/saved_pwa_cubit.dart';
import 'package:dappstore/features/saved_pwa/presentation/widgets/saved_dapps_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SavedPwas extends StatelessWidget {
  /// Creates a saved PWA list
  late IThemeCubit themeCubit;
  late ISavedPwaPageHandler savedPwaPageHandler;
  late IThemeSpec theme;

  SavedPwas({super.key});

  @override
  Widget build(BuildContext context) {
    savedPwaPageHandler = getIt<ISavedPwaPageHandler>();
    themeCubit = savedPwaPageHandler.themeCubit;
    theme = themeCubit.theme;
    return BlocBuilder<ISavedPwaCubit, SavedPwaState>(
      bloc: savedPwaPageHandler.savedPwaCubit,
      builder: (context, state) {
        final dapps = state.savedDapps.values.toList();
        if (state.savedDapps.isEmpty) {
          return Center(
            child: Text(
              context.getLocale!.noDappsSaved,
              style: theme.secondaryWhiteTextStyle3,
            ),
          );
        } else {
          return Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      context.getLocale!.savedPwasWithNumber(dapps.length),
                      style: theme.secondaryTitleTextStyle,
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: dapps.length,
                  itemBuilder: (context, index) {
                    final dapp = dapps[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 12),
                      child: SavedDappsTile(
                        dappId: dapp.dappId,
                        name: dapp.name,
                        image: dapp.logo,
                        subtitle: dapp.subtitle,
                        theme: theme,
                        handler: savedPwaPageHandler,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
