import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/core/theme/store/i_theme_store.dart';
import 'package:dappstore/core/theme/theme_specs/dark_theme.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/core/theme/theme_specs/light_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part '../../generated/core/theme/theme_cubit.freezed.dart';
part 'theme_state.dart';

//this cubit can manage multiple themes and also if app should follow system
//at the moment we have only one theme but more can be added
@LazySingleton(as: IThemeCubit)
class ThemeCubit extends Cubit<ThemeState> implements IThemeCubit {
  final IThemeStore themeStore;
  IThemeSpec? lightTheme;
  IThemeSpec? darkTheme;

  ThemeCubit({required this.themeStore}) : super(ThemeState.initial(844, 360));
  @override
  initialise({required double height, required double width}) async {
    final isDark = await _isDarkEnabledStorage();
    final shouldFollowSystem = await _shouldFollowSystem();
    darkTheme = DarkTheme(height: height, width: width);
    lightTheme = LightTheme(height: height, width: width);
    if (isDark == true) {
      emit(
        state.copyWith(
          activeTheme: darkTheme,
          isDark: true,
          shouldFollowSystem: shouldFollowSystem,
        ),
      );
    } else {
      emit(
        state.copyWith(
          activeTheme: lightTheme,
          isDark: false,
          shouldFollowSystem: shouldFollowSystem,
        ),
      );
    }
  }

  @override
  toggleTheme() {
    if (state.isDark!) {
      emit(state.copyWith(activeTheme: lightTheme, isDark: false));
      _updateTheme(false);
    } else {
      emit(state.copyWith(activeTheme: darkTheme, isDark: true));
      _updateTheme(true);
    }
  }

  @override
  setLightTheme() {
    emit(state.copyWith(activeTheme: lightTheme, isDark: false));
    _updateTheme(false);
  }

  @override
  setDarkTheme() {
    emit(state.copyWith(activeTheme: darkTheme, isDark: true));
    _updateTheme(true);
  }

  @override
  IThemeSpec get theme => state.activeTheme ?? darkTheme!;
  @override
  toggleShouldFollowSystem(bool shouldFollowSystem) async {
    await _updateShouldFollowSystem(shouldFollowSystem);
    if (state.isDark!) {
      emit(state.copyWith(activeTheme: lightTheme, isDark: false));
      _updateTheme(false);
    } else {
      emit(state.copyWith(activeTheme: darkTheme, isDark: true));
      _updateTheme(true);
    }
  }

  _updateTheme(bool isDark) async {
    await themeStore.setCurrentTheme(isDark);
  }

  _updateShouldFollowSystem(bool shouldFollowSystem) async {
    await themeStore.setShouldFollowSystem(shouldFollowSystem);
    emit(state.copyWith(shouldFollowSystem: shouldFollowSystem));
  }

  _shouldFollowSystem() async {
    return await themeStore.isShouldFollowSystem();
  }

  Future<bool> _isDarkEnabledStorage() async {
    final isDarkEnabled = await themeStore.isDarkThemeEnabled();
    return isDarkEnabled;
  }
}
