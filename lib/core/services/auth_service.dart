import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import 'api_service.dart';

@lazySingleton
class AuthService {
  final SharedPreferences _prefs;
  final ApiService _apiService;

  User? _currentUser;
  String? _token;

  AuthService(this._prefs, this._apiService) {
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
    final userIsActive = _prefs.getBool('user_is_active') ?? true;

    if (userId != null && userEmail != null && userFullName != null && userRole != null) {
      _currentUser = User(
        id: userId,
        email: userEmail,
        fullName: userFullName,
        role: userRole,
        phone: _prefs.getString('user_phone'),
        isActive: userIsActive,
      );
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await _apiService.login(email, password);

      _token = response.token;
      _currentUser = User.fromJson(response.user);

      // Save to preferences
      await _prefs.setString('auth_token', _token!);
      await _prefs.setString('user_id', _currentUser!.id);
      await _prefs.setString('user_email', _currentUser!.email);
      await _prefs.setString('user_full_name', _currentUser!.fullName);
      await _prefs.setString('user_role', _currentUser!.role);
      await _prefs.setBool('user_is_active', _currentUser!.isActive);
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
    await _prefs.remove('user_is_active');
  }

  Future<void> refreshProfile() async {
    try {
      if (_token != null) {
        _currentUser = await _apiService.getProfile();

        // Update preferences
        await _prefs.setString('user_id', _currentUser!.id);
        await _prefs.setString('user_email', _currentUser!.email);
        await _prefs.setString('user_full_name', _currentUser!.fullName);
        await _prefs.setString('user_role', _currentUser!.role);
        await _prefs.setBool('user_is_active', _currentUser!.isActive);
        if (_currentUser!.phone != null) {
          await _prefs.setString('user_phone', _currentUser!.phone!);
        }
      }
    } catch (e) {
      // Handle error silently or logout if token is invalid
      await logout();
    }
  }

  bool hasRole(List<String> allowedRoles) {
    if (_currentUser == null) return false;
    return allowedRoles.contains(_currentUser!.role);
  }

  bool get isAdmin => _currentUser?.role == 'admin';
  bool get isOperator => _currentUser?.role == 'operator' || isAdmin;
  bool get isViewer => _currentUser?.role == 'viewer';
}
