import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_info.dart';
import 'package:dappstore/features/saved_pwa/application/i_saved_pwa_cubit.dart';
import 'package:dappstore/features/saved_pwa/infrastructure/entities/saved_dapp_model.dart';
import 'package:dappstore/features/saved_pwa/infrastructure/store/i_saved_pwa_store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part '../../../generated/features/saved_pwa/application/saved_pwa_cubit.freezed.dart';

part 'saved_pwa_state.dart';

@LazySingleton(as: ISavedPwaCubit)
class SavedPwaCubit extends Cubit<SavedPwaState> implements ISavedPwaCubit {
  @override
  final ISavedPwaStore savedPwaStore;
  SavedPwaCubit({required this.savedPwaStore}) : super(SavedPwaState.initial());

  @override
  initialise() async {
    final data = await savedPwaStore.getSavedDapps();
    if (data != null) {
      final savedPwas = Map<String, SavedPwaModel>.from(data);
      emit(state.copyWith(savedDapps: savedPwas));
    } else {
      emit(state.copyWith(savedDapps: {}));
    }
  }

  @override
  Map<String, SavedPwaModel> get savedPwas => state.savedDapps;

  @override
  bool isPwaSaved(String dappId) => savedPwas.containsKey(dappId);

  @override
  savePwa(DappInfo dappInfo) async {
    final pwas = savedPwas;
    if (!pwas.containsKey(dappInfo.dappId!)) {
      final savedPwa = await savedPwaStore.addDapp(dappInfo);
      if (savedPwa != null) {
        final updatedPwas = {...pwas};
        updatedPwas[dappInfo.dappId!] = savedPwa;
        emit(
          state.copyWith(
            savedDapps: updatedPwas,
          ),
        );
      }
    }
  }

  @override
  removePwa(String dappId) async {
    final pwas = savedPwas;
    if (pwas.containsKey(dappId)) {
      final status = await savedPwaStore.removeDapp(dappId);
      if (status) {
        final updatedPwas = {...pwas};
        updatedPwas.remove(dappId);
        emit(
          state.copyWith(
            savedDapps: updatedPwas,
          ),
        );
      }
    }
  }
}
