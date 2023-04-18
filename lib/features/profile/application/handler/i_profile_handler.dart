import 'package:dappstore/features/profile/application/cubit/i_profile_cubit.dart';

abstract class IProfileHandler {
  IProfileCubit getProfileCubit();

  getProfile({required String address});

  postProfile({required String address});
}
