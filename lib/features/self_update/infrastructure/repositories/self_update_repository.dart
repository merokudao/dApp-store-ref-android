import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/core/store/i_cache_store.dart';
import 'package:dappstore/features/self_update/infrastructure/datasources/i_data_sources.dart';
import 'package:dappstore/features/self_update/infrastructure/datasources/local_data_source.dart';
import 'package:dappstore/features/self_update/infrastructure/datasources/remote_data_source.dart';
import 'package:dappstore/features/self_update/infrastructure/models/self_update_data_model.dart';
import 'package:dappstore/features/self_update/infrastructure/repositories/i_self_update_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

@LazySingleton(as: ISelfUpdateRepo)
class SelfUpdateRepoImpl implements ISelfUpdateRepo {
  final ICacheStore cacheStore;
  final IErrorLogger errorLogger;
  late final Network _network =
      Network(dioClient: Dio(), interceptors: cacheStore.dioCacheInterceptor);
  late final ISelfUpdateDataSource _dataSource =
      RemoteDataSource(network: _network);
  late final ISelfUpdateDataSource _localDataSource =
      LocalDataSource(network: _network);

  @override
  SelfUpdateRepoImpl({
    required this.cacheStore,
    required this.errorLogger,
  });

  @override
  Future<SelfUpdateDataModel?> getLatestBuild() async {
    try {
      SelfUpdateDataModel? selfUpdateDataModel =
          await _dataSource.getLatestBuild();
      return selfUpdateDataModel;
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      debugPrint("Self Update error ${e.toString()}");
      return null;
    }
  }

  @override
  Future<PackageInfo?> getAppVersion() async {
    try {
      final package = await PackageInfo.fromPlatform();
      return package;
    } catch (e, stack) {
      errorLogger.logError(e, stack);

      debugPrint("Self Update error ${e.toString()}");
      return null;
    }
  }
}
