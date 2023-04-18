import 'package:dappstore/widgets/buttons/search_button/custom_search_delegate.dart';
import 'package:dappstore/widgets/buttons/search_button/i_search_handler.dart';
import 'package:dappstore/widgets/buttons/search_button/search_handler.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchButton extends StatelessWidget {
  ISearchHandler handler = SearchHandler();

  SearchButton({super.key});
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: CustomSearchDelegate(
              handler: handler,
              context: context,
            ),
            useRootNavigator: true,
          );
        },
        icon: const Icon(
          Icons.search,
          color: Colors.white,
        ));
  }
}
