import 'package:dappstore/config/config.dart';
import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/datasources/i_data_source.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/build_url_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/curated_category_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/curated_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_info_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/post_rating_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/rating_list_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/rating_list_query_dto.dart';
import 'package:dio/dio.dart';

class RemoteDataSource implements IDataSource {
  final Network _network;
  final IErrorLogger errorLogger = getIt<IErrorLogger>();
  RemoteDataSource({required Network network}) : _network = network;

  /// To get the dapp list based on [queryParams]
  @override
  Future<DappListDto?> getDappList({
    GetDappQueryDto? queryParams,
  }) async {
    try {
      Response res = await _network.get(
          path: "${Config.customApiBaseUrl}/api/v1/dapp",
          queryParams: queryParams?.toJson());

      return DappListDto.fromJson(res.data);
    } catch (e, stack) {
      errorLogger.logError(e, stack);
    }
    return null;
  }

  /// To get a dappinfo bsed on [queryParams]
  @override
  Future<DappInfoDto?> getDappInfo({GetDappInfoQueryDto? queryParams}) async {
    try {
      Response res = await _network.get(
          path: "${Config.customApiBaseUrl}/api/v1/dapp/searchById",
          queryParams: queryParams?.toJson());
      return DappInfoDto.fromJson(res.data[0]);
    } catch (e, stack) {
      errorLogger.logError(e, stack);
    }
    return null;
  }

  /// not used
  /// using getDappList along with [searchstring] inside the query params
  /// still this is here for any custom implementations of API whenever needed
  @override
  Future<List<DappInfoDto>?> searchDapps(String searchString) async {
    //dio api call here
    try {
      return [DappInfoDto()];
    } catch (e, stack) {
      errorLogger.logError(e, stack);
    }
    return null;
  }

  /// To get curated list of dapp category from the registry
  /// currently this is not being used in the app and an custom implementation is used instead
  /// still this is kept here for any future use if required
  @override
  Future<List<CuratedListDto>> getCuratedList() async {
    // not used anymore
    Response res = await _network.get(
      path: "${Config.registryApiBaseUrl}/store/featured",
    );
    List<CuratedListDto> list =
        (res.data as List).map((i) => CuratedListDto.fromJson(i)).toList();
    return list;
  }

  /// To get Curated category list from server
  /// this is a custom implementation to directly get [CuratedCategoryListDto]
  @override
  Future<List<CuratedCategoryListDto>?> getCuratedCategoryList() async {
    try {
      Response res = await _network.get(
        path: "${Config.customApiBaseUrl}/api/v1/categories",
      );
      List<CuratedCategoryListDto> list = (res.data as List)
          .map((e) => CuratedCategoryListDto.fromJson(e))
          .toList();
      return list;
    } catch (e, stack) {
      errorLogger.logError(e, stack);
    }
    return null;
  }

  /// To get featured dapps by category list from server
  /// this is a custom implementation to directly get [DappListDto]
  @override
  Future<DappListDto?> getFeaturedDappsByCategory(
      {required String category}) async {
    try {
      Response res = await _network.get(
        // path: "${Config.registryApiBaseUrl}/dapp",
        // queryParams: GetDappQueryDto(limit: 20).toJson()
        path: "${Config.customApiBaseUrl}/api/v1/categories/categorydapps",
        queryParams:
            GetDappQueryDto(limit: 20, categories: [category]).toJson(),
      );

      return DappListDto.fromJson(res.data);
    } catch (e, stack) {
      errorLogger.logError(e, stack);
    }
    return null;
  }

  /// To get featured dapps list from server
  /// this is a custom implementation to directly get [DappListDto]
  @override
  Future<DappListDto?> getFeaturedDappsList() async {
    try {
      Response res = await _network.get(
        path: "${Config.customApiBaseUrl}/api/v1/store/featured",
        queryParams: GetDappQueryDto(limit: 20).toJson(),
      );

      return DappListDto.fromJson(res.data);
    } catch (e, stack) {
      errorLogger.logError(e, stack);
    }
    return null;
  }

  /// To get build URL from the registry
  @override
  BuildUrlDto? getBuildUrl(String dappId, String address) {
    final url =
        "${Config.registryApiBaseUrl}/o/download/$dappId?userAddress=$address";

    return BuildUrlDto.fromJson({"url": url, "success": true});
  }

  /// To get dapp by package id from server
  /// this is a custom implementation to directly get [DappInfo]
  /// for a list of [packageIds] passed as a queryParam
  @override
  Future<Map<String, DappInfo?>> getDappsByPackageId(
      List<String> packageIds) async {
    try {
      final packagesList = packageIds.join(",");
      final url =
          "${Config.customApiBaseUrl}/api/v1/dapp/queryWithPackageId?packages=$packagesList";
      Response res = await _network.get(
        path: url,
      );
      final data = res.data["response"] as Map<String, dynamic>;
      final Map<String, DappInfo> mapping = {};
      data.forEach((key, value) {
        if (value != null) {
          mapping[key] = DappInfo.fromJson(value);
        }
      });
      return mapping;
    } catch (e, stack) {
      errorLogger.logError(e, stack);
    }
    return {};
  }

  /// To get PWA redirection URl for a dapp and user
  @override
  String getPwaRedirectionUrl(String dappId, String walletAddress) {
    return "${Config.registryApiBaseUrl}/o/view/$dappId?userAddress=$walletAddress";
  }

  /// To post dapp rating on the server
  /// this is a custom implementation to post rating data on server only
  @override
  Future<bool> postRating(
    PostRatingDto ratingData,
  ) async {
    try {
      Response res = await _network.post(
          path: "${Config.customApiBaseUrl}/api/v1/dapp/rate",
          data: ratingData.toJson());
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e, stack) {
      errorLogger.logError(e, stack);
    }
    return false;
  }

  /// To post dapp rating on regisrty
  @override
  Future<bool> postRatingDsk(
    PostRatingDto ratingData,
  ) async {
    try {
      Response res = await _network.post(
          path: "${Config.registryApiBaseUrl}/dapp/rate",
          data: ratingData.toJson());
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e, stack) {
      errorLogger.logError(e, stack);
    }
    return false;
  }

  /// To get dapp ratings from server
  /// this is a custom implementation to directly get [RatingListDto]
  /// for a list of [params] passed as a queryParam
  @override
  Future<RatingListDto?> getRating({
    required RatingListQueryDto params,
  }) async {
    try {
      Response res = await _network.get(
        path: "${Config.customApiBaseUrl}/api/v1/reviews",
        queryParams: params.toJson(),
      );
      return RatingListDto.fromJson(res.data);
    } catch (e, stack) {
      errorLogger.logError(e, stack);
      return null;
    }
  }

  /// To get dapp ratings from server for [address]
  /// this is a custom implementation to directly get [PostRatingDto]
  /// for [dappId] and [address] passed as a queryParam
  @override
  Future<PostRatingDto?> getUserRating(
    String dappId,
    String address,
  ) async {
    try {
      Response res = await _network.get(
          path: "${Config.customApiBaseUrl}/api/v1/dapp/rate",
          queryParams: {
            "dappId": dappId,
            "userAddress": address,
          });
      if ((res.statusCode ?? 400) < 400 && (res.data as Map).isNotEmpty) {
        final data = PostRatingDto.fromJson(res.data);
        if (data.rating == null) {
          return null;
        }
        return data;
      } else {
        return null;
      }
    } catch (e, stack) {
      errorLogger.logError(e, stack);
    }
    return null;
  }
}
