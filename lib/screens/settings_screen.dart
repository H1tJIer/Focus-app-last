import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/settings_provider.dart';
import '../l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return ListView(
            children: [
              ListTile(
                title: Text(l10n.theme),
                subtitle: Text(settings.themeMode == ThemeMode.dark ? l10n.dark : 'Light'),
                trailing: Switch(
                  value: settings.themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    settings.setThemeMode(
                      value ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                ),
              ),
              const Divider(),
              ListTile(
                title: Text(l10n.language),
                subtitle: Text(settings.locale.languageCode.toUpperCase()),
                trailing: PopupMenuButton<String>(
                  onSelected: (String language) {
                    settings.setLocale(Locale(language));
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'en',
                      child: Text('English'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'ru',
                      child: Text('Русский'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'kk',
                      child: Text('Қазақша'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
} 