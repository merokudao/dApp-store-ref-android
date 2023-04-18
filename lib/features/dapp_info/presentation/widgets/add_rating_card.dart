import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_info_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

typedef RatingUpdateCallback = Function(double);

class AddRatingCard extends StatelessWidget {
  final IDappInfoHandler handler;
  final double initialRating;
  final RatingUpdateCallback ratingUpdateCallback;

  const AddRatingCard({
    super.key,
    required this.handler,
    required this.initialRating,
    required this.ratingUpdateCallback,
  });

  @override
  Widget build(BuildContext context) {
    IThemeSpec theme = handler.themeCubit.theme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.getLocale!.addRating,
          style: theme.titleTextExtraBold,
        ),
        RatingBar(
          initialRating: initialRating,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 25,
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
          onRatingUpdate: ratingUpdateCallback,
        ),
      ],
    );
  }
}
