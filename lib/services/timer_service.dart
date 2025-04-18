import 'dart:async';

class TimerService {
  static const int focusDuration = 25 * 60; // 25 minutes in seconds
  static const int shortBreakDuration = 5 * 60; // 5 minutes in seconds
  static const int longBreakDuration = 15 * 60; // 15 minutes in seconds
  static const int sessionsBeforeLongBreak = 4;

  Timer? _timer;
  int _currentSeconds = focusDuration;
  int _completedSessions = 0;
  bool _isRunning = false;
  TimerMode _currentMode = TimerMode.focus;

  // Callbacks
  Function(int minutes, int seconds)? onTick;
  Function(TimerMode mode)? onModeChange;
  Function(int count)? onSessionComplete;

  bool get isRunning => _isRunning;
  TimerMode get currentMode => _currentMode;
  int get completedSessions => _completedSessions;

  void startTimer() {
    if (!_isRunning) {
      _isRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), _onTick);
    }
  }

  void pauseTimer() {
    _timer?.cancel();
    _isRunning = false;
  }

  void resetTimer() {
    _timer?.cancel();
    _isRunning = false;
    _currentSeconds = _getDurationForMode(_currentMode);
    _updateUI();
  }

  void _onTick(Timer timer) {
    if (_currentSeconds > 0) {
      _currentSeconds--;
      _updateUI();
    } else {
      _timer?.cancel();
      _isRunning = false;
      _handleSessionComplete();
    }
  }

  void _handleSessionComplete() {
    if (_currentMode == TimerMode.focus) {
      _completedSessions++;
      onSessionComplete?.call(_completedSessions);

      if (_completedSessions % sessionsBeforeLongBreak == 0) {
        _switchMode(TimerMode.longBreak);
      } else {
        _switchMode(TimerMode.shortBreak);
      }
    } else {
      _switchMode(TimerMode.focus);
    }
  }

  void _switchMode(TimerMode mode) {
    _currentMode = mode;
    _currentSeconds = _getDurationForMode(mode);
    onModeChange?.call(mode);
    _updateUI();
  }

  int _getDurationForMode(TimerMode mode) {
    switch (mode) {
      case TimerMode.focus:
        return focusDuration;
      case TimerMode.shortBreak:
        return shortBreakDuration;
      case TimerMode.longBreak:
        return longBreakDuration;
    }
  }

  void _updateUI() {
    final minutes = _currentSeconds ~/ 60;
    final seconds = _currentSeconds % 60;
    onTick?.call(minutes, seconds);
  }

  void dispose() {
    _timer?.cancel();
  }
}

enum TimerMode {
  focus,
  shortBreak,
  longBreak,
}