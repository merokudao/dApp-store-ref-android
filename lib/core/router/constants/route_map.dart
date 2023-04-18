import 'package:dappstore/features/dapp_info/presentation/screens/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/presentation/screen/explore_categories.dart';
import 'package:dappstore/features/dapp_store_home/presentation/screen/homepage.dart';
import 'package:flutter/material.dart';

class RouteMap {
  RouteMap._();

  static Map<String, Widget Function(BuildContext)> routes = {
    const HomePage().route: (context) => const HomePage(),
    const DappInfoPage().route: (context) => const DappInfoPage(),
    const ExploreCategories().route: (context) => const ExploreCategories(),
  };
}
