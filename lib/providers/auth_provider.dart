import 'package:flutter/foundation.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._authService);

  final AuthService _authService;
  UserModel? user;
  bool isLoading = false;
  String? error;

  bool get isAuthenticated => user != null;

  Future<void> bootstrap() async {
    if (!await _authService.hasToken()) return;
    await loadCurrentUser();
  }

  Future<bool> login({required String email, required String password}) async {
    return _run(() async {
      user = await _authService.login(email: email, password: password);
    });
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    String? phone,
    String? shopName,
  }) async {
    return _run(() async {
      user = await _authService.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
        shopName: shopName,
      );
    });
  }

  Future<bool> loadCurrentUser() async {
    return _run(() async {
      user = await _authService.currentUser();
    });
  }

  Future<void> logout() async {
    await _authService.logout();
    user = null;
    notifyListeners();
  }

  Future<bool> _run(Future<void> Function() action) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      await action();
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
