import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:random_avatar/random_avatar.dart';

class ReviewTile extends StatelessWidget {
  final String address;
  final String name;
  final String description;
  final int rating;
  final IThemeSpec theme;

  const ReviewTile(
      {super.key,
      required this.address,
      required this.name,
      required this.description,
      required this.rating,
      required this.theme});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  randomAvatar(address, height: 30, width: 30),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    name,
                    style: theme.normalTextStyle,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                ],
              ),
            ),
            RatingBar(
              initialRating: rating.toDouble(), // get rating here
              itemCount: 5,
              itemSize: 12,
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
              ignoreGestures: true,
              onRatingUpdate: (_) {},
              allowHalfRating: true,
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          description,
          style: theme.bodyTextStyle,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
