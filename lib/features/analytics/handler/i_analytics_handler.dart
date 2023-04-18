abstract class IAnalyticsHandler {
  Future<bool?> installDappEvent(
      {required String dappId, required Map<String, dynamic> metadata});
}
