import 'package:dappstore/features/self_update/infrastructure/models/self_update_data_model.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class ISelfUpdateRepo {
  Future<SelfUpdateDataModel?> getLatestBuild();
  Future<PackageInfo?> getAppVersion();
}
