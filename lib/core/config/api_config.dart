class ApiConfig {
  // Update this to your backend URL
  static const String baseUrl = 'http://localhost:3000/api';

  // For Android emulator, use: http://10.0.2.2:3000/api
  // For iOS simulator, use: http://localhost:3000/api
  // For physical device, use your computer's IP: http://192.168.x.x:3000/api

  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Endpoints
  static const String login = '/auth/login';
  static const String profile = '/auth/profile';
  static const String users = '/users';
  static const String shipments = '/shipments';
  static const String track = '/shipments/track';
}
