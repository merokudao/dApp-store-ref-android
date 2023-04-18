part of 'saved_pwa_cubit.dart';

@freezed
class SavedPwaState with _$SavedPwaState {
  const factory SavedPwaState({
    required Map<String, SavedPwaModel> savedDapps,
  }) = _SavedPwaState;

  factory SavedPwaState.initial() => const SavedPwaState(savedDapps: {});
}
