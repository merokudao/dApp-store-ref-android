// ignore_for_file: constant_identifier_names

import 'package:dappstore/features/wallet_connect/models/chain_metadata.dart';
import 'package:dappstore/features/wallet_connect/models/eth/ethereum_transaction.dart';
import 'package:dappstore/features/wallet_connect/utils/helpers.dart';
import 'package:wallet_connect_dart_v2/wallet_connect_dart_v2.dart';

/// Enums and extension used for walletConnect

enum Eip155Methods {
  PERSONAL_SIGN,
  ETH_SIGN,
  ETH_SIGN_TRANSACTION,
  ETH_SIGN_TYPED_DATA,
  ETH_SEND_TRANSACTION,
}

enum Eip155Events {
  CHAIN_CHANGED,
  ACCOUNTS_CHANGED,
}

extension Eip155MethodsX on Eip155Methods {
  String? get value => Eip155Data.methods[this];
}

extension Eip155MethodsStringX on String {
  Eip155Methods? toEip155Method() {
    final entries =
        Eip155Data.methods.entries.where((element) => element.value == this);
    return (entries.isNotEmpty) ? entries.first.key : null;
  }
}

extension Eip155EventsX on Eip155Events {
  String? get value => Eip155Data.methods[this];
}

extension Eip155EventsStringX on String {
  Eip155Events? toEip155Event() {
    final entries =
        Eip155Data.events.entries.where((element) => element.value == this);
    return (entries.isNotEmpty) ? entries.first.key : null;
  }
}

class Eip155Data {
  static final Map<Eip155Methods, String> methods = {
    Eip155Methods.PERSONAL_SIGN: 'personal_sign',
    Eip155Methods.ETH_SIGN: 'eth_sign',
    Eip155Methods.ETH_SIGN_TRANSACTION: 'eth_signTransaction',
    Eip155Methods.ETH_SIGN_TYPED_DATA: 'eth_signTypedData',
    Eip155Methods.ETH_SEND_TRANSACTION: 'eth_sendTransaction'
  };

  static final Map<Eip155Events, String> events = {
    Eip155Events.CHAIN_CHANGED: 'eth_chainsChanged',
    Eip155Events.ACCOUNTS_CHANGED: 'eth_accountsChanged',
  };

  static SessionConnectParams getSessionConnectParams(List<String> chainIds) {
    return SessionConnectParams(requiredNamespaces: {
      ChainType.eip155.name: ProposalRequiredNamespace(
        chains: chainIds,
        events: WCHelper.getChainEvents(ChainType.eip155),
        methods: WCHelper.getChainMethods(ChainType.eip155),
      )
    });
  }

  static SessionRequestParams getRequestParams(
      {required String topic,
      required Eip155Methods method,
      required String chainId,
      required String address,
      String? data,
      EthereumTransaction? transaction}) {
    switch (method) {
      case Eip155Methods.PERSONAL_SIGN:
        return personalSign(
          topic: topic,
          chainId: chainId,
          address: address,
          data: data!,
        );
      case Eip155Methods.ETH_SIGN:
        return ethSign(
          topic: topic,
          chainId: chainId,
          address: address,
          data: data!,
        );
      case Eip155Methods.ETH_SIGN_TYPED_DATA:
        return ethSignTypedData(
          topic: topic,
          chainId: chainId,
          address: address,
          data: data!,
        );
      case Eip155Methods.ETH_SIGN_TRANSACTION:
        return ethSignTransaction(
          topic: topic,
          chainId: chainId,
          transaction: transaction!,
        );
      case Eip155Methods.ETH_SEND_TRANSACTION:
        return ethSendTransaction(
          topic: topic,
          chainId: chainId,
          transaction: transaction!,
        );
    }
  }

  static SessionRequestParams personalSign({
    required String topic,
    required String chainId,
    required String address,
    required String data,
  }) {
    return SessionRequestParams(
      topic: topic,
      request:
          RequestArguments(method: Eip155Methods.PERSONAL_SIGN.value!, params: [
        data,
        address,
      ]),
      chainId: chainId,
    );
  }

  static SessionRequestParams ethSign({
    required String topic,
    required String chainId,
    required String address,
    required String data,
  }) {
    return SessionRequestParams(
      topic: topic,
      request: RequestArguments(method: Eip155Methods.ETH_SIGN.value!, params: [
        address,
        data,
      ]),
      chainId: chainId,
    );
  }

  static SessionRequestParams ethSignTypedData({
    required String topic,
    required String chainId,
    required String address,
    required String data,
  }) {
    return SessionRequestParams(
      topic: topic,
      request: RequestArguments(
          method: Eip155Methods.ETH_SIGN_TYPED_DATA.value!,
          params: [
            address,
            data,
          ]),
      chainId: chainId,
    );
  }

  static SessionRequestParams ethSignTransaction({
    required String topic,
    required String chainId,
    required EthereumTransaction transaction,
  }) {
    return SessionRequestParams(
      topic: topic,
      request: RequestArguments(
          method: Eip155Methods.ETH_SIGN_TRANSACTION.value!,
          params: [transaction.toJson()]),
      chainId: chainId,
    );
  }

  static SessionRequestParams ethSendTransaction({
    required String topic,
    required String chainId,
    required EthereumTransaction transaction,
  }) {
    return SessionRequestParams(
      topic: topic,
      request: RequestArguments(
          method: Eip155Methods.ETH_SEND_TRANSACTION.value!,
          params: [transaction.toJson()]),
      chainId: chainId,
    );
  }
}
