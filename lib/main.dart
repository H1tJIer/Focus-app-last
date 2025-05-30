import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'services/timer_service.dart';
import 'services/settings_provider.dart';
import 'screens/about_screen.dart';
import 'screens/settings_screen.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) {
        return MaterialApp(
          title: 'Focus Plus',
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: const Color(0xFF0569FC),
            scaffoldBackgroundColor: Colors.white,
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0569FC),
              secondary: Color(0xFF0569FC),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: const Color(0xFF0569FC),
            scaffoldBackgroundColor: const Color(0xFF1E1E1E),
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF0569FC),
              secondary: Color(0xFF0569FC),
            ),
          ),
          themeMode: settings.themeMode,
          locale: settings.locale,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('ru'),
            Locale('kk'),
          ],
          initialRoute: '/',
          routes: {
            '/': (context) => const PomodoroTimer(),
            '/about': (context) => const AboutScreen(),
            '/settings': (context) => const SettingsScreen(),
          },
        );
      },
    );
  }
}

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({super.key});

  @override
  State<PomodoroTimer> createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  late final TimerService _timerService;
  int _minutes = 25;
  int _seconds = 0;
  int _focusCount = 0;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _timerService = TimerService()
      ..onTick = _updateTime
      ..onSessionComplete = _updateFocusCount
      ..onModeChange = _handleModeChange;
  }

  void _updateTime(int minutes, int seconds) {
    setState(() {
      _minutes = minutes;
      _seconds = seconds;
    });
  }

  void _updateFocusCount(int count) {
    setState(() {
      _focusCount = count;
    });
  }

  void _handleModeChange(TimerMode mode) {
    setState(() {});
  }

  @override
  void dispose() {
    _timerService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Timer Display
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Focus Indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        4,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            Icons.water_drop,
                            color: index < (_focusCount % 4) ? Theme.of(context).primaryColor : Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _getModeText(_timerService.currentMode, l10n),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Control Buttons
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      _timerService.isRunning ? Icons.pause : Icons.play_arrow,
                      size: 32,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_timerService.isRunning) {
                          _timerService.pauseTimer();
                        } else {
                          _timerService.startTimer();
                        }
                      });
                    },
                  ),
                  if (_timerService.isRunning)
                    IconButton(
                      icon: Icon(
                        Icons.stop,
                        size: 32,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _timerService.resetTimer();
                        });
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/');
              break;
            case 1:
              Navigator.pushNamed(context, '/about');
              break;
            case 2:
              Navigator.pushNamed(context, '/settings');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.timer),
            label: l10n.timer,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.info),
            label: l10n.about,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: l10n.settings,
          ),
        ],
      ),
    );
  }

  String _getModeText(TimerMode mode, AppLocalizations l10n) {
    switch (mode) {
      case TimerMode.focus:
        return l10n.focus;
      case TimerMode.shortBreak:
        return 'SHORT BREAK';
      case TimerMode.longBreak:
        return 'LONG BREAK';
    }
  }
}
