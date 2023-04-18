import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/self_update/application/cubit/self_update_cubit.dart';
import 'package:dappstore/features/self_update/infrastructure/models/self_update_data_model.dart';
import 'package:dappstore/features/self_update/infrastructure/repositories/i_self_update_repository.dart';
import 'package:dappstore/features/self_update/infrastructure/repositories/self_update_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class ISelfUpdateCubit extends Cubit<SelfUpdateState> {
  final ISelfUpdateRepo selfUpdateRepo;
  ISelfUpdateCubit({required SelfUpdateRepoImpl this.selfUpdateRepo})
      : super(SelfUpdateState.initial());

  Future<SelfUpdateDataModel?> getLatestBuild();
  Future<PackageInfo?> getCurrentAppVersion();
  Future<DappInfo?> getDappInfoForDappStore();
  Future<UpdateType?> checkUpdate();
  UpdateType get updateStatus;
  SelfUpdateDataModel? get updateData;
}
