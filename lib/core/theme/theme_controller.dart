import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_controller.g.dart';

/// Key used to store the theme mode in SharedPreferences.
const String _themeModeKey = 'app_theme_mode';

/// Provide a [SharedPreferences] instance.
/// This needs to be overridden in main.dart before runApp.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in main.dart',
  );
}

/// A controller that manages the [ThemeMode] state and persists it.
@riverpod
class ThemeController extends _$ThemeController {
  @override
  ThemeMode build() {
    // Load the saved preferred theme mode or default to system
    final prefs = ref.watch(sharedPreferencesProvider);
    final themeIndex = prefs.getInt(_themeModeKey);
    
    if (themeIndex != null && themeIndex >= 0 && themeIndex < ThemeMode.values.length) {
      return ThemeMode.values[themeIndex];
    }
    return ThemeMode.system;
  }

  /// Changes the theme mode and saves the preference.
  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setInt(_themeModeKey, mode.index);
    state = mode;
  }

  /// Toggles between light and dark mode.
  Future<void> toggleTheme() async {
    if (state == ThemeMode.light) {
      await setThemeMode(ThemeMode.dark);
    } else {
      await setThemeMode(ThemeMode.light);
    }
  }
}
