import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part '../../generated/core/error/error_logger.freezed.dart';
part 'error_logger_state.dart';

@LazySingleton(as: IErrorLogger)
class ErrorLogger extends Cubit<ErrorLoggerState> implements IErrorLogger {
  ErrorLogger() : super(ErrorLoggerState.initial());

  @override
  Future<void> initialise() async {
    // Currently there is no initialisation required for the error logger
  }

  @override
  Future<void> logError(Object e, StackTrace stack) {
    debugPrint("ERROR: ${e.toString()} \nStack: ${stack.toString()}");
    Sentry.captureException(e, stackTrace: stack);
    return Future.value();
  }
}
