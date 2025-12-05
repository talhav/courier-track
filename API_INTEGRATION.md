# API Integration Guide

This Flutter app is now connected to the Node.js + PostgreSQL backend.

## Setup Instructions

### 1. Configure Backend URL

Edit `lib/core/config/api_config.dart` and update the `baseUrl`:

```dart
class ApiConfig {
  // Update based on your environment:

  // For iOS Simulator (localhost works):
  static const String baseUrl = 'http://localhost:3000/api';

  // For Android Emulator (use special IP):
  static const String baseUrl = 'http://10.0.2.2:3000/api';

  // For Physical Device (use your computer's IP):
  static const String baseUrl = 'http://192.168.1.100:3000/api';
}
```

### 2. Start Backend Server

Make sure your backend is running:

```bash
cd backend
npm run dev
```

The backend should be running on `http://localhost:3000`

### 3. Run Code Generation

Generate the JSON serialization code:

```bash
cd frontend
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Run the App

```bash
flutter run
```

## Default Login Credentials

- **Email:** `admin@couriertrack.com`
- **Password:** `admin123`

## API Services Overview

### Authentication (`AuthService`)

```dart
// Login
final success = await authService.login('admin@couriertrack.com', 'admin123');

// Check authentication
final isLoggedIn = authService.isAuthenticated;

// Get current user
final user = authService.currentUser;

// Logout
await authService.logout();

// Check roles
final isAdmin = authService.isAdmin;
final isOperator = authService.isOperator;
```

### Shipments (`ApiService`)

```dart
// Get shipments with filters
final response = await apiService.getShipments(
  page: 1,
  limit: 20,
  status: ShipmentStatus.pending,
  service: ServiceType.express,
  startDate: DateTime(2024, 1, 1),
  endDate: DateTime.now(),
  destination: 'London',
);

// Access data
final shipments = response.data;
final totalPages = response.pagination.totalPages;
final total = response.pagination.total;

// Get single shipment
final shipment = await apiService.getShipmentById('shipment-id');

// Create shipment
final newShipment = await apiService.createShipment(shipment);

// Update shipment
final updated = await apiService.updateShipment('id', shipment);

// Delete shipment
await apiService.deleteShipment('id');

// Duplicate shipment
final duplicate = await apiService.duplicateShipment(
  'id',
  InvoiceType.commercial,
);

// Track shipment
final tracking = await apiService.trackShipment('CN1234567890');
final shipment = Shipment.fromJson(tracking.shipment);
final history = tracking.statusHistory;

// Get status history
final history = await apiService.getStatusHistory('shipment-id');

// Add status update
final update = await apiService.addStatusUpdate(
  'shipment-id',
  'inTransit',
  location: 'New York Hub',
  notes: 'Departed from origin',
);
```

### Users (`ApiService`)

```dart
// Get all users (Admin only)
final users = await apiService.getUsers();

// Get user by ID
final user = await apiService.getUserById('user-id');

// Create user
final newUser = await apiService.createUser(user, 'password123');

// Update user
final updated = await apiService.updateUser('id', user);

// Delete user
await apiService.deleteUser('id');

// Update password
await apiService.updateUserPassword('id', 'newPassword');
```

## Error Handling

All API methods throw exceptions on error. Always wrap API calls in try-catch:

```dart
try {
  final shipments = await apiService.getShipments();
  // Handle success
} catch (e) {
  // Handle error
  print('Error: $e');
  // Show snackbar or dialog to user
}
```

The error messages are user-friendly and come from the backend.

## Dio Configuration

The app uses Dio with:

- **Base URL:** Configured in `ApiConfig`
- **Timeout:** 30 seconds
- **Auth Interceptor:** Automatically adds JWT token to requests
- **Error Interceptor:** Handles 401 errors (auto-logout on token expiry)
- **Logging:** Shows request/response in debug mode

## Token Management

- Tokens are automatically stored in SharedPreferences
- Tokens are automatically added to request headers
- On 401 error, user is automatically logged out
- Token persists across app restarts

## Data Flow

```
User Action → ViewModel → ApiService → Dio → Backend API
                ↓
            UI Update
```

## Pagination

Shipments list uses pagination:

```dart
// First page
var response = await apiService.getShipments(page: 1, limit: 20);

// Next page
response = await apiService.getShipments(page: 2, limit: 20);

// Check if more pages exist
if (response.pagination.page < response.pagination.totalPages) {
  // More pages available
}
```

## Filtering

All shipment filters are supported:

```dart
await apiService.getShipments(
  startDate: DateTime(2024, 1, 1),      // Filter by start date
  endDate: DateTime.now(),               // Filter by end date
  destination: 'London',                 // Filter by destination
  service: ServiceType.express,          // Filter by service type
  status: ShipmentStatus.inTransit,      // Filter by status
  page: 1,
  limit: 20,
);
```

## ViewModels

Update your viewmodels to use the new API service:

### ShipmentsListViewModel Example

```dart
class ShipmentsListViewModel extends BaseViewModel {
  final ApiService _apiService = locator<ApiService>();

  List<Shipment> shipments = [];
  int currentPage = 1;
  int totalPages = 1;

  Future<void> loadShipments() async {
    setBusy(true);
    try {
      final response = await _apiService.getShipments(
        page: currentPage,
        limit: 20,
      );

      shipments = response.data;
      totalPages = response.pagination.totalPages;

      notifyListeners();
    } catch (e) {
      // Handle error
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> loadNextPage() async {
    if (currentPage < totalPages) {
      currentPage++;
      await loadShipments();
    }
  }
}
```

## Network Configuration (Android)

Add internet permission in `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

For localhost access, add in `<application>` tag:

```xml
<application
  android:usesCleartextTraffic="true">
```

## Network Configuration (iOS)

Edit `ios/Runner/Info.plist` to allow HTTP:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

## Testing

1. **Test Backend:** Use Postman or curl to verify backend APIs work
2. **Test Login:** Try logging in with default credentials
3. **Test API Calls:** Check console logs for Dio requests/responses
4. **Test Error Handling:** Try with backend stopped to test error messages

## Troubleshooting

### Connection Refused

- Check backend is running on port 3000
- Verify URL in `api_config.dart`
- For Android emulator, use `10.0.2.2` not `localhost`

### 401 Unauthorized

- Token may be invalid
- Try logging out and logging in again
- Check backend JWT_SECRET configuration

### 404 Not Found

- Verify API endpoint paths match backend
- Check `api_config.dart` base URL

### Timeout Errors

- Check internet connection
- Verify backend is accessible
- Increase timeout in `api_config.dart`

### JSON Serialization Errors

- Run: `flutter pub run build_runner build --delete-conflicting-outputs`
- Check for missing `.g.dart` files

## Production Configuration

Before deploying to production:

1. Update `baseUrl` to production server URL
2. Remove or disable Dio logging interceptor
3. Use HTTPS instead of HTTP
4. Implement proper error tracking (e.g., Sentry)
5. Add retry logic for failed requests
6. Implement token refresh mechanism
7. Add request rate limiting on frontend

## Additional Resources

- Backend API Documentation: `backend/API_DOCUMENTATION.md`
- Backend Setup Guide: `backend/SETUP_GUIDE.md`
- Dio Documentation: https://pub.dev/packages/dio
- JSON Serialization: https://pub.dev/packages/json_serializable
