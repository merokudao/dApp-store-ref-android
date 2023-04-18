import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/widgets/buttons/customizable_app_button.dart';
import 'package:dappstore/widgets/buttons/search_button/i_search_handler.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BigDappCard extends StatelessWidget {
  /// A basic Dapp card that can be used to display a highlighted dapp or first dapp in search result
  /// [dapp] and [handler] are required
  final DappInfo dapp;
  final ISearchHandler handler;

  const BigDappCard({
    required this.dapp,
    required this.handler,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final IThemeSpec theme = handler.theme;
    final installButton = Container(
      height: 30,
      width: 84,
      decoration: BoxDecoration(
        color: theme.blue,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(
            theme.smallRadius,
          ),
        ),
      ),
      child: Center(
        child: Text(
          context.getLocale!.install,
          style: handler.theme.smallButtonTextStyle,
        ),
      ),
    );
    final updateButton = Container(
      height: 30,
      width: 84,
      decoration: BoxDecoration(
        color: theme.blue,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(
            theme.smallRadius,
          ),
        ),
      ),
      child: Center(
        child: Text(
          context.getLocale!.update,
          style: handler.theme.smallButtonTextStyle,
        ),
      ),
    );
    final openButton = Container(
      height: 30,
      width: 84,
      decoration: BoxDecoration(
        color: theme.blue,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(
            theme.smallRadius,
          ),
        ),
      ),
      child: Center(
        child: Text(
          context.getLocale!.open,
          style: handler.theme.smallButtonTextStyle,
        ),
      ),
    );
    final installingButton = Container(
      height: 30,
      width: 84,
      decoration: BoxDecoration(
        color: theme.greyBlue,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(
            theme.smallRadius,
          ),
        ),
      ),
      child: Center(
        child: Text(
          context.getLocale!.installing,
          style: handler.theme.smallButtonTextStyle,
        ),
      ),
    );
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(handler.theme.smallRadius),
          color: handler.theme.searchBigCardBG,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(handler.theme.smallRadius),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: ImageWidgetCached(
                          dapp.images?.logo ?? dapp.images!.banner!,
                          key: ValueKey(
                            dapp.images?.logo ?? dapp.images!.banner!,
                          ),
                          height: 52,
                          width: 52,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dapp.name ?? "N/A",
                              style: handler.theme.normalTextStyle2,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "${dapp.developer?.legalName ?? "N/A"} • ${dapp.category}",
                              style: handler.theme.secondaryTextStyle1,
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                ),
                CustomizableAppButton(
                  theme: theme,
                  dappInfo: dapp,
                  updateWidget: updateButton,
                  openWidget: openButton,
                  installWidget: installButton,
                  installingWidget: installingButton,
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Divider(
              color: handler.theme.whiteColor.withOpacity(0.08),
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.getLocale!.ratings,
                  style: handler.theme.greyHeading,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        (dapp.metrics?.rating ?? "0").toString(),
                        style: handler.theme.secondaryTitleTextStyle,
                      ),
                    ),
                    RatingBar(
                      initialRating: dapp.metrics?.rating ?? 0,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemSize: 20,
                      ratingWidget: RatingWidget(
                        full: Icon(
                          Icons.star,
                          color: handler.theme.ratingGrey,
                        ),
                        half: Icon(
                          Icons.star_half,
                          color: handler.theme.ratingGrey,
                        ),
                        empty: Icon(
                          Icons.star,
                          color: handler.theme.unratedGrey,
                        ),
                      ),
                      ignoreGestures: true,
                      onRatingUpdate: (_) {},
                      allowHalfRating: true,
                    ),
                  ],
                )
              ],
            ),
            Divider(
              color: handler.theme.whiteColor.withOpacity(0.08),
              height: 1,
            ),
            if (dapp.availableOnPlatform!.isNotEmpty &&
                dapp.availableOnPlatform!.contains('android'))
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.getLocale!.downloads,
                    style: handler.theme.greyHeading,
                  ),
                  Text(
                    (dapp.metrics?.downloads ?? 0).toString(),
                    style: handler.theme.secondaryTitleTextStyle,
                  ),
                ],
              ),
          ],
        ));
  }
}
