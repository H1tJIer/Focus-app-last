import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.about),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Focus Plus',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '${l10n.version} 1.0.0',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              l10n.appDescription,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
} 