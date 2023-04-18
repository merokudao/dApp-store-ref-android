import 'package:dappstore/core/theme/store/entities/theme_storage.dart';
import 'package:dappstore/core/theme/store/i_theme_store.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IThemeStore)
class ThemeStore implements IThemeStore {
  static const themeStoageBoxName = "ThemeStorageBox";
  @override
  setCurrentTheme(bool isDarkEnabled) async {
    Box<ThemeStorage> box = await _getBox();

    final ThemeStorage themeStorage = box.get(0) ?? ThemeStorage();
    themeStorage.isDarkEnabled = isDarkEnabled;
    await box.put(0, themeStorage);
  }

  @override
  setShouldFollowSystem(bool shouldFollowSystem) async {
    Box<ThemeStorage> box = await _getBox();

    final ThemeStorage themeStorage = box.get(0) ?? ThemeStorage();
    themeStorage.shouldFollowSystem = shouldFollowSystem;
    await box.put(0, themeStorage);
  }

  @override
  Future<bool> isDarkThemeEnabled() async {
    Box<ThemeStorage> box = await _getBox();

    final ThemeStorage? themeStorage = box.get(0);
    return themeStorage?.isDarkEnabled ?? true;
  }

  @override
  Future<bool> isShouldFollowSystem() async {
    Box<ThemeStorage> box = await _getBox();

    final ThemeStorage? themeStorage = box.get(0);

    return themeStorage?.shouldFollowSystem ?? false;
  }

  @override
  clearBox() async {
    Box<ThemeStorage> box = await _getBox();
    return box.deleteFromDisk();
  }

  Future<Box<ThemeStorage>> _getBox() async {
    Box<ThemeStorage> box;
    if (Hive.isBoxOpen(themeStoageBoxName)) {
      box = Hive.box(themeStoageBoxName);
    } else {
      box = await Hive.openBox<ThemeStorage>(themeStoageBoxName);
    }
    return box;
  }
}
