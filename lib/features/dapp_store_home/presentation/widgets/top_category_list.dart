import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/features/dapp_info/presentation/screens/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_list.dart';
import 'package:dappstore/features/dapp_store_home/presentation/screen/category_screen.dart';
import 'package:dappstore/widgets/dapp/dapp_list_horizantal_tile.dart';
import 'package:dappstore/widgets/dapp/dapp_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopCategoriesList extends StatefulWidget {
  /// Creates a list view with max top 3 featured dapps of any 3 random category
  /// the number of top featured cards : 3 can be changed
  /// the number of ramdom category : 3 can be changed
  final bool isInExploreCategory;
  const TopCategoriesList({super.key, this.isInExploreCategory = false});

  @override
  State<TopCategoriesList> createState() => _TopCategoriesListState();
}

class _TopCategoriesListState extends State<TopCategoriesList> {
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
            previous.featuredDappsByCategory.hashCode !=
            current.featuredDappsByCategory.hashCode,
        bloc: handler.getStoreCubit(),
        builder: (context, state) {
          Map<String, DappList?>? list = state.featuredDappsByCategory;
          if (list == null || list.isEmpty) {
            return Container();
          }
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 12),
            shrinkWrap: true,
            itemCount: widget.isInExploreCategory
                ? list.entries.length
                : (list.entries.length >= 3)
                    ? 3
                    : list.entries.length,
            cacheExtent: 200,
            addAutomaticKeepAlives: true,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  Positioned(
                    top: -400,
                    right: (index % 2 == 0) ? -400 : null,
                    left: (index % 2 != 0) ? -400 : null,
                    width: 800,
                    height: 800,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: handler.theme.wcBlue,
                          gradient: RadialGradient(
                            colors: [
                              handler.theme.wcBlue.withOpacity(0.2),
                              handler.theme.wcBlue.withOpacity(0),
                            ],
                          )),
                      height: 800,
                    ),
                  ),
                  topCategoryListWidget(
                      category: list.entries.elementAt(index).key,
                      list: list.entries.elementAt(index).value,
                      axis: widget.isInExploreCategory
                          ? (index.isEven ? Axis.horizontal : Axis.vertical)
                          : Axis.vertical),
                ],
              );
            },
          );
        });
  }

  Widget topCategoryListWidget({
    required String category,
    required DappList? list,
    Axis axis = Axis.vertical,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 21,
        vertical: widget.isInExploreCategory ? 0 : 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitleAndSeeAll(category),
          const SizedBox(
            height: 10,
          ),
          axis == Axis.horizontal
              ? buildHorizontalList(axis: axis, list: list)
              : buildVerticalList(list: list),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  Widget buildTitleAndSeeAll(String category) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                handler.theme.vSmallRadius,
              ),
              border:
                  Border.all(color: handler.theme.whiteColor.withOpacity(0.08)),
              gradient: LinearGradient(colors: [
                handler.theme.whiteColor.withOpacity(0),
                handler.theme.whiteColor.withOpacity(0.08)
              ])),
          child: Text(
            "${context.getLocale!.top} ${category.toUpperCase()}",
            style: handler.theme.secondaryTextStyle2,
          ),
        ),
        TextButton(
            onPressed: () {
              context.pushRoute(CategoryScreen(category: category));
            },
            child: Row(
              children: [
                Text(
                  context.getLocale!.seeAll,
                  style: (widget.isInExploreCategory)
                      ? handler.theme.bodyTextStyle
                      : handler.theme.normalTextStyle,
                ),
                if (widget.isInExploreCategory)
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Icon(
                      Icons.arrow_forward,
                      color: handler.theme.bodyTextColor,
                      size: handler.theme.bodyTextStyle.fontSize,
                    ),
                  )
              ],
            ))
      ],
    );
  }

  Widget buildHorizontalList({required Axis axis, required DappList? list}) {
    return SizedBox(
      height: 210,
      width: double.maxFinite,
      child: ListView.builder(
        itemCount: list?.response?.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        addAutomaticKeepAlives: true,
        padding: const EdgeInsets.symmetric(vertical: 12),
        cacheExtent: 200,
        scrollDirection: axis,
        itemBuilder: (BuildContext context, int index) {
          if (list?.response?[index] == null) {
            return const SizedBox();
          }
          return InkWell(
            onTap: () {
              handler.setActiveDappId(
                  dappId: list?.response![index]!.dappId ?? "");
              context.pushRoute(const DappInfoPage());
            },
            child: DappListHorizantal(
              dapp: list!.response![index]!,
              handler: handler,
            ),
          );
        },
      ),
    );
  }

  Widget buildVerticalList({required DappList? list}) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 12),
      shrinkWrap: true,
      itemCount: ((list?.response?.length ?? 0) > 3)
          ? 3
          : (list?.response?.length ?? 0),
      addAutomaticKeepAlives: true,
      cacheExtent: 200,
      itemBuilder: (BuildContext context, int index) {
        if (list?.response?[index] == null) {
          return const SizedBox();
        }
        return InkWell(
          onTap: () {
            handler.setActiveDappId(
                dappId: list?.response![index]!.dappId ?? "");
            context.pushRoute(const DappInfoPage());
          },
          child: DappListTile(
            dapp: list!.response![index]!,
            handler: handler,
            isThreeLines: widget.isInExploreCategory,
          ),
        );
      },
    );
  }
}
