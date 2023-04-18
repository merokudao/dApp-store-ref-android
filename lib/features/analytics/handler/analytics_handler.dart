import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/core/store/i_cache_store.dart';
import 'package:dappstore/features/analytics/datasource/i_datasource.dart';
import 'package:dappstore/features/analytics/datasource/remote_datasource.dart';
import 'package:dappstore/features/analytics/dtos/install_analytics_model.dart';
import 'package:dappstore/features/analytics/handler/i_analytics_handler.dart';
import 'package:dappstore/features/wallet_connect/infrastructure/cubit/i_wallet_connect_cubit.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAnalyticsHandler)
class AnalyticsHandler implements IAnalyticsHandler {
  final ICacheStore cacheStore;
  late final Network _network;
  late final IDataSource _dataSource = RemoteDataSource(network: _network);
  AnalyticsHandler({required this.cacheStore}) {
    _network = Network(
      dioClient: Dio(),
      interceptors: cacheStore.dioCacheInterceptor,
    );
  }

  @override
  Future<bool?> installDappEvent(
      {required String dappId, required Map<String, dynamic> metadata}) async {
    final response = await _dataSource.installDappEvent(
        installAnalyticsDTO: InstallAnalyticsDTO(
            dappId: dappId,
            userAddress: getIt<IWalletConnectCubit>().getActiveAdddress()!,
            timestamp: DateTime.now().toIso8601String()));
    return response;
  }
}
