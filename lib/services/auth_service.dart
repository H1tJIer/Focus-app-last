import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _userId;

  bool get isAuthenticated => _isAuthenticated;
  String? get userId => _userId;

  Future<bool> login(String email, String password) async {
    // TODO: Implement actual authentication logic
    // For now, we'll simulate a successful login
    await Future.delayed(const Duration(seconds: 1));
    _isAuthenticated = true;
    _userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _userId = null;
    notifyListeners();
  }
} 