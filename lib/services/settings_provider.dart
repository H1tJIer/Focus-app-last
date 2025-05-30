import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  Locale _locale = const Locale('en');

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
} 