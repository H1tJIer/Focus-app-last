import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'timer': 'Timer',
      'focus': 'Focus',
      'about': 'About',
      'version': 'Version',
      'appDescription': 'A productivity app that helps you focus using the Pomodoro technique.',
      'settings': 'Settings',
      'dark': 'Dark',
      'theme': 'Theme',
      'language': 'Language',
    },
    'ru': {
      'timer': 'Таймер',
      'focus': 'Фокус',
      'about': 'О программе',
      'version': 'Версия',
      'appDescription': 'Приложение для продуктивности, которое помогает сосредоточиться, используя технику Помодоро.',
      'settings': 'Настройки',
      'dark': 'Ночной',
      'theme': 'Тема',
      'language': 'Язык',
    },
    'kk': {
      'timer': 'Таймер',
      'focus': 'Фокус',
      'about': 'Қосымша туралы',
      'version': 'Нұсқа',
      'appDescription': 'Помодоро әдісі арқылы назар аударуға көмектесетін өнімділік қолданбасы.',
      'settings': 'Баптаулар',
      'dark': 'Түнгі',
      'theme': 'Тема',
      'language': 'Тіл',
    },
  };

  String get timer => _localizedValues[locale.languageCode]!['timer']!;
  String get focus => _localizedValues[locale.languageCode]!['focus']!;
  String get about => _localizedValues[locale.languageCode]!['about']!;
  String get version => _localizedValues[locale.languageCode]!['version']!;
  String get appDescription => _localizedValues[locale.languageCode]!['appDescription']!;
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  String get dark => _localizedValues[locale.languageCode]!['dark']!;
  String get theme => _localizedValues[locale.languageCode]!['theme']!;
  String get language => _localizedValues[locale.languageCode]!['language']!;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ru', 'kk'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
} 