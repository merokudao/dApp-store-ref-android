part of 'theme_cubit.dart';

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState({
    IThemeSpec? activeTheme,
    bool? isDark,
    bool? shouldFollowSystem,
  }) = _ThemeState;

  factory ThemeState.initial(double height, double width) => ThemeState(
      activeTheme: DarkTheme(height: height, width: width),
      isDark: true,
      shouldFollowSystem: false);
}
