abstract class ILocalisationStore {
  setLocale(String locale);
  setShouldFollowSystem(bool shouldFollowSystem);
  Future<String> locale();
  Future<bool> isShouldFollowSystem();
  Future<void> clearBox();
}
