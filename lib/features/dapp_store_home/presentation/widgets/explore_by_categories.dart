import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/curated_category_list.dart';
import 'package:dappstore/features/dapp_store_home/presentation/screen/category_screen.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreBycategories extends StatefulWidget {
  /// Creates a grid of all the category tiles for user to select any one explore single category
  /// on selecting it redirects user to [CategoryScreen]
  const ExploreBycategories({
    super.key,
  });

  @override
  State<ExploreBycategories> createState() => _ExploreBycategoriesState();
}

class _ExploreBycategoriesState extends State<ExploreBycategories> {
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
            previous.curatedCategoryList.hashCode !=
            current.curatedCategoryList.hashCode,
        bloc: handler.getStoreCubit(),
        builder: (context, state) {
          List<CuratedCategoryList?>? list = state.curatedCategoryList;
          if (list == null) {
            return Container();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.getLocale!.exploreByCategories,
                  style: handler.theme.buttonTextStyle,
                ),
                const SizedBox(
                  height: 4,
                ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shrinkWrap: true,
                  addAutomaticKeepAlives: true,
                  cacheExtent: 200,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 2.5,
                  ),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (list[index] == null) {
                      return const SizedBox();
                    }

                    return smallGridTile(list[index]);
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget getGridTile(CuratedCategoryList? curatedCategory) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(handler.theme.imageBorderRadius),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          context
              .pushRoute(CategoryScreen(category: curatedCategory!.category!));
        },
        borderRadius: BorderRadius.circular(handler.theme.imageBorderRadius),
        child: Stack(
          children: [
            ImageWidgetCached(
              curatedCategory?.image ?? "",
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                color: handler.theme.secondaryBackgroundColor.withOpacity(0.7),
                width: double.maxFinite,
                child: Text(
                  curatedCategory?.category?.toUpperCase() ?? "",
                  style: handler.theme.buttonTextStyle,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget smallGridTile(CuratedCategoryList? curatedCategory) {
    return InkWell(
      onTap: () {
        context.pushRoute(CategoryScreen(category: curatedCategory!.category!));
      },
      borderRadius: BorderRadius.circular(handler.theme.smallRadius),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(handler.theme.smallRadius),
            color: handler.theme.chipBlue,
            border: Border.all(
              color: handler.theme.cardBlue,
            )),
        clipBehavior: Clip.hardEdge,
        child: Center(
          child: Text(
            curatedCategory?.category?.toUpperCase() ?? "",
            style: handler.theme.secondaryWhiteTextStyle3,
            overflow: TextOverflow.fade,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
