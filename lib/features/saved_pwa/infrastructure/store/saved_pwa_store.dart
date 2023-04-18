import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/saved_pwa/infrastructure/entities/saved_dapp_model.dart';
import 'package:dappstore/features/saved_pwa/infrastructure/store/i_saved_pwa_store.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISavedPwaStore)
class SavedPwaStore implements ISavedPwaStore {
  final IErrorLogger errorLogger;

  static const savedPwaStoreBox = "SavedPwaStoreBox";

  SavedPwaStore({required this.errorLogger});
  @override
  Future<SavedPwaModel?> addDapp(DappInfo dappInfo) async {
    try {
      Box<SavedPwaModel> box = await _getBox();
      final SavedPwaModel savedPwa = SavedPwaModel(
        name: dappInfo.name!,
        dappId: dappInfo.dappId!,
        logo: dappInfo.images?.logo,
        banner: dappInfo.images?.banner,
        subtitle: "${dappInfo.developer?.legalName} · ${dappInfo.category}",
      );
      await box.put(dappInfo.dappId!, savedPwa);
      return savedPwa;
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return null;
    }
  }

  @override
  Future<bool> removeDapp(String dappId) async {
    try {
      Box<SavedPwaModel> box = await _getBox();

      await box.delete(dappId);
      return true;
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return false;
    }
  }

  @override
  Future<Map<dynamic, SavedPwaModel>?> getSavedDapps() async {
    try {
      Box<SavedPwaModel> box = await _getBox();
      return box.toMap();
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return null;
    }
  }

  @override
  Future<bool> clearBox() async {
    try {
      Box<SavedPwaModel> box = await _getBox();
      await box.deleteFromDisk();
      return true;
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return false;
    }
  }

  Future<Box<SavedPwaModel>> _getBox() async {
    Box<SavedPwaModel> box;
    if (Hive.isBoxOpen(savedPwaStoreBox)) {
      box = Hive.box(savedPwaStoreBox);
    } else {
      box = await Hive.openBox<SavedPwaModel>(savedPwaStoreBox);
    }
    return box;
  }
}
