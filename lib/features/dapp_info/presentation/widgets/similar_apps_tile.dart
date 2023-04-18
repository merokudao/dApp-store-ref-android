import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_info_handler.dart';
import 'package:dappstore/features/dapp_info/presentation/screens/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';

class SimilarAppsTile extends StatelessWidget {
  final DappInfo dappInfo;
  final IThemeSpec theme;
  final bool primaryTile;
  final bool biggerTile;
  final IDappInfoHandler dappInfoHandler;
  const SimilarAppsTile({
    super.key,
    required this.theme,
    required this.dappInfo,
    required this.primaryTile,
    required this.dappInfoHandler,
    this.biggerTile = false,
  });

  @override
  Widget build(BuildContext context) {
    final listTile = SizedBox(
      height: biggerTile ? 64 : 48,
      child: GestureDetector(
        onTap: () {
          dappInfoHandler.storeCubit.setActiveDappId(
            dappId: dappInfo.dappId!,
          );
          context.pushRoute(const DappInfoPage());
        },
        child: ListTile(
          leading: SizedBox(
            height: biggerTile ? 64 : 48,
            width: biggerTile ? 64 : 48,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: ImageWidgetCached(
                dappInfo.images?.logo! ?? "",
                fit: BoxFit.fill,
                height: biggerTile ? 64 : 48,
                width: biggerTile ? 64 : 48,
              ),
            ),
          ),
          title: Text(
            dappInfo.name!,
            style:
                biggerTile ? theme.biggerTitleTextStyle : theme.titleTextStyle,
          ),
          subtitle: Text(
            "${dappInfo.developer?.legalName ?? ""} · ${dappInfo.category}",
            style: biggerTile ? theme.bodyTextStyle : theme.secondaryTextStyle2,
          ),
          trailing: Icon(
            Icons.arrow_forward,
            color: theme.greyArrowColor,
          ),
        ),
      ),
    );
    return listTile;
  }
}
