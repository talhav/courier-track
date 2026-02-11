class ApiConfig {
  // Update this to your backend URL
  // static const String baseUrl = 'http://localhost:3000/api';
  static const String baseUrl = 'https://courier-track-be-production.up.railway.app/api/';


  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Endpoints
  static const String login = '/auth/login';
  static const String profile = '/auth/profile';
  static const String users = '/users';
  static const String shipments = '/shipments';
  static const String track = '/shipments/track';
}
