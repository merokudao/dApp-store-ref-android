import 'package:dappstore/features/wallet_connect/infrastructure/entities/wallet_connect_store_model.dart';

abstract class IWalletConnectStore {
  Future<WalletConnectStoreModel?> addSignature(
      {required String topicID, required String signature});
  Future<bool> removeSignature(String topicID);
  Future<Map<dynamic, WalletConnectStoreModel>?> getSignatureMap();
  Future<bool> clearBox();
  Future<bool> doesSignExist(
      {required String topicID, required String activeAddress});
}
