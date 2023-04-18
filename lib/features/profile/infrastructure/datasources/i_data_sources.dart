import 'package:dappstore/features/profile/infrastructure/models/profile_model.dart';

abstract class IDataSource {
  /// API to get saved profile for the user address
  Future<ProfileModel?> getProfile({
    required String address,
  });

  /// API to post the user profile to the server
  Future<bool> postProfile({
    required ProfileModel profile,
  });
}
