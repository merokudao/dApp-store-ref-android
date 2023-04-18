import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/saved_dapps/application/saved_dapps_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ISavedDappsCubit extends Cubit<SavedDappsState> {
  ISavedDappsCubit(super.initialState);

  initialise();

  List<DappInfo> get toUpdate;
  int get updateAppCount;
  List<DappInfo> get noUpdate;
  List<DappInfo> get allApps;
}
