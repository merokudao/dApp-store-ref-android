import 'dart:convert';

import 'package:dappstore/config/config.dart';
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
import 'package:dappstore/utils/typedef.dart';
import 'package:dio/dio.dart';

class LocalDataSource implements IDataSource {
  final Network _network;
  LocalDataSource({required Network network}) : _network = network;

  @override
  Future<DappListDto> getDappList({
    GetDappQueryDto? queryParams,
  }) async {
    return DappListDto.fromJson({
      "page": 0,
      "pageCount": 1,
      "limit": 10,
      "response": [
        {
          "name": "Axie Infinity",
          "description":
              "Axie Infinity is a Pokemon-inspired digital pet universe where players use their cute characters called Axies in various games. The Axie Infinity Universe highlights the benefits of blockchain technology through \"Free to Play to Earn\" gameplay and a player-owned economy.",
          "appUrl": "https://app.aave.com/",
          "images": {
            "logo":
                "https://dashboard-assets.dappradar.com/document/9495/axieinfinity-dapp-games-ronin-logo_1ec806d57fd80ab68d351658cb8d146a.png",
            "screenshots": [
              "https://dummyimage.com/200x800.png",
              "https://dummyimage.com/200x800.png",
              "https://dummyimage.com/200x800.png",
              "https://dummyimage.com/200x800.png",
            ]
          },
          "minAge": 13,
          "isForMatureAudience": false,
          "isSelfModerated": true,
          "language": "en",
          "version": "20000",
          "packageId": "com.trellis.OpenWallet",
          "isListed": true,
          "listDate": "2023-01-30",
          "availableOnPlatform": ["web", "android"],
          "category": "games",
          "chains": [1],
          "dappId": "exchange.quickswap.dapp",
          "metrics": {
            "dappId": "exchange.quickswap.dapp",
            "downloads": 0,
            "installs": 0,
            "uninstalls": 0,
            "ratingsCount": 0,
            "visits": 0,
            "rating": null
          }
        }
      ]
    });
  }

  @override
  Future<DappInfoDto?> getDappInfo({GetDappInfoQueryDto? queryParams}) async {
    return DappInfoDto.fromJson({
      "name": "Axie Infinity",
      "description":
          "Axie Infinity is a Pokemon-inspired digital pet universe where players use their cute characters called Axies in various games. The Axie Infinity Universe highlights the benefits of blockchain technology through \"Free to Play to Earn\" gameplay and a player-owned economy.",
      "appUrl": "https://app.aave.com/",
      "images": {
        "logo":
            "https://dashboard-assets.dappradar.com/document/9495/axieinfinity-dapp-games-ronin-logo_1ec806d57fd80ab68d351658cb8d146a.png",
        "screenshots": [
          "https://dummyimage.com/200x800.png",
          "https://dummyimage.com/200x800.png",
          "https://dummyimage.com/200x800.png",
          "https://dummyimage.com/200x800.png",
        ]
      },
      "minAge": 13,
      "isForMatureAudience": false,
      "isSelfModerated": true,
      "packageId": "com.trellis.OpenWallet",
      "language": "en",
      "version": "unknown",
      "isListed": true,
      "listDate": "2023-01-30",
      "availableOnPlatform": ["web", "android"],
      "category": "games",
      "chains": [1],
      "dappId": "exchange.quickswap.dapp",
      "metrics": {
        "dappId": "exchange.quickswap.dapp",
        "downloads": 0,
        "installs": 0,
        "uninstalls": 0,
        "ratingsCount": 0,
        "visits": 0,
        "rating": null
      }
    });
  }

  @override
  Future<List<DappInfoDto>> searchDapps(String searchString) async {
    //dio api call
    return [DappInfoDto()];
  }

  @override
  Future<List<CuratedListDto>> getCuratedList() async {
    Response res = await _network.get(
      path: "${Config.registryApiBaseUrl}/store/featured",
    );
    List<CuratedListDto> list =
        (res.data as List).map((i) => CuratedListDto.fromJson(i)).toList();
    return list;
  }

  @override
  Future<List<CuratedCategoryListDto>> getCuratedCategoryList() async {
    var str = ''' {
"response": [
{
"category": "Games",
"image": "https://dashboard-assets.dappradar.com/document/3/cryptokitties-dapp-games-eth-logo_43af8137d6219e1fd08b52d9cdfc9447.png"
},
{
"category": "DEfi",
"image": "https://dashboard-assets.dappradar.com/document/3/cryptokitties-dapp-games-eth-logo_43af8137d6219e1fd08b52d9cdfc9447.png"
},
{
"category": "dao",
"image": "https://dashboard-assets.dappradar.com/document/3/cryptokitties-dapp-games-eth-logo_43af8137d6219e1fd08b52d9cdfc9447.png"
},
{
"category": "metaverse",
"image": "https://dashboard-assets.dappradar.com/document/3/cryptokitties-dapp-games-eth-logo_43af8137d6219e1fd08b52d9cdfc9447.png"
},
{
"category": "social",
"image": "https://dashboard-assets.dappradar.com/document/3/cryptokitties-dapp-games-eth-logo_43af8137d6219e1fd08b52d9cdfc9447.png"
},
{
"category": "lifestyle",
"image": "https://dashboard-assets.dappradar.com/document/3/cryptokitties-dapp-games-eth-logo_43af8137d6219e1fd08b52d9cdfc9447.png"
},
{
"category": "abcd",
"image": "https://dashboard-assets.dappradar.com/document/3/cryptokitties-dapp-games-eth-logo_43af8137d6219e1fd08b52d9cdfc9447.png"
},{
"category": "testerr",
"image": "https://dashboard-assets.dappradar.com/document/3/cryptokitties-dapp-games-eth-logo_43af8137d6219e1fd08b52d9cdfc9447.png"
},{
"category": "apps",
"image": "https://dashboard-assets.dappradar.com/document/3/cryptokitties-dapp-games-eth-logo_43af8137d6219e1fd08b52d9cdfc9447.png"
}
]
}''';

    JSON res = await jsonDecode(str);
    List<CuratedCategoryListDto> list = (res['response'] as List)
        .map((i) => CuratedCategoryListDto.fromJson(i))
        .toList();
    return list;
  }

  @override
  Future<DappListDto> getFeaturedDappsByCategory({required String category}) {
    // TODO: implement getFeaturedDappsByCategory
    throw UnimplementedError();
  }

  @override
  Future<DappListDto> getFeaturedDappsList() {
    // TODO: implement getFeaturedDappsList
    throw UnimplementedError();
  }

  @override
  BuildUrlDto? getBuildUrl(String dappId, String address) {
    return BuildUrlDto.fromJson({
      "url":
          "https://github.com/Abhimanyu121/OpenWallet/releases/download/Alpha2/app-release.apk",
      "success": true
    });
  }

  @override
  String getPwaRedirectionUrl(String dappId, String walletAddress) {
    return "${Config.registryApiBaseUrl}/o/view/$dappId?userAddress=$walletAddress";
  }

  @override
  Future<Map<String, DappInfo?>> getDappsByPackageId(
      List<String> packageIds) async {
    const json = {
      "response": {
        "io.floornfts": {
          "name": "Floor: NFTs simplified",
          "description":
              "Introducing the Floor app — the best way to stay connected to your NFTs, and understand the world of NFTs.\\n• Track your NFT portfolio in one place\\n• See live and historic activity for Collections\\n• Understand the value of NFTs with estimated value\\n• Discover collections that are trending and build lists of watched collections!\\n• Watch collections to follow prices and get push notifications for updates\\n• View current OpenSea floor prices and listings\\n• See ETH wallet balances\\n• And more...",
          "appUrl": "https://www.floornfts.io/",
          "dappId": "io.floornfts.dapp",
          "minAge": 13,
          "isForMatureAudience": true,
          "isSelfModerated": false,
          "language": "en",
          "version": "10140200",
          "isListed": true,
          "listDate": "2023-03-27",
          "availableOnPlatform": ["android"],
          "category": "nft",
          "chains": [1, 137],
          "geoRestrictions": {
            "blockedCountries": ["cu", "ir", "kp", "ru", "sy", "ua"]
          },
          "is_featured": true,
          "packageId": "io.floornfts",
          "images": {
            "logo":
                "https://ipfs.io/ipfs/QmRvQV4hXXm4oetmwAVvVa9xEq2dZ8gn9sovnEbrWX3z1Q",
            "banner":
                "https://ipfs.io/ipfs/QmQzFJeKKLMvLfuCFHMHHu9iQ2TrTHtXVsQVueTVScP6yK",
            "screenshots": [
              "https://ipfs.io/ipfs/QmSC7DPQ3wngtjXtWmFff45Rc2aPaLh1SRFJDz6vJ5dEvb",
              "https://ipfs.io/ipfs/QmRxKDPWJ4NpCG2CFv3ygQDHfJdnqBPSwsGNPTnb6Zv6WK",
              "https://ipfs.io/ipfs/QmXdSan3BZicfFoJECDxhLeRTrWErMnhKXPCNf5ESs9s21",
              "https://ipfs.io/ipfs/QmUF76uD1AeuyUjYccHTqbGSe7UU6Pdpog1Y1JAXHFgdZG"
            ]
          },
          "developer": {
            "legalName": "Floor NFTs",
            "logo": null,
            "website": "https://www.floornfts.io/",
            "privacyPolicyUrl": "https://www.floornfts.io/privacy",
            "support": {"email": "support@floornfts.io"},
            "githubID": null
          },
          "metrics": {
            "dappId": "io.floornfts.dapp",
            "downloads": 0,
            "installs": 0,
            "uninstalls": 0,
            "ratingsCount": 0,
            "visits": 0,
            "rating": null
          },
          "users": []
        }
      },
      "status": 200
    };
    final data = json["response"] as Map<String, dynamic>;
    final Map<String, DappInfo> mapping = {};
    data.forEach((key, value) {
      mapping[key] = DappInfo.fromJson(value);
    });
    return mapping;
  }

  @override
  Future<bool> postRating(
    PostRatingDto ratingData,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<RatingListDto?> getRating({
    required RatingListQueryDto params,
  }) async {
    return RatingListDto.fromJson({
      "page": 1,
      "limit": 10,
      "pageCount": 1,
      "response": [
        {
          "dappId": "com.axieinfinity.dapp",
          "rating": 5,
          "comment": "Amazing dapp",
          "userId": null,
          "userName": "Karthik",
          "userAddress": "0x2Ee331840018465bD7Fe74aA4E442b9EA407fBBE"
        },
        {
          "dappId": "com.axieinfinity.dapp",
          "rating": 5,
          "comment": "Its an amazing dapp",
          "userId": null,
          "userName": "Stoic-Jackson",
          "userAddress": "0x7c865c14f9dcDCbFd078C9eD10Be313f2e1012b9"
        }
      ]
    });
  }

  @override
  Future<PostRatingDto?> getUserRating(String dappId, String address) async {
    return PostRatingDto.fromJson({
      "dappId": "com.axieinfinity.dapp",
      "rating": 4,
      "comment": "Amazing dapp",
      "userId": null,
      "username": "Abhi",
      "userAddress": "0x2bD7Fe74aA4E442b9EA407fBBEEe331840018465"
    });
  }

  @override
  Future<bool> postRatingDsk(
    PostRatingDto ratingData,
  ) async {
    throw UnimplementedError();
  }
}
