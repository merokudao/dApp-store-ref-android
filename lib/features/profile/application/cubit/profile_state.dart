part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    required String? name,
    required String? address,
  }) = _ProfileState;

  factory ProfileState.initial() => const ProfileState(
        name: null,
        address: null,
      );

  factory ProfileState.fromJson(Map<String, dynamic> json) =>
      _$ProfileStateFromJson(json);
}
