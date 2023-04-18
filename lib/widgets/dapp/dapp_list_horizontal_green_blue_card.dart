import 'dart:math';

import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';

class DappListHorizontalGreenBlueCard extends StatelessWidget {
  /// A big Dapp card with green or blue gradient background that can be used inside any listview inside the app
  /// [dapp], [green] and [handler] are required
  final bool green;
  final IDappStoreHandler handler;
  final DappInfo? dapp;
  const DappListHorizontalGreenBlueCard(
      {required this.green,
      required this.handler,
      required this.dapp,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width / 2,
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(handler.theme.buttonRadius),
          backgroundBlendMode: BlendMode.screen,
          border: Border.all(
              color: green ? handler.theme.cardGreen : handler.theme.cardBlue,
              width: 1),
          gradient: LinearGradient(
            colors: [
              handler.theme.whiteColor.withOpacity(0),
              handler.theme.whiteColor.withOpacity(0.2),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(handler.theme.buttonRadius),
          color: green ? handler.theme.cardGreen : handler.theme.cardBlue,
          border: Border.all(
              color: green ? handler.theme.cardGreen : handler.theme.cardBlue,
              width: 1),
          backgroundBlendMode: BlendMode.screen,
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Transform.rotate(
                angle: 2 * pi / 3,
                child: Icon(
                  Icons.arrow_back,
                  color: handler.theme.whiteColor.withOpacity(0.2),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                circularImage(dapp?.images?.logo ?? ""),
                Text(
                  dapp?.name ?? "",
                  style: handler.theme.normalTextStyle,
                ),
                Text(
                  dapp?.description ?? "",
                  style: handler.theme.bodyTextStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      handler.theme.vSmallRadius,
                    ),
                    color: Colors.white24,
                  ),
                  child: Text(
                    dapp?.category ?? "",
                    style: handler.theme.secondaryTextStyle2,
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget circularImage(String image) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2000),
          border: Border.all(color: handler.theme.whiteColor, width: 1.5)),
      clipBehavior: Clip.antiAlias,
      child: ImageWidgetCached(
        image,
        width: 60,
        height: 60,
      ),
    );
  }
}
