part of 'localisation_cubit.dart';

@freezed
class LocaleState with _$LocaleState {
  const factory LocaleState({
    String? activeLocale,
    bool? shouldFollowSystem,
  }) = _LocaleState;

  factory LocaleState.initial() =>
      const LocaleState(activeLocale: 'en', shouldFollowSystem: false);
}
