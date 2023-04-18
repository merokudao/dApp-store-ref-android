import 'package:dappstore/features/self_update/infrastructure/models/self_update_data_model.dart';

abstract class ISelfUpdateDataSource {
  /// API to check if there is dapp store update available or not
  Future<SelfUpdateDataModel?> getLatestBuild();
}
