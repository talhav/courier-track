import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../core/services/auth_service.dart';

class LoginViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();

  String _email = '';
  String _password = '';

  String get email => _email;
  String get password => _password;

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  Future<void> login() async {
    if (_email.isEmpty || _password.isEmpty) {
      _snackbarService.showSnackbar(
        message: 'Please enter email and password',
        duration: const Duration(seconds: 2),
      );
      return;
    }

    setBusy(true);

    final success = await _authService.login(_email, _password);

    setBusy(false);

    if (success) {
      _snackbarService.showSnackbar(
        message: 'Login successful!',
        duration: const Duration(seconds: 2),
      );
      _navigationService.replaceWith(Routes.shipmentsListView);
    } else {
      _snackbarService.showSnackbar(
        message: 'Invalid credentials. Please try again.',
        duration: const Duration(seconds: 2),
      );
    }
  }
}
