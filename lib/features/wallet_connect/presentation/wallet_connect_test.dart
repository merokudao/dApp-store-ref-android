import 'dart:developer';

import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dappstore/features/wallet_connect/models/eth/ethereum_transaction.dart';
import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WCTestWidget extends StatelessWidget {
  /// this widget is only for testing purpose only
  const WCTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              var cubit = getIt<IWalletConnectCubit>();
              await cubit.initialize();
            },
            child: const Text("WC init")),
        ElevatedButton(
            onPressed: () async {
              var cubit = getIt<IWalletConnectCubit>();
              cubit.getPreviouslyConnectedSession();
            },
            child: const Text("reconnect")),
        ElevatedButton(
            onPressed: () async {
              var cubit = getIt<IWalletConnectCubit>();
              cubit.getConnectRequest(["eip155:137", "eip155:1"]);
            },
            child: const Text("Connect")),
        ElevatedButton(
            onPressed: () async {
              var cubit = getIt<IWalletConnectCubit>();
              var res = await cubit.getPersonalSign("Testing");
              log((res.runtimeType.toString()));
              var add = EthSigUtil.recoverPersonalSignature(
                  message: Uint8List.fromList("Testing ".codeUnits),
                  signature: res);
              // var add = EthSigUtil.ecRecover(
              //   signature:
              //       "0x1ba8be3db5c49f62795c78d580814ed5f63151a1ce2ce70435b01ae4e2aa141037e8b0ae09af3677b689275c9c0d5dec56a0ead0dae5852cfcea63186298de331c",
              //   message: Uint8List.fromList("Testing ".codeUnits),
              // );
              log(add.toString());
            },
            child: const Text("personal Sign")),
        ElevatedButton(
            onPressed: () async {
              var cubit = getIt<IWalletConnectCubit>();
              var res = await cubit.getEthSendTransaction(
                  EthereumTransaction(
                      from: cubit.state.activeAddress!,
                      to: cubit.state.activeAddress!,
                      data: "",
                      value: "0x01"),
                  137);
              log(res.toString());
            },
            child: const Text(" Sign TrX")),
        ElevatedButton(
            onPressed: () {
              var cubit = getIt<IWalletConnectCubit>();
              cubit.disconnectAll();
            },
            child: const Text("delete all"))
      ],
    );
  }
}
