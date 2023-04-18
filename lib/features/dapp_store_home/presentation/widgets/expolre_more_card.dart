import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/presentation/screen/explore_categories.dart';
import 'package:flutter/material.dart';

class ExploreMoreCard extends StatelessWidget {
  /// Creates a simple card that redirects user to [ExploreCategories] screen
  const ExploreMoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    IDappStoreHandler handler = DappStoreHandler();
    return InkWell(
      onTap: () => context.pushRoute(const ExploreCategories()),
      child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(handler.theme.buttonRadius),
              color: handler.theme.cardGrey),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.getLocale!.exploreMore,
                    style: handler.theme.normalTextStyle,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        context.getLocale!.viewAll,
                        style: handler.theme.secondaryWhiteTextStyle3,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: handler.theme.whiteColor,
                        size: handler.theme.secondaryWhiteTextStyle3.fontSize,
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
