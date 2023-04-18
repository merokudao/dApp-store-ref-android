part of 'self_update_cubit.dart';

@freezed
class SelfUpdateState with _$SelfUpdateState {
  const factory SelfUpdateState({
    SelfUpdateDataModel? updateData,
    DappInfo? storeInfo,
    String? currentAppVersion,
    UpdateType? updateType,
  }) = _SelfUpdateState;

  factory SelfUpdateState.initial() => const SelfUpdateState(
        updateData: null,
        updateType: UpdateType.noUpdate,
      );

  factory SelfUpdateState.fromJson(Map<String, dynamic> json) =>
      _$SelfUpdateStateFromJson(json);
}
