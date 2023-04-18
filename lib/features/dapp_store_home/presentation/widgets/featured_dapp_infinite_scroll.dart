import 'package:carousel_slider/carousel_slider.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/features/dapp_info/presentation/screens/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/widgets/image_widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeaturedDappInfiniteScroll extends StatefulWidget {
  /// Creates a infinite auto scrolling list of dapps at the bottom
  const FeaturedDappInfiniteScroll({super.key});

  @override
  State<FeaturedDappInfiniteScroll> createState() =>
      _FeaturedDappInfiniteScrollState();
}

class _FeaturedDappInfiniteScrollState
    extends State<FeaturedDappInfiniteScroll> {
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
          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: list.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        getGridTile(list[itemIndex]),
                options: CarouselOptions(
                  viewportFraction: 0.27,
                  height: 80,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 400),
                  autoPlayInterval: const Duration(seconds: 2),
                  autoPlayCurve: Curves.easeInOut,
                  scrollDirection: Axis.horizontal,
                  aspectRatio: 1,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              CarouselSlider.builder(
                itemCount: list.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        getGridTile(list[list.length - itemIndex - 1]),
                options: CarouselOptions(
                  viewportFraction: 0.27,
                  height: 80,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: true,
                  autoPlay: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 400),
                  autoPlayInterval: const Duration(seconds: 2),
                  autoPlayCurve: Curves.easeInOut,
                  scrollDirection: Axis.horizontal,
                  aspectRatio: 1,
                ),
              ),
            ],
          );
        });
  }

  Widget getGridTile(DappInfo? dapp) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(handler.theme.imageBorderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          handler.setActiveDappId(dappId: dapp?.dappId ?? "");
          context.pushRoute(const DappInfoPage());
        },
        borderRadius: BorderRadius.circular(handler.theme.imageBorderRadius),
        child: ImageWidgetCached(
          dapp!.images!.logo!,
          height: 80,
          width: 80,
        ),
      ),
    );
  }
}
