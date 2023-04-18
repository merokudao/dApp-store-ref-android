import 'package:dappstore/features/dapp_store_home/domain/entities/curated_category_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/curated_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_list.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/post_rating.dart';
import 'package:dappstore/features/dapp_store_home/domain/entities/rating_list.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/rating_list_query_dto.dart';

abstract class IDappListRepo {
  Future<DappList?> getDappList({GetDappQueryDto? queryParams});

  Future<DappInfo?> getDappInfo({GetDappInfoQueryDto? queryParams});

  Future<List<CuratedList>?> getCuratedList();
  Future<List<CuratedCategoryList>?> getCuratedCategoryList();
  Future<DappList?> getFeaturedDappsList();
  Future<DappList?> getFeaturedDappsByCategory({required String category});
  String? getBuildUrl(String dappId, String address);
  String getPwaRedirectionUrl(String dappId, String walletAddress);
  Future<Map<String, DappInfo?>> queryWithPackageId({
    required List<String> pacakgeIds,
  });

  Future<bool> postRating({
    required PostRating ratingData,
  });

  Future<RatingList?> getRating({
    required RatingListQueryDto params,
  });

  Future<PostRating?> getUserRating({
    required String dappId,
    required String address,
  });
}
