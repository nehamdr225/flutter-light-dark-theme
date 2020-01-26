import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProv with ChangeNotifier {
  ThemeMode theme;
  SharedPreferences prefs;

  /// Set and Save Theme
  Future<void> setTheme(ThemeMode value) async {
    this.theme = value;
    await saveThemeIndex(value.index);
    notifyListeners();
  }

  /// Save theme in Shared Preferences if value is .System then remove
  Future<void> saveThemeIndex(int value) async {
    await initSharedPrefs();
    if (value == 0)
      prefs.remove('theme');
    else
      prefs.setInt('theme', value);
  }

  /// Load the index of ThemeMode from SharedPreferences with the key 'theme'
  void loadTheme() async {
    await initSharedPrefs();
    var loadIndex = prefs.getInt('theme');
    if (loadIndex == 1 || loadIndex == 2) changeThemeFromLoad(loadIndex);
  }

  /// Detect ThemeMode from Index, then Set And Save in Shared Preferences
  void changeTheme(int indexTheme) {
    switch (indexTheme) {
      case 1:
        setTheme(ThemeMode.light);
        break;
      case 2:
        setTheme(ThemeMode.dark);
        break;
    }
  }

  /// Detect ThemeMode from Index without save in Shared Preferences
  void changeThemeFromLoad(int indexTheme) {
    switch (indexTheme) {
      case 1:
        theme = ThemeMode.light;
        notifyListeners();
        break;
      case 2:
        theme = ThemeMode.dark;
        notifyListeners();
        break;
    }
  }

  /// Init  Shared Preferences
  Future<void> initSharedPrefs() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
  }
}
