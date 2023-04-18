import 'package:dappstore/core/signer/i_signer.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/wallet_connect_cubit.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/store/i_wallet_connect_store.dart';
import 'package:dappstore/features/wallet_connect/models/connected_account.dart';
import 'package:dappstore/features/wallet_connect/models/eth/ethereum_transaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_connect_dart_v2/wallet_connect_dart_v2.dart';

abstract class IWalletConnectCubit extends Cubit<WalletConnectState>
    implements ISigner {
  SignClient? signClient;
  final IWalletConnectStore wcStore;
  IWalletConnectCubit({required this.wcStore})
      : super(WalletConnectState.initial());

  started();

  initialize();

  getSessionAndPairings();

  Future<bool> getConnectRequest(List<String> chainIds);

  String? getActiveAdddress();

  String? getChain();

  List<int>? get approvedChains;

  @override
  Future<String> getPersonalSign(
    String data,
  );

  @override
  Future<String> getEthSign(String data);

  Future<String> getLoginEthSign(String data);

  @override
  Future<String> getEthSignTypedData(String data);

  @override
  getEthSignTransaction(EthereumTransaction transaction, int chainId);

  @override
  getEthSendTransaction(EthereumTransaction transaction, int chainId);

  Future<void> disconnect(String topic);

  disconnectAll();

  getPreviouslyConnectedSession();

// returns topic->AccountList
  Map<String, List<ConnectedAccount>> getAllConnectedAccounts();
  String getMessageToSign(String unhexedMessage);
}
