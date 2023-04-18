import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/constants/routes.dart';
import 'package:dappstore/core/router/interface/route.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_info/application/dapp_info_cubit.dart';
import 'package:dappstore/features/dapp_info/application/handler/i_dapp_info_handler.dart';
import 'package:dappstore/features/dapp_info/application/i_dapp_info_cubit.dart';
import 'package:dappstore/features/dapp_info/presentation/widgets/review_tile.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/post_rating.dart';
import 'package:dappstore/features/dapp_store_home/presentation/widgets/in_screen_appbar.dart';
import 'package:dappstore/widgets/loader/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RatingsScreen extends StatefulScreen {
  final IThemeSpec theme;
  final IDappInfoHandler handler;

  const RatingsScreen({
    super.key,
    required this.theme,
    required this.handler,
  });

  @override
  State<RatingsScreen> createState() => _RatingsScreenState();

  @override
  String get route => Routes.ratingsScreen;
}

class _RatingsScreenState extends State<RatingsScreen> {
  late ScrollController controller;
  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RatingsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  _scrollListener() {
    if (controller.position.extentAfter <= 0) {
      debugPrint("Next search page");
      widget.handler.getRatingListNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.backgroundColor,
      appBar: InScreenAppBar(
        themeSpec: widget.theme,
        title: context.getLocale!.ratingsAndReviews,
      ),
      body: BlocBuilder<IDappInfoCubit, DappInfoState>(
          buildWhen: (previous, current) =>
              (previous.ratingList.hashCode != current.ratingList.hashCode),
          bloc: widget.handler.dappInfoCubit,
          builder: (context, state) {
            List<PostRating?>? list = state.ratingList?.response;
            if ((list == null)) {
              return Container();
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shrinkWrap: true,
              itemCount: (list.isEmpty) ? 0 : (list.length + 1),
              controller: controller,
              addAutomaticKeepAlives: true,
              itemBuilder: (BuildContext context, int index) {
                if (index == list.length) {
                  if ((state.isLoadingNextRating ?? false) ||
                      (state.ratingList?.page == state.ratingList?.pageCount)) {
                    return const SizedBox();
                  } else {
                    return Center(
                      child: Loader(
                        size: 40,
                        color: widget.theme.bodyTextColor,
                      ),
                    );
                  }
                }
                if (list[index] == null) {
                  return const SizedBox();
                }
                final rating = list[index]!;

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      ReviewTile(
                        address:
                            rating.userAddress ?? rating.userName ?? "null",
                        theme: widget.theme,
                        name: rating.userName ?? "",
                        description: rating.comment ?? "",
                        rating: rating.rating ?? 0,
                      ),
                      Divider(
                        color: widget.theme.whiteColor.withOpacity(0.3),
                        height: 1,
                      ),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
//  ListView.builder(
//         controller: controller,
//         itemCount: ratingsList.length,
//         itemBuilder: ((context, index) {
//           final rating = ratingsList[index];
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//             child: Column(
//               children: [
//                 ReviewTile(
//                   address: rating.userAddress ?? rating.username ?? "null",
//                   theme: widget.theme,
//                   name: rating.username ?? "",
//                   description: rating.comment ?? "",
//                   rating: rating.rating ?? 0,
//                 ),
//                 Divider(
//                   color: widget.theme.whiteColor.withOpacity(0.3),
//                   height: 1,
//                 ),
//               ],
//             ),
//           );
//         }),
//       ),