import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/saved_pwa/infrastructure/entities/saved_dapp_model.dart';

abstract class ISavedPwaStore {
  Future<SavedPwaModel?> addDapp(DappInfo dappInfo);
  Future<bool> removeDapp(String dappId);
  Future<Map<dynamic, SavedPwaModel>?> getSavedDapps();
  Future<bool> clearBox();
}
