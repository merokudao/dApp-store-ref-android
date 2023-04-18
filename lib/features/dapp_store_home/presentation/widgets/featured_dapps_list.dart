import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/features/dapp_info/presentation/screens/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/presentation/screen/explore_categories.dart';
import 'package:dappstore/widgets/dapp/dapp_list_horizontal_green_blue_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeaturedDappsList extends StatefulWidget {
  /// Created a horizantol list of featured dapps
  /// uses [DappListHorizontalGreenBlueCard]
  const FeaturedDappsList({super.key});

  @override
  State<FeaturedDappsList> createState() => _FeaturedDappsListState();
}

class _FeaturedDappsListState extends State<FeaturedDappsList> {
  late final IDappStoreHandler handler;
  @override
  void initState() {
    handler = DappStoreHandler();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IStoreCubit, StoreState>(
        buildWhen: (previous, current) =>
            previous.featuredDappList.hashCode !=
            current.featuredDappList.hashCode,
        bloc: handler.getStoreCubit(),
        builder: (context, state) {
          List<DappInfo?>? list = state.featuredDappList?.response;
          if (list == null) {
            return Container();
          }
          return Padding(
            padding: const EdgeInsets.only(top: 5, left: 8),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shrinkWrap: true,
                addAutomaticKeepAlives: true,
                scrollDirection: Axis.horizontal,
                cacheExtent: 200,
                itemCount: 16,
                itemBuilder: (BuildContext context, int index) {
                  return listTile(list[index], index % 2 != 0);
                },
              ),
            ),
          );
        });
  }

  Widget listTile(DappInfo? dapp, bool green) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            handler.setActiveDappId(dappId: dapp!.dappId ?? "");
            context.pushRoute(const DappInfoPage());
          },
          borderRadius: BorderRadius.circular(handler.theme.buttonRadius),
          child: DappListHorizontalGreenBlueCard(
              dapp: dapp,
              green: green,
              handler: handler,
              key: ValueKey(dapp?.dappId)),
        ));
  }

  Widget getExpolreMore() {
    return TextButton(
        onPressed: () {
          context.pushRoute(const ExploreCategories());
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
              handler.theme.secondaryBackgroundColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.getLocale!.exploreMore,
                style: handler.theme.normalTextStyle,
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: handler.theme.whiteColor,
              ),
            ],
          ),
        ));
  }
}
