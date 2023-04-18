import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/saved_dapps/presentation/pages/saved_dapps_page.dart';
import 'package:dappstore/features/saved_pwa/application/handler/i_saved_pwa_page_handler.dart';
import 'package:dappstore/features/saved_pwa/application/i_saved_pwa_cubit.dart';
import 'package:dappstore/features/saved_pwa/application/saved_pwa_cubit.dart';
import 'package:dappstore/utils/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedDappscard extends StatelessWidget {
  /// Creates a simple card that shoes number of saved PWa to user
  /// and redirects user to [SavedDappsPage]
  const SavedDappscard({super.key});

  @override
  Widget build(BuildContext context) {
    IDappStoreHandler handler = DappStoreHandler();
    var savedPwaPageHandler = getIt<ISavedPwaPageHandler>();
    return BlocBuilder<ISavedPwaCubit, SavedPwaState>(
        bloc: savedPwaPageHandler.savedPwaCubit,
        builder: (context, state) {
          if (state.savedDapps.values.isNotEmpty) {
            return Container(
              margin: const EdgeInsets.all(16),
              child: InkWell(
                onTap: () {
                  context.pushRoute(SavedDappsPage(
                    selectedTab: 1,
                  ));
                },
                child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(handler.theme.buttonRadius),
                        color: handler.theme.cardGrey),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            ImageConstants.saved,
                            scale: 2.6,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${context.getLocale!.youHave} ",
                                      style: handler.theme.normalTextStyle,
                                    ),
                                    if (state.savedDapps.values.length != 1)
                                      Text(
                                        "${state.savedDapps.values.length} ${context.getLocale!.webDapps} ",
                                        style: handler.theme.normalTextStyle2,
                                      ),
                                    if (state.savedDapps.values.length == 1)
                                      Text(
                                        "${state.savedDapps.values.length} ${context.getLocale!.webDapp} ",
                                        style: handler.theme.normalTextStyle2,
                                      ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      context.getLocale!.viewAll,
                                      style: handler
                                          .theme.secondaryWhiteTextStyle3,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: handler.theme.whiteColor,
                                      size: handler.theme
                                          .secondaryWhiteTextStyle3.fontSize,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
