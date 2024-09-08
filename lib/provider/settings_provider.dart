import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  String currentlanguge = 'en';
  ThemeMode currentthemmode = ThemeMode.dark;

  void changeLanguageCode(String newlangugecode) {
    if (currentlanguge == newlangugecode) return;

    currentlanguge = newlangugecode;
    notifyListeners();
  }

  void changeThemMode(ThemeMode newthemmode) {
    if (currentthemmode == newthemmode) return;
    currentthemmode = newthemmode;
    notifyListeners();
  }

  String getHomeBackGround() {
    return currentthemmode == ThemeMode.dark
        ? 'assets/images/dark_bg.png'
        : 'assets/images/background.png';
  }

  bool isDark() {
    return currentthemmode == ThemeMode.dark;
  }
}
