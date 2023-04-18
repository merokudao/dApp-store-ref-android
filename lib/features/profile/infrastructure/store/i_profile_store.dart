import 'package:dappstore/features/profile/infrastructure/models/profile_store_model.dart';

abstract class IProfileStore {
  Future<ProfileStoreModel?> addProfile({required ProfileStoreModel model});
  Future<bool> removeProfile(String address);
  Future<ProfileStoreModel?> getProfile(String address);
  Future<bool> clearBox();
  Future<bool> doesProfileExist(String address);
}
