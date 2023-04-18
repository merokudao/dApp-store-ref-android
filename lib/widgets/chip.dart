import 'package:dappstore/features/dapp_store_home/application/handler/i_dapp_store_handler.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  /// Creates a Custom chip.
  ///
  /// The [handler], and [title] arguments must not be null.
  final IDappStoreHandler handler;
  final String title;
  const CustomChip({super.key, required this.handler, required this.title});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        title,
        style: handler.theme.secondaryTextStyle2,
      ),
      backgroundColor: handler.theme.secondaryBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
    );
  }
}
