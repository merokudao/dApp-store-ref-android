import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/features/wallet_connect/models/chain_data.dart';
import 'package:dappstore/features/wallet_connect/models/chain_metadata.dart';
import 'package:dappstore/features/wallet_connect/models/connected_account.dart';
import 'package:dappstore/features/wallet_connect/utils/eip155.dart';
import 'package:flutter/material.dart';
import 'package:wallet_connect_dart_v2/wallet_connect_dart_v2.dart';

class WCHelper {
  /// WalletConnect helper to [getChainName],[getChainMetadataFromChainId] and more
  WCHelper._();
  static String getChainName(String chainId) {
    try {
      return ChainData.allChains
          .where((element) => element.chainId == chainId)
          .first
          .name;
    } catch (e, stack) {
      getIt<IErrorLogger>().logError(e, stack);

      debugPrint('Invalid chain');
    }
    return 'Unknown';
  }

  static ChainMetadata getChainMetadataFromChainId(String chainId) {
    try {
      return ChainData.allChains
          .where((element) => element.chainId == chainId)
          .first;
    } catch (e, stack) {
      getIt<IErrorLogger>().logError(e, stack);

      debugPrint('Invalid chain');
    }
    return ChainData.mainChains[0];
  }

  static List<String> getChainMethods(ChainType value) {
// currently only supports EVM
    return Eip155Data.methods.values.toList();
  }

  static List<String> getChainEvents(ChainType value) {
    // currently only supports EVM
    return Eip155Data.events.values.toList();
  }

  static String getChainIdFromAccountStr(String account) {
    final chainId = '${account.split(':')[0]}:${account.split(':')[1]}';
    return chainId;
  }

  static String getAddressFromAccountStr(String account) {
    final accAddress = account.split(':')[2];
    return accAddress;
  }

  static List<ConnectedAccount> getConnectedAccountForSession(
      SessionStruct session) {
    List<ConnectedAccount> connectedAccounts = [];

    // ignore: avoid_function_literals_in_foreach_calls
    session.namespaces[ChainType.eip155.name]?.accounts.forEach((ele) {
      String address = getAddressFromAccountStr(ele);
      ChainMetadata chainMetadata =
          getChainMetadataFromChainId(getChainIdFromAccountStr(ele));
      int index =
          connectedAccounts.indexWhere((element) => element.address == address);
      if (index >= 0) {
        connectedAccounts[index].chains.add(chainMetadata);
      } else {
        connectedAccounts
            .add(ConnectedAccount(address: address, chains: [chainMetadata]));
      }
    });

    return connectedAccounts;
  }
}
