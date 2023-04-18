import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/saved_dapps/application/i_saved_dapps_cubit.dart';
import 'package:dappstore/features/saved_dapps/application/saved_dapps_cubit.dart';
import 'package:dappstore/features/saved_dapps/presentation/pages/saved_dapps_page.dart';
import 'package:dappstore/utils/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateAvailableCard extends StatelessWidget {
  /// Creates a simple card that shows number of dapps that have an update available
  /// if null than shows user ans option to redirect to [SavedDappsPage] only
  const UpdateAvailableCard({super.key});

  @override
  Widget build(BuildContext context) {
    IDappStoreHandler handler = DappStoreHandler();
    return BlocBuilder<ISavedDappsCubit, SavedDappsState>(
      bloc: handler.savedDappsCubit,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: InkWell(
            onTap: () {
              context.pushRoute(SavedDappsPage());
            },
            child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(handler.theme.buttonRadius),
                    color: handler.theme.cardBlue.withOpacity(1)),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        ImageConstants.update,
                        scale: 2.7,
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
                            (state.needUpdate?.isEmpty ?? true)
                                ? Text(
                                    context.getLocale!.seeInstalledDapps,
                                    style: handler.theme.normalTextStyle2,
                                  )
                                : state.needUpdate?.length == 1
                                    ? Text(
                                        "${state.needUpdate?.length} ${context.getLocale!.dappReadyToUpdate}",
                                        style: handler.theme.normalTextStyle2,
                                      )
                                    : Text(
                                        "${state.needUpdate?.length} ${context.getLocale!.dappsReadyToUpdate}",
                                        style: handler.theme.normalTextStyle2,
                                      ),
                            (state.needUpdate?.isEmpty ?? true)
                                ? Text(
                                    context.getLocale!.deepDive,
                                    softWrap: true,
                                    style:
                                        handler.theme.secondaryWhiteTextStyle3,
                                  )
                                : Text(
                                    context.getLocale!.updateYourDapps,
                                    softWrap: true,
                                    style:
                                        handler.theme.secondaryWhiteTextStyle3,
                                  )
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
