abstract class IThemeStore {
  setCurrentTheme(bool isDarkEnabled);
  setShouldFollowSystem(bool shouldFollowSystem);
  Future<bool> isDarkThemeEnabled();
  Future<bool> isShouldFollowSystem();
  Future<void> clearBox();
}
