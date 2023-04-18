import 'package:dappstore/features/profile/infrastructure/models/profile_store_model.dart';

class ProfileModel {
  final String name;
  final String address;
  ProfileModel({required this.name, required this.address});
  Map<String, dynamic> toJson() {
    return {address: name};
  }

  ProfileStoreModel toStoreModel() {
    return ProfileStoreModel(address: address, name: name);
  }

  factory ProfileModel.fromStoreModel(ProfileStoreModel model) {
    return ProfileModel(name: model.name, address: model.address);
  }
}
