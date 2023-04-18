import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/features/profile/infrastructure/models/profile_store_model.dart';
import 'package:dappstore/features/profile/infrastructure/store/i_profile_store.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IProfileStore)
class ProfileStore implements IProfileStore {
  final IErrorLogger errorLogger;

  static const savedProfileStoreBox = "SavedProfileStoreBox";

  ProfileStore({required this.errorLogger});

  @override
  Future<ProfileStoreModel?> addProfile(
      {required ProfileStoreModel model}) async {
    try {
      Box box;
      if (Hive.isBoxOpen(savedProfileStoreBox)) {
        box = Hive.box(savedProfileStoreBox);
      } else {
        box = await Hive.openBox(savedProfileStoreBox);
      }

      await box.put(model.address, model);
      await box.close();
      return model;
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return null;
    }
  }

  @override
  Future<bool> removeProfile(String address) async {
    try {
      Box box;
      if (Hive.isBoxOpen(savedProfileStoreBox)) {
        box = Hive.box(savedProfileStoreBox);
      } else {
        box = await Hive.openBox(savedProfileStoreBox);
      }
      await box.delete(address);
      await box.close();
      return true;
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return false;
    }
  }

  @override
  Future<ProfileStoreModel?> getProfile(String address) async {
    try {
      final Box<ProfileStoreModel> box;
      if (Hive.isBoxOpen(savedProfileStoreBox)) {
        box = Hive.box(savedProfileStoreBox);
      } else {
        box = await Hive.openBox(savedProfileStoreBox);
      }
      await box.close();
      return box.toMap()[address];
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      return null;
    }
  }

  @override
  Future<bool> doesProfileExist(String address) async {
    ProfileStoreModel? profile = await getProfile(address);
    if (profile == null) {
      return false;
    } else {
      return false;
    }
  }

  @override
  Future<bool> clearBox() async {
    try {
      Box box;
      if (Hive.isBoxOpen(savedProfileStoreBox)) {
        box = Hive.box(savedProfileStoreBox);
      } else {
        box = await Hive.openBox(savedProfileStoreBox);
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
