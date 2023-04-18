import 'package:dappstore/config/config.dart';
import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/features/self_update/infrastructure/datasources/i_data_sources.dart';
import 'package:dappstore/features/self_update/infrastructure/models/self_update_data_model.dart';
import 'package:dio/dio.dart';

class RemoteDataSource implements ISelfUpdateDataSource {
  final Network _network;
  final IErrorLogger errorLogger = getIt<IErrorLogger>();
  RemoteDataSource({required Network network}) : _network = network;

  /// API to check if there is dapp store update available or not
  @override
  Future<SelfUpdateDataModel?> getLatestBuild() async {
    try {
      Response res = await _network.get(
        path: "${Config.customApiBaseUrl}/api/v1/dappstoreUpdate",
      );

      return SelfUpdateDataModel.fromJson(res.data);
    } catch (error, stack) {
      errorLogger.logError(error, stack);
      return null;
    }
  }
}
