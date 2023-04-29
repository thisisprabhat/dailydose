import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  var _themeMode = ThemeMode.system;
  int _themeModeIndex = 0;

  ThemeMode get themeMode {
    if (_themeModeIndex == 0) {
      _themeMode = ThemeMode.light;
    } else if (_themeModeIndex == 1) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }
    return _themeMode;
  }

  set setThemeModeIndex(int index) {
    _themeModeIndex = index;
    notifyListeners();
  }
}
