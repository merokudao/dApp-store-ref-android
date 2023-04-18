import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_info_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AppStatsCard extends StatelessWidget {
  final IDappInfoHandler dappInfoHandler;
  const AppStatsCard({super.key, required this.dappInfoHandler});

  @override
  Widget build(BuildContext context) {
    final dappInfo = dappInfoHandler.dappInfoCubit.state.dappInfo;
    final theme = dappInfoHandler.themeCubit.theme;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 20, 10, 8),
        child: Text(
          context.getLocale!.details,
          style: theme.titleTextStyle,
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 4, 16, 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.getLocale!.ratings,
              style: theme.greyHeading,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    (dappInfo?.metrics?.rating ?? "0").toString(),
                    style: theme.secondaryTitleTextStyle,
                  ),
                ),
                RatingBar(
                  initialRating: dappInfo?.metrics?.rating ?? 0,
                  direction: Axis.horizontal,
                  ignoreGestures: true,
                  onRatingUpdate: (_) {},
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  ratingWidget: RatingWidget(
                    full: Icon(
                      Icons.star,
                      color: theme.ratingGrey,
                    ),
                    half: Icon(
                      Icons.star_half,
                      color: theme.ratingGrey,
                    ),
                    empty: Icon(
                      Icons.star,
                      color: theme.unratedGrey,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      if (dappInfo!.availableOnPlatform!.isNotEmpty &&
          dappInfo.availableOnPlatform!.contains('android'))
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 4, 16, 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.getLocale!.downloads,
                style: theme.greyHeading,
              ),
              Text(
                (dappInfo.metrics?.downloads ?? 0).toString(),
                style: theme.secondaryTitleTextStyle,
              ),
            ],
          ),
        ),
    ]);
  }
}
