import 'package:dailydose/repository/shared_pref_repo.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    SharedPrefRepo.getThemeModeIndex().then((value) {
      _themeModeIndex = value ?? 2;
      notifyListeners();
    });
  }

  var _themeMode = ThemeMode.system;
  int _themeModeIndex = 0;

  ThemeMode get themeMode {
    if (_themeModeIndex == 0) {
      _themeMode = ThemeMode.dark;
    } else if (_themeModeIndex == 1) {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.system;
    }
    return _themeMode;
  }

  set setThemeModeIndex(int index) {
    _themeModeIndex = index;
    SharedPrefRepo.updateThemeModeIndex(index);
    notifyListeners();
  }
}
