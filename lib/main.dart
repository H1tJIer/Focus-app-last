import 'package:flutter/material.dart';
import 'services/timer_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus Plus',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFFF4B4B),
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF4B4B),
          secondary: Color(0xFFFF4B4B),
        ),
      ),
      home: const PomodoroTimer(),
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Menu Button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: () {
                    // TODO: Implement menu
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'MENU',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
            ),

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
                      _getModeText(_timerService.currentMode),
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
                      color: Colors.white,
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
                      icon: const Icon(
                        Icons.stop,
                        size: 32,
                        color: Colors.white,
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
    );
  }

  String _getModeText(TimerMode mode) {
    switch (mode) {
      case TimerMode.focus:
        return 'FOCUS';
      case TimerMode.shortBreak:
        return 'SHORT BREAK';
      case TimerMode.longBreak:
        return 'LONG BREAK';
    }
  }
}
