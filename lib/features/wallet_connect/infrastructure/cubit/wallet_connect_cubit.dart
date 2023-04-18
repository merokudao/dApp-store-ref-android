import 'dart:developer';

import 'package:dappstore/config/config.dart';
import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/store/i_wallet_connect_store.dart';
import 'package:dappstore/features/wallet_connect/models/chain_metadata.dart';
import 'package:dappstore/features/wallet_connect/models/connected_account.dart';
import 'package:dappstore/features/wallet_connect/models/eth/ethereum_transaction.dart';
import 'package:dappstore/features/wallet_connect/utils/eip155.dart';
import 'package:dappstore/features/wallet_connect/utils/helpers.dart';
import 'package:dappstore/features/wallet_connect/utils/sign_checker.dart';
import 'package:eth_sig_util/util/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wallet_connect_dart_v2/wallet_connect_dart_v2.dart';
import 'package:wallet_connect_dart_v2/wc_utils/misc/logger/logger.dart';

part '../../../../generated/features/wallet_connect/infrastructure/cubit/wallet_connect_cubit.freezed.dart';
part '../../../../generated/features/wallet_connect/infrastructure/cubit/wallet_connect_cubit.g.dart';
part 'wallet_connect_state.dart';

@LazySingleton(as: IWalletConnectCubit)
class WalletConnectCubit extends Cubit<WalletConnectState>
    implements IWalletConnectCubit {
  @override
  final IWalletConnectStore wcStore;
  @override
  SignClient? signClient;
  IErrorLogger errorLogger;
  WalletConnectCubit({required this.errorLogger, required this.wcStore})
      : super(WalletConnectState.initial());

  @override
  started() async {
    await initialize();
    getSessionAndPairings();
    await getPreviouslyConnectedSession();
  }

  /// To initialize the Wallet connect client with metadata
  @override
  initialize() async {
    try {
      signClient = await SignClient.init(
        projectId: WalletConnectConfig.projectId,
        relayUrl: WalletConnectConfig.relayUrl,
        metadata: WalletConnectConfig.metadata,
        database: WalletConnectConfig.database,
        logger: Logger(level: Level.error),
      );
      log(signClient?.name ?? "error");
    } catch (e, stack) {
      errorLogger.logError(e, stack);
    }
  }

  /// To implement autologin for the user
  @override
  getPreviouslyConnectedSession() async {
    if ((signClient?.session.values.isNotEmpty ?? false) &&
        signClient?.session.values.last != null) {
      var res = signClient?.session.values.last;
      log("reconnected : ${res?.peer.metadata.name}");
      emit(state.copyWith(
        activeSession: res,
        failure: false,
        sessions: signClient!.session.getAll(),
        activeChainId: WCHelper.getChainIdFromAccountStr(
            res!.namespaces[ChainType.eip155.name]!.accounts.first),
        activeAddress: WCHelper.getAddressFromAccountStr(
            res.namespaces[ChainType.eip155.name]!.accounts.first),
        connected: true,
        loadingConnection: false,
        failureConnection: false,
        approvedChains: res.namespaces[ChainType.eip155.name]!.accounts
            .map((e) =>
                int.parse(WCHelper.getChainIdFromAccountStr(e).split(":")[1]))
            .toList(),
        signVerified: await wcStore.doesSignExist(
          topicID: res.topic,
          activeAddress: WCHelper.getAddressFromAccountStr(
              res.namespaces[ChainType.eip155.name]!.accounts.first),
        ),
      ));
    }
  }

  @override
  getSessionAndPairings() {
    final sessions = signClient!.session.getAll();
    final pairings = signClient!.core.pairing.getPairings();
    emit(state.copyWith(sessions: sessions, pairings: pairings));
  }

  @override
  String? getChain() {
    return state.activeChainId;
  }

  @override
  List<int>? get approvedChains => state.approvedChains;

  @override
  String? getActiveAdddress() {
    return state.activeAddress;
  }

  /// To send Wallet connect connection request for the user
  @override
  Future<bool> getConnectRequest(List<String> chainIds) async {
    EngineConnection? res =
        await signClient?.connect(Eip155Data.getSessionConnectParams(chainIds));
    emit(state.copyWith(
      failure: false,
      failureConnection: false,
      connected: false,
      loadingConnection: true,
    ));
    res?.approval?.then((value) async {
      await signClient!.ping(value.topic);
      getSessionAndPairings();
      emit(state.copyWith(
        activeSession: value,
        failure: false,
        sessions: signClient!.session.getAll(),
        activeChainId: WCHelper.getChainIdFromAccountStr(
            value.namespaces[ChainType.eip155.name]!.accounts.first),
        activeAddress: WCHelper.getAddressFromAccountStr(
            value.namespaces[ChainType.eip155.name]!.accounts.first),
        connected: true,
        failureConnection: false,
        loadingConnection: false,
        approvedChains: value.namespaces[ChainType.eip155.name]!.accounts
            .map((e) =>
                int.parse(WCHelper.getChainIdFromAccountStr(e).split(":")[1]))
            .toList(),
      ));
      log("connected");
      return true;
    }).catchError((e) {
      debugPrint("Connection error $e");
      errorLogger.logError(
          e, StackTrace.fromString("wallet connect cubit.dart"));

      emit(state.copyWith(
        failure: false,
        failureConnection: true,
        connected: false,
        loadingConnection: false,
      ));
      log("failed");
      return false;
    });
    return await launchUrlString(res!.uri!);
  }

  @override
  Future<String> getPersonalSign(
    String data,
  ) async {
    try {
      emit(state.copyWith(
        txLoading: true,
        txSucesess: false,
        txFailure: false,
      ));
      if (state.activeSession != null) {
        emit(state.copyWith(txLoading: true));
        SessionRequestParams params = Eip155Data.getRequestParams(
          topic: state.activeSession!.topic,
          method: Eip155Methods.PERSONAL_SIGN,
          chainId: state.activeChainId!,
          address: state.activeAddress!,
          data: data,
        );
        var res = await signClient?.request(params);
        emit(state.copyWith(
          txLoading: false,
          txSucesess: true,
          txFailure: false,
        ));

        return res;
      } else {
        throw Exception("No active Session");
      }
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      emit(state.copyWith(
        txLoading: false,
        txSucesess: false,
        txFailure: true,
      ));
      return "";
    }
  }

  /// Should only be used to get the login message sign from the user
  @override
  Future<String> getLoginEthSign(String data) async {
    if (state.activeSession != null) {
      try {
        SessionRequestParams params = Eip155Data.getRequestParams(
          topic: state.activeSession!.topic,
          method: Eip155Methods.ETH_SIGN,
          chainId: state.activeChainId!,
          address: state.activeAddress!,
          data: data,
        );
        log("getEthSign");
        emit(state.copyWith(
          failure: false,
          failureSign: false,
          loadingSign: true,
          signVerified: false,
          txLoading: true,
          txSucesess: false,
          txFailure: false,
        ));

        var res = await signClient?.request(params);
        if (res.isNotEmpty || res != "") {
          final isVerified = SigChecker.checkSignature(
              activeAddress: state.activeAddress,
              unhexedMessage: WalletConnectConfig.signMessageData,
              signature: res);
          if (isVerified) {
            wcStore.addSignature(
                topicID: state.activeSession!.topic, signature: res);
            emit(state.copyWith(
              failure: false,
              failureSign: false,
              loadingSign: false,
              signVerified: true,
              txLoading: false,
              txSucesess: true,
              txFailure: false,
            ));
          }
          return res;
        } else {
          errorLogger.logError("getLoginEthSign failed",
              StackTrace.fromString("getLoginEthSign"));

          emit(state.copyWith(
            failure: false,
            failureSign: true,
            loadingSign: false,
            signVerified: false,
            txLoading: false,
            txSucesess: false,
            txFailure: true,
          ));
          debugPrint("getLoginEthSign failed");
          return "";
        }
      } catch (e, stack) {
        errorLogger.logError(e, stack);

        emit(state.copyWith(
          failure: false,
          failureSign: true,
          loadingSign: false,
          signVerified: false,
          txLoading: false,
          txSucesess: false,
          txFailure: true,
        ));
        debugPrint(e.toString());
        debugPrint(stack.toString());
        return "";
      }
    } else {
      emit(state.copyWith(
        failure: false,
        failureSign: true,
        loadingSign: false,
        signVerified: false,
        txLoading: false,
        txSucesess: false,
        txFailure: true,
      ));
      throw Exception("No active Session");
    }
  }

  @override
  Future<String> getEthSign(String data) async {
    if (state.activeSession != null) {
      try {
        SessionRequestParams params = Eip155Data.getRequestParams(
          topic: state.activeSession!.topic,
          method: Eip155Methods.ETH_SIGN,
          chainId: state.activeChainId!,
          address: state.activeAddress!,
          data: data,
        );
        log("getEthSign");
        emit(state.copyWith(
          txLoading: true,
          txSucesess: false,
          txFailure: false,
        ));

        var res = await signClient?.request(params);
        emit(state.copyWith(
          txLoading: false,
          txSucesess: true,
          txFailure: false,
        ));
        return res;
      } catch (e, stack) {
        errorLogger.logError(e, stack);

        emit(state.copyWith(
          txLoading: false,
          txSucesess: false,
          txFailure: true,
        ));
        debugPrint(e.toString());
        debugPrint(stack.toString());
        return "";
      }
    } else {
      emit(state.copyWith(
        txLoading: false,
        txSucesess: false,
        txFailure: true,
      ));
      throw Exception("No active Session");
    }
  }

  @override
  Future<String> getEthSignTypedData(String data) async {
    try {
      emit(state.copyWith(
        txLoading: true,
        txSucesess: false,
        txFailure: false,
      ));
      if (state.activeSession != null) {
        SessionRequestParams params = Eip155Data.getRequestParams(
          topic: state.activeSession!.topic,
          method: Eip155Methods.ETH_SIGN_TYPED_DATA,
          chainId: state.activeChainId!,
          address: state.activeAddress!,
          data: data,
        );

        var res = await signClient?.request(params);
        emit(state.copyWith(
          txLoading: false,
          txSucesess: true,
          txFailure: false,
        ));
        return res;
      } else {
        emit(state.copyWith(
          txLoading: false,
          txSucesess: false,
          txFailure: true,
        ));
        throw Exception("No active Session");
      }
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      emit(state.copyWith(
        txLoading: false,
        txSucesess: false,
        txFailure: true,
      ));
      return "";
    }
  }

  @override
  getEthSignTransaction(EthereumTransaction transaction, int chainId) async {
    try {
      emit(state.copyWith(
        txLoading: true,
        txSucesess: false,
        txFailure: false,
      ));
      if (state.activeSession != null) {
        SessionRequestParams params = Eip155Data.getRequestParams(
          topic: state.activeSession!.topic,
          method: Eip155Methods.ETH_SIGN_TRANSACTION,
          chainId: chainId.toString(),
          address: state.activeAddress!,
          transaction: transaction,
        );

        var res = await signClient?.request(params);
        emit(state.copyWith(
          txLoading: false,
          txSucesess: true,
          txFailure: false,
        ));
        return res;
      } else {
        emit(state.copyWith(
          txLoading: false,
          txSucesess: false,
          txFailure: true,
        ));
        throw Exception("No active Session");
      }
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      emit(state.copyWith(
        txLoading: false,
        txSucesess: false,
        txFailure: true,
      ));
    }
  }

  @override
  getEthSendTransaction(EthereumTransaction transaction, int chainId) async {
    try {
      emit(state.copyWith(
        txLoading: true,
        txSucesess: false,
        txFailure: false,
      ));
      if (state.activeSession != null) {
        SessionRequestParams params = Eip155Data.getRequestParams(
          topic: state.activeSession!.topic,
          method: Eip155Methods.ETH_SEND_TRANSACTION,
          chainId: "eip155:${chainId.toString()}",
          address: state.activeAddress!,
          transaction: transaction,
        );

        var res = await signClient?.request(params);
        emit(state.copyWith(
          txLoading: false,
          txSucesess: true,
          txFailure: false,
        ));
        return res;
      } else {
        emit(state.copyWith(
          txLoading: false,
          txSucesess: false,
          txFailure: true,
        ));
        throw Exception("No active Session");
      }
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      emit(state.copyWith(
        txLoading: false,
        txSucesess: false,
        txFailure: true,
      ));
      return "";
    }
  }

  @override
  Future<void> disconnect(String topic) async {
    await signClient!.disconnect(
      topic: topic,
      reason: getSdkError(SdkErrorKey.USER_DISCONNECTED),
    );
    wcStore.removeSignature(topic);
    getSessionAndPairings();
  }

  @override
  disconnectAll() async {
    log("message");
    for (var element in state.sessions) {
      try {
        await signClient!.disconnect(
          topic: element.topic,
          reason: getSdkError(SdkErrorKey.USER_DISCONNECTED),
        );
        wcStore.clearBox();
        emit(WalletConnectState.initial());
      } catch (e, stack) {
        errorLogger.logError(e, stack);

        log(" ${e.toString()}: $stack");
      }
    }
    emit(WalletConnectState.initial());
    getSessionAndPairings();
  }

// returns topic->AccountList
  @override
  Map<String, List<ConnectedAccount>> getAllConnectedAccounts() {
    Map<String, List<ConnectedAccount>> accountList = {};
    for (var element in state.sessions) {
      accountList[element.topic] =
          WCHelper.getConnectedAccountForSession(element);
    }
    return accountList;
  }

  @override
  String getMessageToSign(String unhexedMessage) {
    final messageBytes = Uint8List.fromList(unhexedMessage.codeUnits);
    return bytesToHex(messageBytes, include0x: true);
  }
}
