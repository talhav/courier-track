import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../models/models.dart';

@lazySingleton
class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  // Shipment APIs
  Future<List<Shipment>> getShipments({
    DateTime? startDate,
    DateTime? endDate,
    String? destination,
    ServiceType? service,
    ShipmentStatus? status,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock data
      return _generateMockShipments(limit);
    } catch (e) {
      throw Exception('Failed to fetch shipments: $e');
    }
  }

  Future<Shipment> getShipmentById(String id) async {
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 300));

      return _generateMockShipments(1).first;
    } catch (e) {
      throw Exception('Failed to fetch shipment: $e');
    }
  }

  Future<Shipment> createShipment(Shipment shipment) async {
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      return shipment.copyWith(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        consigneeNumber: 'CN${DateTime.now().millisecondsSinceEpoch}',
        status: ShipmentStatus.pending,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Failed to create shipment: $e');
    }
  }

  Future<Shipment> updateShipment(String id, Shipment shipment) async {
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      return shipment.copyWith(
        id: id,
        updatedAt: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Failed to update shipment: $e');
    }
  }

  Future<bool> deleteShipment(String id) async {
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 300));

      return true;
    } catch (e) {
      throw Exception('Failed to delete shipment: $e');
    }
  }

  // Track Shipment
  Future<Shipment?> trackShipment(String trackingNumber) async {
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      return _generateMockShipments(1).first;
    } catch (e) {
      throw Exception('Failed to track shipment: $e');
    }
  }

  // User APIs
  Future<List<User>> getUsers() async {
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      return _generateMockUsers();
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }

  Future<User> createUser(User user) async {
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      return user.copyWith(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<User> updateUser(User user) async {
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));

      return user.copyWith(
        updatedAt: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  Future<bool> deleteUser(String id) async {
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 300));

      return true;
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  // Mock data generators
  List<Shipment> _generateMockShipments(int count) {
    return List.generate(count, (index) {
      final now = DateTime.now();
      return Shipment(
        id: 'SHP${1000 + index}',
        consigneeNumber: 'CN${1000 + index}',
        service: ServiceType.values[index % ServiceType.values.length],
        status: ShipmentStatus.values[index % ShipmentStatus.values.length],
        companyName: 'Company ${index + 1}',
        shipperName: 'Shipper ${index + 1}',
        shipperPhone: '+1234567890',
        shipperAddress: '123 Shipper St',
        shipperCountry: 'US',
        shipperCity: 'New York',
        shipperPostal: '10001',
        consigneeCompanyName: 'Consignee Co ${index + 1}',
        receiverName: 'Receiver ${index + 1}',
        receiverEmail: 'receiver${index + 1}@example.com',
        receiverPhone: '+0987654321',
        receiverAddress: '456 Receiver Ave',
        receiverCountry: 'GB',
        receiverCity: 'London',
        receiverZip: 'SW1A 1AA',
        accountNo: 'ACC${1000 + index}',
        shipmentType: ShipmentType.values[index % ShipmentType.values.length],
        pieces: index + 1,
        description: 'Sample shipment ${index + 1}',
        fragile: index % 2 == 0,
        currency: CurrencyType.values[index % CurrencyType.values.length],
        shipperReference: 'REF${index + 1}',
        comments: 'Test comment',
        createdAt: now.subtract(Duration(days: index)),
      );
    });
  }

  List<User> _generateMockUsers() {
    return [
      User(
        id: '1',
        email: 'admin@couriertrack.com',
        fullName: 'Admin User',
        phone: '+1234567890',
        role: 'admin',
        isActive: true,
        createdAt: DateTime.now(),
      ),
      User(
        id: '2',
        email: 'operator@couriertrack.com',
        fullName: 'Operator User',
        phone: '+1234567891',
        role: 'operator',
        isActive: true,
        createdAt: DateTime.now(),
      ),
      User(
        id: '3',
        email: 'viewer@couriertrack.com',
        fullName: 'Viewer User',
        phone: '+1234567892',
        role: 'viewer',
        isActive: false,
        createdAt: DateTime.now(),
      ),
    ];
  }
}
