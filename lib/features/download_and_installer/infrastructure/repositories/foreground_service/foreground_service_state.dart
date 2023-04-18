part of 'foreground_service_cubit.dart';

@freezed
class ForegroundServiceState with _$ForegroundServiceState {
  const factory ForegroundServiceState({
    bool? isRunning,
  }) = _ForegroundServiceState;

  factory ForegroundServiceState.initial() =>
      const ForegroundServiceState(isRunning: false);
}
