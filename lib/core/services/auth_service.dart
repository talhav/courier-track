import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';

@lazySingleton
class AuthService {
  final SharedPreferences _prefs;

  User? _currentUser;
  String? _token;

  AuthService(this._prefs) {
    _loadUser();
  }

  User? get currentUser => _currentUser;
  String? get token => _token;
  bool get isAuthenticated => _currentUser != null && _token != null;

  Future<void> _loadUser() async {
    _token = _prefs.getString('auth_token');
    final userId = _prefs.getString('user_id');
    final userEmail = _prefs.getString('user_email');
    final userFullName = _prefs.getString('user_full_name');
    final userRole = _prefs.getString('user_role');

    if (userId != null && userEmail != null && userFullName != null && userRole != null) {
      _currentUser = User(
        id: userId,
        email: userEmail,
        fullName: userFullName,
        role: userRole,
        phone: _prefs.getString('user_phone'),
      );
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock successful login
      _token = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
      _currentUser = User(
        id: '1',
        email: email,
        fullName: 'John Doe',
        role: 'admin',
        phone: '+1234567890',
      );

      // Save to preferences
      await _prefs.setString('auth_token', _token!);
      await _prefs.setString('user_id', _currentUser!.id);
      await _prefs.setString('user_email', _currentUser!.email);
      await _prefs.setString('user_full_name', _currentUser!.fullName);
      await _prefs.setString('user_role', _currentUser!.role);
      if (_currentUser!.phone != null) {
        await _prefs.setString('user_phone', _currentUser!.phone!);
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    _token = null;

    await _prefs.remove('auth_token');
    await _prefs.remove('user_id');
    await _prefs.remove('user_email');
    await _prefs.remove('user_full_name');
    await _prefs.remove('user_role');
    await _prefs.remove('user_phone');
  }
}
