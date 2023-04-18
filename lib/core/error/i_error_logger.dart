abstract class IErrorLogger {
  Future<void> initialise();
  Future<void> logError(Object e, StackTrace stack);
}
