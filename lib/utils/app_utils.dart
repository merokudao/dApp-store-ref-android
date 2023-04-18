class AppUtils {
  const AppUtils._();

  /// A utility method to convert 0/1 to false/true
  static bool boolFromInt(int i) => i == 1;

  /// A utility method to convert true/false to 1/0
  static int boolToInt(bool b) => b ? 1 : 0;
}
