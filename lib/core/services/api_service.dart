import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../config/api_config.dart';
import '../models/models.dart';

@lazySingleton
class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  // Authentication APIs
  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await _dio.post(
        ApiConfig.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<User> getProfile() async {
    try {
      final response = await _dio.get(ApiConfig.profile);
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Shipment APIs
  Future<PaginatedResponse<Shipment>> getShipments({
    DateTime? startDate,
    DateTime? endDate,
    String? destination,
    ServiceType? service,
    ShipmentStatus? status,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
      };

      if (startDate != null) {
        queryParams['startDate'] = startDate.toIso8601String();
      }
      if (endDate != null) {
        queryParams['endDate'] = endDate.toIso8601String();
      }
      if (destination != null && destination.isNotEmpty) {
        queryParams['destination'] = destination;
      }
      if (service != null) {
        queryParams['service'] = service.name;
      }
      if (status != null) {
        queryParams['status'] = status.name;
      }

      final response = await _dio.get(
        ApiConfig.shipments,
        queryParameters: queryParams,
      );

      return PaginatedResponse<Shipment>.fromJson(
        response.data,
        (json) => Shipment.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Shipment> getShipmentById(String id) async {
    try {
      final response = await _dio.get('${ApiConfig.shipments}/$id');
      return Shipment.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Shipment> createShipment(Shipment shipment) async {
    try {
      final response = await _dio.post(
        ApiConfig.shipments,
        data: shipment.toJson(),
      );
      return Shipment.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Shipment> updateShipment(String id, Shipment shipment) async {
    try {
      final response = await _dio.put(
        '${ApiConfig.shipments}/$id',
        data: shipment.toJson(),
      );
      return Shipment.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<bool> deleteShipment(String id) async {
    try {
      await _dio.delete('${ApiConfig.shipments}/$id');
      return true;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Shipment> duplicateShipment(String id, InvoiceType invoiceType) async {
    try {
      final response = await _dio.post(
        '${ApiConfig.shipments}/$id/duplicate',
        data: {
          'invoiceType': invoiceType.name,
        },
      );
      return Shipment.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Track Shipment
  Future<TrackingResponse> trackShipment(String consigneeNumber) async {
    try {
      final response = await _dio.get('${ApiConfig.track}/$consigneeNumber');
      return TrackingResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<StatusHistoryItem>> getStatusHistory(String shipmentId) async {
    try {
      final response = await _dio.get('${ApiConfig.shipments}/$shipmentId/status-history');
      return (response.data as List)
          .map((json) => StatusHistoryItem.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<StatusHistoryItem> addStatusUpdate(
    String shipmentId,
    String status, {
    String? location,
    String? notes,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiConfig.shipments}/$shipmentId/status',
        data: {
          'status': status,
          if (location != null) 'location': location,
          if (notes != null) 'notes': notes,
        },
      );
      return StatusHistoryItem.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // User APIs
  Future<List<User>> getUsers() async {
    try {
      final response = await _dio.get(ApiConfig.users);
      return (response.data as List)
          .map((json) => User.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<User> getUserById(String id) async {
    try {
      final response = await _dio.get('${ApiConfig.users}/$id');
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<User> createUser(User user, String password) async {
    try {
      final data = user.toJson();
      data['password'] = password;

      final response = await _dio.post(
        ApiConfig.users,
        data: data,
      );
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<User> updateUser(String id, User user) async {
    try {
      final response = await _dio.put(
        '${ApiConfig.users}/$id',
        data: user.toJson(),
      );
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<bool> deleteUser(String id) async {
    try {
      await _dio.delete('${ApiConfig.users}/$id');
      return true;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<bool> updateUserPassword(String id, String newPassword) async {
    try {
      await _dio.patch(
        '${ApiConfig.users}/$id/password',
        data: {'password': newPassword},
      );
      return true;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Error handling
  String _handleError(DioException error) {
    String errorMessage = 'An error occurred';

    if (error.response != null) {
      final data = error.response?.data;
      if (data is Map && data.containsKey('error')) {
        errorMessage = data['error'];
      } else if (data is Map && data.containsKey('errors')) {
        // Handle validation errors
        final errors = data['errors'] as List;
        if (errors.isNotEmpty) {
          errorMessage = errors.first['message'] ?? errorMessage;
        }
      } else {
        errorMessage = 'Server error: ${error.response?.statusCode}';
      }
    } else if (error.type == DioExceptionType.connectionTimeout) {
      errorMessage = 'Connection timeout. Please check your internet connection.';
    } else if (error.type == DioExceptionType.receiveTimeout) {
      errorMessage = 'Receive timeout. Please try again.';
    } else if (error.type == DioExceptionType.connectionError) {
      errorMessage = 'Connection error. Please check your internet connection.';
    } else {
      errorMessage = 'Network error: ${error.message}';
    }

    return errorMessage;
  }
}
