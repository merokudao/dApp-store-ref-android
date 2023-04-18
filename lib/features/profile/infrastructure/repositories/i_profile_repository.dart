import 'package:dappstore/features/profile/infrastructure/models/profile_model.dart';
import 'package:dappstore/features/profile/infrastructure/store/i_profile_store.dart';

abstract class IProfileRepo {
  final IProfileStore profileStore;

  IProfileRepo({required this.profileStore});

  Future<ProfileModel?> getProfile({required String address});

  Future<bool> postProfile({required ProfileModel profile});
}
