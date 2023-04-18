import 'package:dappstore/config/config.dart';
import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/features/analytics/datasource/i_datasource.dart';
import 'package:dappstore/features/analytics/dtos/install_analytics_model.dart';
import 'package:dio/dio.dart';

class RemoteDataSource implements IDataSource {
  final Network _network;
  RemoteDataSource({required Network network}) : _network = network;
  @override
  Future<bool?> installDappEvent(
      {required InstallAnalyticsDTO installAnalyticsDTO}) async {
    try {
      Response res = await _network.post(
          path: "${Config.customApiBaseUrl}/api/v1/analytics",
          data: {"analytics": installAnalyticsDTO.toJson()});

      return res.data != null;
    } catch (e, stack) {
      getIt<IErrorLogger>().logError(e, stack);
    }
    return null;
  }
}
