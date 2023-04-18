import 'dart:developer';

import 'package:dappstore/config/config.dart';
import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/features/profile/infrastructure/datasources/i_data_sources.dart';
import 'package:dappstore/features/profile/infrastructure/models/profile_model.dart';
import 'package:dio/dio.dart';

class RemoteDataSource implements IDataSource {
  final Network _network;
  RemoteDataSource({required Network network}) : _network = network;

  /// API to get saved profile for the user address
  @override
  Future<ProfileModel?> getProfile({required String address}) async {
    Response res = await _network.get(
        path: "${Config.customApiBaseUrl}/api/v1/fetchuser",
        queryParams: {"walletAddress": address});
    if (res.data[address] == null ||
        res.data[address].toString().toLowerCase() == "null") {
      return null;
    } else {
      return ProfileModel(name: res.data[address], address: address);
    }
  }

  /// API to post the user profile to the server
  @override
  Future<bool> postProfile({required ProfileModel profile}) async {
    try {
      Response res = await _network.post(
          path: "${Config.customApiBaseUrl}/api/v1/postuser",
          data: profile.toJson());
      log(res.toString());
      return true;
    } catch (e, stack) {
      log("${e.toString()} + $stack");
      return false;
    }
  }
}
