import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/features/dapp_info/presentation/screens/dapp_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/saved_dapps/application/handler/i_saved_dapps_handler.dart';
import 'package:dappstore/features/saved_dapps/application/i_saved_dapps_cubit.dart';
import 'package:dappstore/features/saved_dapps/application/saved_dapps_cubit.dart';
import 'package:dappstore/widgets/installed_dapps_tiles/installed_dapps_tile.dart';

class InstalledDappsList extends StatefulWidget {
  final ISavedDappsHandler handler;

  // ignore: prefer_const_constructors_in_immutables
  InstalledDappsList({
    Key? key,
    required this.handler,
  }) : super(key: key);

  @override
  State<InstalledDappsList> createState() => _InstalledDappsListState();
}

class _InstalledDappsListState extends State<InstalledDappsList> {
  @override
  Widget build(BuildContext context) {
    IThemeSpec theme = widget.handler.themeCubit.theme;
    return BlocBuilder<ISavedDappsCubit, SavedDappsState>(
        bloc: widget.handler.savedDappsCubit,
        builder: (context, state) {
          List<DappInfo> dappsList = [...state.needUpdate!, ...state.noUpdate!];
          if (dappsList.isEmpty) {
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
                        context.getLocale!
                            .installedDappWithNumber(dappsList.length),
                        style: theme.secondaryTitleTextStyle,
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: dappsList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 2,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              widget.handler.storeCubit.setActiveDappId(
                                  dappId: dappsList[index].dappId!);
                              context.pushRoute(const DappInfoPage());
                            },
                            child: InstalledDappsTile(
                              dappInfo: dappsList[index],
                              theme: theme,
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          }
        });
  }
}
