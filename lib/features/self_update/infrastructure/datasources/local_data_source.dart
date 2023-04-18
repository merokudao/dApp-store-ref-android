import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/features/self_update/infrastructure/datasources/i_data_sources.dart';
import 'package:dappstore/features/self_update/infrastructure/models/self_update_data_model.dart';

class LocalDataSource implements ISelfUpdateDataSource {
  final Network _network;
  LocalDataSource({required Network network}) : _network = network;

  @override
  Future<SelfUpdateDataModel?> getLatestBuild() async {
    return SelfUpdateDataModel.fromJson({
      "latestBuildNumber": "1",
      "downloadUrl":
          "https://github.com/Abhimanyu121/OpenWallet/releases/download/Alpha2/app-release.apk",
      "minimumSupportedBuildNumber": "1"
    });
  }
}
