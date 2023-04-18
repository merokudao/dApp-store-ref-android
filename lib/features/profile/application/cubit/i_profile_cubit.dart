import 'package:dappstore/features/profile/application/cubit/profile_cubit.dart';
import 'package:dappstore/features/profile/infrastructure/models/profile_model.dart';
import 'package:dappstore/features/profile/infrastructure/repositories/i_profile_repository.dart';
import 'package:dappstore/features/profile/infrastructure/repositories/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class IProfileCubit extends Cubit<ProfileState> {
  final IProfileRepo profileRepo;
  IProfileCubit({required ProfileRepoImpl this.profileRepo})
      : super(ProfileState.initial());

  Future<ProfileModel?> getProfile({required String address});

  Future<bool> postProfile({required ProfileModel model});
}
