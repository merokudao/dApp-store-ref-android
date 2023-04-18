part of 'error_logger.dart';

@freezed
class ErrorLoggerState with _$ErrorLoggerState {
  const factory ErrorLoggerState() = _ErrorLoggerState;

  factory ErrorLoggerState.initial() => const ErrorLoggerState();
}
