import 'package:dappstore/config/config.dart';
import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/entities/wallet_connect_store_model.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/store/i_wallet_connect_store.dart';
import 'package:dappstore/features/wallet_connect/utils/sign_checker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IWalletConnectStore)
class WalletConnectStore implements IWalletConnectStore {
  final IErrorLogger errorLogger;

  static const savedWalletConnectStoreBox = "SavedWalletConnectStoreBox";

  WalletConnectStore({required this.errorLogger});

  /// To add user login sign to the store to be used for autologin
  @override
  Future<WalletConnectStoreModel?> addSignature(
      {required String topicID, required String signature}) async {
    try {
      Box box;
      if (Hive.isBoxOpen(savedWalletConnectStoreBox)) {
        box = Hive.box(savedWalletConnectStoreBox);
      } else {
        box = await Hive.openBox(savedWalletConnectStoreBox);
      }
      final WalletConnectStoreModel wcStore = WalletConnectStoreModel(
        topidID: topicID,
        signature: signature,
      );
      await box.put(topicID, wcStore);
      await box.close();
      return wcStore;
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return null;
    }
  }

  /// To remove the Login message signature once the user has logged off
  @override
  Future<bool> removeSignature(String topicID) async {
    try {
      Box box;
      if (Hive.isBoxOpen(savedWalletConnectStoreBox)) {
        box = Hive.box(savedWalletConnectStoreBox);
      } else {
        box = await Hive.openBox(savedWalletConnectStoreBox);
      }
      await box.delete(topicID);
      await box.close();
      return true;
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return false;
    }
  }

  @override
  Future<Map<dynamic, WalletConnectStoreModel>?> getSignatureMap() async {
    try {
      final Box<WalletConnectStoreModel> box;
      if (Hive.isBoxOpen(savedWalletConnectStoreBox)) {
        box = Hive.box(savedWalletConnectStoreBox);
      } else {
        box = await Hive.openBox(savedWalletConnectStoreBox);
      }
      await box.close();
      return box.toMap();
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return null;
    }
  }

  /// To check and verify is a sign for login message is already store for user and topic
  @override
  Future<bool> doesSignExist(
      {required String topicID, required String activeAddress}) async {
    Map<dynamic, WalletConnectStoreModel>? map = await getSignatureMap();
    if (map == null) {
      return false;
    } else if (map[topicID] == null) {
      return false;
    } else if (map[topicID] != null) {
      final isVerified = SigChecker.checkSignature(
          activeAddress: activeAddress,
          unhexedMessage: WalletConnectConfig.signMessageData,
          signature: map[topicID]!.signature);

      return true;
    } else {
      return false;
    }
  }

  /// To clear box when user is logging off
  @override
  Future<bool> clearBox() async {
    try {
      Box box;
      if (Hive.isBoxOpen(savedWalletConnectStoreBox)) {
        box = Hive.box(savedWalletConnectStoreBox);
      } else {
        box = await Hive.openBox(savedWalletConnectStoreBox);
      }
      await box.deleteFromDisk();
      await box.close();
      return true;
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return false;
    }
  }
}
