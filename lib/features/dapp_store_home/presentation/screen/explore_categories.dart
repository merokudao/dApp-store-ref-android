import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/constants/routes.dart';
import 'package:dappstore/core/router/interface/route.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/explore_by_categories.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/normal_appbar.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/top_category_list.dart';
import 'package:flutter/material.dart';

class ExploreCategories extends StatefulScreen {
  /// Creates a screen to explore are categories and list the top dapp of each category
  const ExploreCategories({super.key});

  @override
  State<ExploreCategories> createState() => _ExploreCategoriesState();

  @override
  String get route => Routes.exploreCategories;
}

class _ExploreCategoriesState extends State<ExploreCategories> {
  late final IDappStoreHandler storeHandler;
  late final IStoreCubit storeCubit;
  @override
  void initState() {
    super.initState();
    storeHandler = DappStoreHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: storeHandler.theme.backgroundColor,
      appBar: NormalAppBar(
        title: context.getLocale!.categories,
      ),
      body: ListView(
        addAutomaticKeepAlives: true,
        physics: const BouncingScrollPhysics(),
        cacheExtent: 20,
        children: const [
          ExploreBycategories(),
          TopCategoriesList(isInExploreCategory: true),
        ],
      ),
    );
  }
}
