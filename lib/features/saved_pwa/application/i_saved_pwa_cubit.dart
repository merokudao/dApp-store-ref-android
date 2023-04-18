import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/saved_pwa/application/saved_pwa_cubit.dart';
import 'package:dappstore/features/saved_pwa/infrastructure/entities/saved_dapp_model.dart';
import 'package:dappstore/features/saved_pwa/infrastructure/store/i_saved_pwa_store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ISavedPwaCubit extends Cubit<SavedPwaState> {
  final ISavedPwaStore savedPwaStore;

  ISavedPwaCubit({required this.savedPwaStore})
      : super(SavedPwaState.initial());

  initialise();

  Map<String, SavedPwaModel> get savedPwas;

  bool isPwaSaved(String dappId);

  savePwa(DappInfo dappInfo);

  removePwa(String dappId);
}
