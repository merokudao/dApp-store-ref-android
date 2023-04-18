import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
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

abstract class IDataSource {
  Future<DappListDto?> getDappList({
    GetDappQueryDto? queryParams,
  });

  Future<DappInfoDto?> getDappInfo({GetDappInfoQueryDto? queryParams});

  Future<List<DappInfoDto>?> searchDapps(String searchString);

  Future<List<CuratedListDto>?> getCuratedList();
  Future<List<CuratedCategoryListDto>?> getCuratedCategoryList();
  Future<DappListDto?> getFeaturedDappsList();
  Future<DappListDto?> getFeaturedDappsByCategory({required String category});
  BuildUrlDto? getBuildUrl(String dappId, String address);
  String getPwaRedirectionUrl(String dappId, String walletAddress);
  Future<Map<String, DappInfo?>> getDappsByPackageId(List<String> packageIds);
  Future<bool> postRating(
    PostRatingDto ratingData,
  );
  Future<RatingListDto?> getRating({
    required RatingListQueryDto params,
  });
  Future<PostRatingDto?> getUserRating(String dappId, String address);
  Future<bool> postRatingDsk(
    PostRatingDto ratingData,
  );
}
