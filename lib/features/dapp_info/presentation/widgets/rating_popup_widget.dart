import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_info_handler.dart';
import 'package:dappstore/features/dapp_info/presentation/widgets/add_rating_card.dart';
import 'package:flutter/material.dart';

class RatingPopupWidget extends StatefulWidget {
  final IDappInfoHandler handler;
  final String dappId;
  final double initialRating;

  const RatingPopupWidget({
    Key? key,
    required this.handler,
    required this.dappId,
    required this.initialRating,
  }) : super(key: key);

  @override
  State<RatingPopupWidget> createState() => _RatingPopupWidgetState();
}

class _RatingPopupWidgetState extends State<RatingPopupWidget> {
  final TextEditingController textController = TextEditingController(text: "");
  bool error = false;
  bool success = false;
  bool posting = false;

  @override
  Widget build(BuildContext context) {
    double rating = widget.initialRating;
    final IThemeSpec theme = widget.handler.themeCubit.theme;
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: error
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Icon(
                  Icons.error_outline_rounded,
                  color: theme.errorRed,
                  size: 60,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  context.getLocale!.downloadDappToReview,
                  style: theme.whiteBoldTextStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            )
          : success
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Icon(
                      Icons.done,
                      color: theme.appGreen,
                      size: 60,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      context.getLocale!.reviewPosted,
                      style: theme.whiteBoldTextStyle,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                )
              : posting
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: theme.greyBlue,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(theme.blue),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                context.popRoute();
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: theme.whiteColor,
                              ),
                            ),
                            Text(
                              context.getLocale!.addRating,
                              style: theme.whiteBoldTextStyle,
                            ),
                            InkWell(
                              onTap: () {
                                context.popRoute();
                              },
                              child: Icon(
                                Icons.close,
                                color: theme.whiteColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        AddRatingCard(
                          handler: widget.handler,
                          initialRating: widget.initialRating,
                          ratingUpdateCallback: (value) {
                            rating = value;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextField(
                          maxLines: 3,
                          autofocus: true,
                          controller: textController,
                          decoration: InputDecoration(
                              hintText: context.getLocale!.writeAboutTheApp,
                              hintStyle: theme.bodyTextStyle,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(theme.buttonRadius),
                                  borderSide: BorderSide(
                                      color: theme.appBarBackgroundColor))),
                          style: theme.normalTextStyle,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      posting = true;
                                    });
                                    final resp = await widget.handler
                                        .postRating(rating, textController.text,
                                            widget.dappId);

                                    setState(() {
                                      if (resp) {
                                        success = true;
                                      } else {
                                        error = true;
                                      }
                                      posting = false;
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: theme.wcBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          theme.buttonRadius),
                                    ),
                                  ),
                                  child: Text(
                                    context.getLocale!.shareReview,
                                    style: theme.whiteBoldTextStyle,
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
    );
  }
}
