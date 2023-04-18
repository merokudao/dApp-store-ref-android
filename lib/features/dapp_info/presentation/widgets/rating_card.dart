import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_info/application/dapp_info_cubit.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_info_handler.dart';
import 'package:dappstore/features/dapp_info/application/i_dapp_info_cubit.dart';
import 'package:dappstore/features/dapp_info/presentation/screens/ratings_page.dart';
import 'package:dappstore/features/dapp_info/presentation/widgets/add_rating_card.dart';
import 'package:dappstore/features/dapp_info/presentation/widgets/rating_popup_widget.dart';
import 'package:dappstore/features/dapp_info/presentation/widgets/review_tile.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/widgets/cards/default_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef RatingCallback = void Function(double rating);

class RatingCard extends StatefulWidget {
  final IThemeSpec theme;
  final double rating;
  final IDappInfoHandler handler;
  final DappInfo dappInfo;
  const RatingCard({
    super.key,
    required this.theme,
    this.rating = 0,
    required this.handler,
    required this.dappInfo,
  });

  @override
  State<RatingCard> createState() => _RatingCardState();
}

class _RatingCardState extends State<RatingCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IDappInfoCubit, DappInfoState>(
        bloc: widget.handler.dappInfoCubit,
        builder: (context, state) {
          return DefaultCard(
            theme: widget.theme,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  state.selfRating == null
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: AddRatingCard(
                            handler: widget.handler,
                            initialRating: widget.rating,
                            ratingUpdateCallback: (value) {
                              widget.handler.showRatingPopup(
                                context,
                                RatingPopupWidget(
                                  handler: widget.handler,
                                  initialRating: value,
                                  dappId: widget.dappInfo.dappId!,
                                ),
                              );
                            },
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              context.getLocale!.yourReview,
                              style: widget.theme.whiteBoldTextStyle,
                            ),
                            TextButton(
                                onPressed: () {
                                  widget.handler.showRatingPopup(
                                    context,
                                    RatingPopupWidget(
                                      handler: widget.handler,
                                      initialRating:
                                          (state.selfRating?.rating ?? 0)
                                              .toDouble(),
                                      dappId: widget.dappInfo.dappId!,
                                    ),
                                  );
                                },
                                child: Text(
                                  context.getLocale!.update,
                                  style: widget.theme.bodyTextStyle,
                                ))
                          ],
                        ),
                  if (state.selfRating != null)
                    Divider(
                      color: widget.theme.whiteColor.withOpacity(0.08),
                      height: 1,
                    ),
                  if (state.selfRating != null)
                    ReviewTile(
                        address: state.selfRating?.userAddress ??
                            state.selfRating!.userName ??
                            "null",
                        theme: widget.theme,
                        name: state.selfRating!.userName ?? "",
                        description: state.selfRating!.comment ?? "",
                        rating: state.selfRating!.rating ?? 0),
                  Divider(
                    color: widget.theme.whiteColor.withOpacity(0.2),
                    height: 1,
                  ),
                  if (state.ratingList?.response?.isNotEmpty ?? false)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.getLocale!.allReviews,
                          style: widget.theme.whiteBoldTextStyle,
                        ),
                        TextButton(
                            onPressed: () {
                              context.pushRoute(RatingsScreen(
                                theme: widget.theme,
                                handler: widget.handler,
                              ));
                            },
                            child: Text(
                              context.getLocale!.viewAll,
                              style: widget.theme.bodyTextStyle,
                            ))
                      ],
                    ),
                  if (state.ratingList?.response?.isNotEmpty ?? false)
                    Divider(
                      color: widget.theme.whiteColor.withOpacity(0.08),
                      height: 1,
                    ),
                  if (state.ratingList?.response?.isNotEmpty ?? false)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.ratingList!.response!.length > 3
                          ? 3
                          : state.ratingList!.response!.length,
                      itemBuilder: ((context, index) {
                        final rating = state.ratingList!.response![index]!;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ReviewTile(
                              address: rating.userAddress ??
                                  rating.userName ??
                                  "null",
                              name: rating.userName ?? "",
                              description: rating.comment ?? "",
                              rating: rating.rating ?? 0,
                              theme: widget.theme,
                            ),
                            Divider(
                              color: widget.theme.whiteColor.withOpacity(0.08),
                              height: 1,
                            ),
                          ],
                        );
                      }),
                    ),
                ],
              ),
            ),
          );
        });
  }
}
