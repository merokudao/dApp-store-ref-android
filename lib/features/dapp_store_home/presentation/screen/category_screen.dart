import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/constants/routes.dart';
import 'package:dappstore/core/router/interface/route.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/features/dapp_info/presentation/screens/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_list.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/normal_appbar.dart';
import 'package:dappstore/widgets/chip.dart';
import 'package:dappstore/widgets/dapp/dapp_list_horizontal_green_blue_card.dart';
import 'package:dappstore/widgets/dapp/dapp_list_tile.dart';
import 'package:dappstore/widgets/loader/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulScreen {
  /// Creates a category screen where only dapps of specific [category] are shown
  final String category;
  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();

  @override
  String get route => Routes.category;
}

class _CategoryScreenState extends State<CategoryScreen> {
  late final IDappStoreHandler storeHandler;
  late final IStoreCubit storeCubit;
  late ScrollController controller;

  @override
  void initState() {
    storeHandler = DappStoreHandler();
    storeHandler.getSelectedCategoryDappList(
        queryParams:
            GetDappQueryDto(categories: [widget.category.toLowerCase()]));
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CategoryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    storeHandler.resetSelectedCategory();
    super.dispose();
  }

  _scrollListener() {
    if (controller.position.extentAfter <= 0) {
      debugPrint("Next search page");
      storeHandler.getSelectedCategoryDappListNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: storeHandler.theme.backgroundColor,
      appBar: NormalAppBar(
        title: "${context.getLocale!.explore} ${widget.category}",
      ),
      body: BlocBuilder<IStoreCubit, StoreState>(
          buildWhen: (previous, current) =>
              (previous.selectedCategoryDappList.hashCode !=
                  current.selectedCategoryDappList.hashCode),
          bloc: storeHandler.getStoreCubit(),
          builder: (context, state) {
            List<DappInfo?>? list = state.selectedCategoryDappList?.response;
            Map<String, DappList?>? featuredCategoryList =
                state.featuredDappsByCategory;
            return ListView(
              addAutomaticKeepAlives: true,
              cacheExtent: 20,
              controller: controller,
              children: [
                if (featuredCategoryList == null ||
                    featuredCategoryList.isEmpty)
                  const SizedBox()
                else ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: CustomChip(
                          handler: storeHandler,
                          title:
                              "${context.getLocale!.top} ${widget.category.toUpperCase()}"),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: buildFeaturedList(
                        featuredCategoryList: featuredCategoryList),
                  ),
                ],
                if ((list == null || list.isEmpty))
                  (state.isLoadingNextselectedCategoryPage ?? false)
                      ? Center(
                          child: Loader(
                            size: 40,
                            color: storeHandler.theme.bodyTextColor,
                          ),
                        )
                      : const SizedBox()
                else ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: CustomChip(
                          handler: storeHandler,
                          title:
                              "${context.getLocale!.all} ${widget.category}"),
                    ),
                  ),
                  buildCategoryList(list: list, state: state),
                ],
              ],
            );
          }),
    );
  }

  Widget buildFeaturedList(
      {required Map<String, DappList?> featuredCategoryList}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      width: double.maxFinite,
      child: ListView.builder(
        itemCount: featuredCategoryList[widget.category]?.response?.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        addAutomaticKeepAlives: true,
        padding: const EdgeInsets.symmetric(vertical: 12),
        cacheExtent: 200,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          if (featuredCategoryList[widget.category]?.response?[index] == null) {
            return const SizedBox();
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                storeHandler.setActiveDappId(
                    dappId: featuredCategoryList[widget.category]!
                            .response![index]!
                            .dappId ??
                        "");
                context.pushRoute(const DappInfoPage());
              },
              child: DappListHorizontalGreenBlueCard(
                dapp: featuredCategoryList[widget.category]!.response![index]!,
                handler: storeHandler,
                green: index % 2 != 0,
                key: ValueKey(
                  featuredCategoryList[widget.category]!
                      .response![index]!
                      .dappId,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildCategoryList(
      {required List<DappInfo?> list, required StoreState state}) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: (list.isEmpty) ? 0 : (list.length + 1),
      addAutomaticKeepAlives: true,
      itemBuilder: (BuildContext context, int index) {
        if (index == list.length) {
          if ((state.isLoadingNextselectedCategoryPage ?? false) ||
              (state.selectedCategoryDappList?.page ==
                  state.selectedCategoryDappList?.pageCount)) {
            return const SizedBox();
          } else {
            return Center(
              child: Loader(
                size: 40,
                color: storeHandler.theme.bodyTextColor,
              ),
            );
          }
        }
        if (list[index] == null) {
          return const SizedBox();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: InkWell(
            onTap: () {
              storeHandler.setActiveDappId(dappId: list[index]!.dappId ?? "");
              context.pushRoute(const DappInfoPage());
            },
            child: DappListTile(
              dapp: list[index]!,
              handler: storeHandler,
            ),
          ),
        );
      },
    );
  }
}
