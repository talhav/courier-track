import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../../../../app/router.dart';
import '../../../../core/models/models.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/services/auth_service.dart';

class ShipmentsListViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _router = locator<AppRouter>();
  final _authService = locator<AuthService>();
  final _snackbarService = locator<SnackbarService>();

  List<Shipment> _shipments = [];
  List<Shipment> get shipments => _shipments;

  DateTime? _startDate;
  DateTime? _endDate;
  String? _destination;
  ServiceType? _selectedService;
  ShipmentStatus? _selectedStatus;

  int _currentPage = 1;
  final int _itemsPerPage = 10;
  int _totalPages = 1;

  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  String? get destination => _destination;
  ServiceType? get selectedService => _selectedService;
  ShipmentStatus? get selectedStatus => _selectedStatus;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;

  void initialize() {
    loadShipments();
  }

  Future<void> loadShipments() async {
    setBusy(true);
    try {
      _shipments = await _apiService.getShipments(
        startDate: _startDate,
        endDate: _endDate,
        destination: _destination,
        service: _selectedService,
        status: _selectedStatus,
        page: _currentPage,
        limit: _itemsPerPage,
      );

      // Calculate total pages (mock calculation)
      _totalPages = (_shipments.length / _itemsPerPage).ceil();
      if (_totalPages == 0) _totalPages = 1;

      notifyListeners();
    } catch (e) {
      _snackbarService.showSnackbar(
        message: 'Failed to load shipments: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  void setStartDate(DateTime? date) {
    _startDate = date;
    notifyListeners();
  }

  void setEndDate(DateTime? date) {
    _endDate = date;
    notifyListeners();
  }

  void setDestination(String? destination) {
    _destination = destination;
    notifyListeners();
  }

  void setService(ServiceType? service) {
    _selectedService = service;
    notifyListeners();
  }

  void setStatus(ShipmentStatus? status) {
    _selectedStatus = status;
    notifyListeners();
  }

  void applyFilters() {
    _currentPage = 1;
    loadShipments();
  }

  void clearFilters() {
    _startDate = null;
    _endDate = null;
    _destination = null;
    _selectedService = null;
    _selectedStatus = null;
    _currentPage = 1;
    loadShipments();
  }

  void nextPage() {
    if (_currentPage < _totalPages) {
      _currentPage++;
      loadShipments();
    }
  }

  void previousPage() {
    if (_currentPage > 1) {
      _currentPage--;
      loadShipments();
    }
  }

  void goToPage(int page) {
    if (page >= 1 && page <= _totalPages) {
      _currentPage = page;
      loadShipments();
    }
  }

  void navigateToCreateShipment() {
    _router.push(const CreateShipmentRoute());
  }

  void navigateToShipmentDetail(Shipment shipment) {
    _router.push(ShipmentDetailRoute(id: shipment.id.toString()));
  }

  void navigateToUsers() {
    _router.push(const UsersRoute());
  }

  void navigateToTrack() {
    _router.push(const TrackRoute());
  }

  Future<void> logout() async {
    await _authService.logout();
    _router.replaceAll([const LoginRoute()]);
  }

  User? get currentUser => _authService.currentUser;
}
