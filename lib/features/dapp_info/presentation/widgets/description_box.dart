import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_info_handler.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class AppDescriptionBox extends StatefulWidget {
  final IDappInfoHandler dappInfoHandler;
  const AppDescriptionBox({super.key, required this.dappInfoHandler});

  @override
  State<AppDescriptionBox> createState() => _AppDescriptionBoxState();
}

class _AppDescriptionBoxState extends State<AppDescriptionBox> {
  @override
  Widget build(BuildContext context) {
    final dappInfo = widget.dappInfoHandler.dappInfoCubit.state.dappInfo;
    final theme = widget.dappInfoHandler.themeCubit.theme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.getLocale!.aboutApp(dappInfo!.name!),
            style: theme.secondaryTitleTextStyle,
          ),
          ReadMoreText(
            dappInfo.description!.replaceAll(r'\n', '\n'),
            trimLines: 2,
            colorClickableText: theme.appGreen,
            trimMode: TrimMode.Line,
            style: theme.bodyTextStyle,
            trimCollapsedText: context.getLocale!.showMore,
            trimExpandedText: context.getLocale!.showLess,
            moreStyle: theme.bodyTextStyle.copyWith(
              color: theme.appGreen,
            ),
          ),
        ],
      ),
    );
  }
}
