import 'package:dappstore/core/network/network.dart';
import 'package:dappstore/core/store/i_cache_store.dart';
import 'package:dappstore/features/profile/infrastructure/datasources/i_data_sources.dart';
import 'package:dappstore/features/profile/infrastructure/datasources/remote_data_source.dart';
import 'package:dappstore/features/profile/infrastructure/models/profile_model.dart';
import 'package:dappstore/features/profile/infrastructure/models/profile_store_model.dart';
import 'package:dappstore/features/profile/infrastructure/repositories/i_profile_repository.dart';
import 'package:dappstore/features/profile/infrastructure/store/i_profile_store.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IProfileRepo)
class ProfileRepoImpl implements IProfileRepo {
  final ICacheStore cacheStore;
  late final Network _network =
      Network(dioClient: Dio(), interceptors: cacheStore.dioCacheInterceptor);
  late final IDataSource _dataSource = RemoteDataSource(network: _network);
  @override
  final IProfileStore profileStore;

  ProfileRepoImpl({required this.profileStore, required this.cacheStore});

  @override
  Future<ProfileModel?> getProfile({required String address}) async {
    ProfileStoreModel? profileStoreModel =
        await profileStore.getProfile(address);
    if (profileStoreModel != null) {
      return ProfileModel.fromStoreModel(profileStoreModel);
    } else {
      return _dataSource.getProfile(address: address);
    }
  }

  @override
  Future<bool> postProfile({required ProfileModel profile}) async {
    bool res = await _dataSource.postProfile(profile: profile);
    if (res) {
      await profileStore.addProfile(model: profile.toStoreModel());
    }
    return res;
  }
}
