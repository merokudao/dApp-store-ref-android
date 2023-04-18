import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/core/store/i_cache_store.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/curated_category_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/curated_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/post_rating.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/rating_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/repositories/i_dapp_list_repository.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/datasources/i_data_source.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/datasources/local_data_source.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/datasources/remote_data_source.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/build_url_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/curated_category_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/curated_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_info_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/rating_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/rating_list_query_dto.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IDappListRepo)
class DappListRepoImpl implements IDappListRepo {
  final ICacheStore cacheStore;
  late final Network _network;
  late final IDataSource _dataSource = RemoteDataSource(network: _network);
  late final IDataSource _localDataSource = LocalDataSource(network: _network);
  DappListRepoImpl({required this.cacheStore}) {
    _network = Network(
      dioClient: Dio(),
      interceptors: cacheStore.dioCacheInterceptor,
    );
  }

  @override
  Future<DappList?> getDappList({GetDappQueryDto? queryParams}) async {
    final DappListDto? dappList = await _dataSource.getDappList(
        queryParams: queryParams); // from remote data source
    return dappList?.toDomain();
  }

  @override
  Future<DappInfo?> getDappInfo({GetDappInfoQueryDto? queryParams}) async {
    final DappInfoDto? dappInfo = await _dataSource.getDappInfo(
        queryParams: queryParams); // from remote data source
    return dappInfo?.toDomain();
  }

  @override
  Future<List<CuratedList>?> getCuratedList() async {
    final List<CuratedListDto>? curatedList =
        await _dataSource.getCuratedList();
    final List<CuratedList> list = [];
    if (curatedList != null) {
      for (var element in curatedList) {
        list.add(element.toDomain());
      }
    }
    return list;
  }

  @override
  Future<List<CuratedCategoryList>?> getCuratedCategoryList() async {
    final List<CuratedCategoryListDto>? curatedCategoryList =
        await _dataSource.getCuratedCategoryList();
    final List<CuratedCategoryList> list = [];
    if (curatedCategoryList != null) {
      for (var element in curatedCategoryList) {
        list.add(element.toDomain());
      }
    }
    return list;
  }

  @override
  Future<DappList?> getFeaturedDappsByCategory(
      {required String category}) async {
    final DappListDto? dappList =
        await _dataSource.getFeaturedDappsByCategory(category: category);
    return dappList?.toDomain();
  }

  @override
  Future<DappList?> getFeaturedDappsList() async {
    final DappListDto? dappList = await _dataSource.getFeaturedDappsList();
    return dappList?.toDomain();
  }

  @override
  String? getBuildUrl(String dappId, String address) {
    final BuildUrlDto? dto = _dataSource.getBuildUrl(dappId, address);
    if (dto?.success ?? false) {
      return dto?.url;
    }
    return null;
  }

  @override
  String getPwaRedirectionUrl(String dappId, String walletAddress) {
    final String url =
        _localDataSource.getPwaRedirectionUrl(dappId, walletAddress);
    return url;
  }

  @override
  Future<Map<String, DappInfo?>> queryWithPackageId(
      {required List<String> pacakgeIds}) async {
    final Map<String, DappInfo?> dappListDto =
        await _dataSource.getDappsByPackageId(pacakgeIds);
    return dappListDto;
  }

  @override
  Future<bool> postRating({
    required PostRating ratingData,
  }) async {
    final dskStatus = await _dataSource.postRatingDsk(ratingData.toDto());
    if (dskStatus) {
      final serverStatus = await _dataSource.postRating(ratingData.toDto());
      return serverStatus;
    }
    return false;
  }

  @override
  Future<RatingList?> getRating({
    required RatingListQueryDto params,
  }) async {
    final RatingListDto? dataList = await _dataSource.getRating(params: params);
    return dataList?.toDomain();
  }

  @override
  Future<PostRating?> getUserRating({
    required String dappId,
    required String address,
  }) async {
    final data = await _dataSource.getUserRating(dappId, address);
    if (data != null) {
      var data2 = data.copyWith(userAddress: address, dappId: dappId);
      return data2.toDomain();
    } else {
      return null;
    }
  }
}
