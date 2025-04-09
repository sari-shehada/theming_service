import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theming_service_shared_prefs_handler.dart';

class ThemingService {
  ThemingService({required this.currentThemeMode});

  bool get isDarkMode => Get.isDarkMode;
  ThemeMode currentThemeMode;
  static late ThemingService instance;

  static ThemingService init() {
    ThemeMode currentThemeMode = _getCurrentThemeModeFromSharedPrefs();
    instance = ThemingService(currentThemeMode: currentThemeMode);
    return instance;
  }

  void toggleLightAndDarkTheme() {
    _setThemeMode();
    _applyCurrentThemeMode();
  }

  void setCurrentThemeMode(ThemeMode themeMode) {
    _setThemeMode(themeMode: themeMode);
    _applyCurrentThemeMode();
  }

  static ThemeMode _getCurrentThemeModeFromSharedPrefs() {
    return ThemingServiceSharedPrefsHandler.getCurrentThemeMode();
  }

  Future<void> _setThemeMode({ThemeMode? themeMode}) async {
    themeMode ??= isDarkMode ? ThemeMode.light : ThemeMode.dark;
    currentThemeMode = themeMode;
    await ThemingServiceSharedPrefsHandler.setCurrentThemeMode(
      currentThemeMode,
    );
  }

  void _applyCurrentThemeMode() {
    Get.changeThemeMode(currentThemeMode);
  }
}
