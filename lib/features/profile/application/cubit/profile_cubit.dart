import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/features/profile/application/cubit/i_profile_cubit.dart';
import 'package:dappstore/features/profile/infrastructure/models/profile_model.dart';
import 'package:dappstore/features/profile/infrastructure/repositories/i_profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part '../../../../generated/features/profile/application/cubit/profile_cubit.freezed.dart';
part '../../../../generated/features/profile/application/cubit/profile_cubit.g.dart';
part 'profile_state.dart';

@LazySingleton(as: IProfileCubit)
class ProfileCubit extends Cubit<ProfileState> implements IProfileCubit {
  @override
  final IProfileRepo profileRepo;
  IErrorLogger errorLogger;

  ProfileCubit({
    required this.errorLogger,
    required this.profileRepo,
  }) : super(ProfileState.initial());

  @override
  getProfile({required String address}) async {
    ProfileModel? model = await profileRepo.getProfile(address: address);
    if (model != null) {
      emit(state.copyWith(name: model.name, address: model.address));
      return model;
    } else {
      return null;
    }
  }

  @override
  postProfile({required ProfileModel model}) async {
    bool res = await profileRepo.postProfile(profile: model);
    if (res) {
      emit(state.copyWith(address: model.address, name: model.name));
    }
    return res;
  }
}
