import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/features/pwa_webwiew/infrastructure/models/rpc_mapping.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dappstore/features/wallet_connect/models/eth/ethereum_transaction.dart';
import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_injected_web3/flutter_injected_web3.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'i_injected_web3_cubit.dart';

part '../../../../generated/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit.freezed.dart';
part 'injected_web3_state.dart';

//this cubit handles web3 injection, all web3 related states and communication with signer.
@LazySingleton(as: IInjectedWeb3Cubit)
class InjectedWeb3Cubit extends Cubit<InjectedWeb3State>
    implements IInjectedWeb3Cubit {
  final IErrorLogger errorLogger;
  final IWalletConnectCubit signer;
  InjectedWeb3Cubit({required this.signer, required this.errorLogger})
      : super(InjectedWeb3State.initial());

  @override
  started() {
    emit(state.copyWith(
      failure: false,
      connected: false,
    ));
  }

  @override
  connect(int chainId, String originalUrl) async {
    final supported = signer.approvedChains!.first;
    final rpc = RpcMapping.networks[supported];
    emit(
      state.copyWith(
        connectedChainId: supported,
        connectedChainRpc: rpc!.rpc,
        connected: true,
        originalUrl: originalUrl,
      ),
    );
    return account;
  }

  @override
  String? get account => signer.getActiveAdddress();

  @override
  String? get chainId =>
      state.connectedChainId?.toString() ?? signer.getChain()!.split(":")[1];

  @override
  changeChains(int chainId) {
    final approvedChains = signer.approvedChains;
    final rpcEndpoint = RpcMapping.networks[chainId];
    if (approvedChains!.contains(chainId) && rpcEndpoint != null) {
      debugPrint("chain id $chainId");
      emit(
        state.copyWith(
          connectedChainId: chainId,
          connectedChainRpc: rpcEndpoint.rpc,
        ),
      );
      return rpcEndpoint;
    } else {
      return "";
    }
  }

  @override
  Future<String> sendTransaction(
    JsTransactionObject jsTransactionObject,
  ) async {
    try {
      debugPrint("transaction callback ${jsTransactionObject.toString()}");
      final txHash = await signer.getEthSendTransaction(
          EthereumTransaction(
            from: jsTransactionObject.from!,
            to: jsTransactionObject.to!,
            value: jsTransactionObject.value ?? "0",
            data: jsTransactionObject.data ?? "",
          ),
          state.connectedChainId!);
      return txHash;
    } catch (e, stack) {
      errorLogger.logError(e, stack);
      return "";
    }
  }

  @override
  Future<String> signTransaction(
    JsTransactionObject jsTransactionObject,
  ) async {
    try {
      final signedTx = await signer.getEthSignTransaction(
          EthereumTransaction(
            from: jsTransactionObject.from!,
            to: jsTransactionObject.to!,
            value: jsTransactionObject.value ?? "0",
            data: jsTransactionObject.data ?? "",
          ),
          state.connectedChainId!);
      return signedTx;
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return "";
    }
  }

  @override
  Future<String> ecRecover(JsEcRecoverObject ecRecoverObject) async {
    final recoveredAddress = EthSigUtil.recoverSignature(
        signature: ecRecoverObject.signature ?? "",
        message: Uint8List.fromList(ecRecoverObject.message?.codeUnits ?? []));
    return recoveredAddress;
  }

  @override
  Future<String> signPersonalMessage(
    String data,
  ) async {
    try {
      final signedMessage = await signer.getPersonalSign(data);
      return signedMessage;
    } catch (e, stack) {
      errorLogger.logError(e, stack);
      return "";
    }
  }

  @override
  Future<String> signMessage(
    String data,
  ) async {
    try {
      final signedMessage = await signer.getEthSign(data);
      return signedMessage;
    } catch (e, stack) {
      errorLogger.logError(e, stack);
      return "";
    }
  }

  @override
  Future<String> signTypedData(
    JsEthSignTypedData data,
  ) async {
    try {
      final signedMessage = await signer.getEthSignTypedData(data.data!);
      return signedMessage;
    } catch (e, stack) {
      errorLogger.logError(e, stack);
      return "";
    }
  }
}
