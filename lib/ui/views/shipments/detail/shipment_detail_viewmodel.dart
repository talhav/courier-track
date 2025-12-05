import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../../../../app/router.dart';
import '../../../../core/models/models.dart';
import '../../../../core/services/api_service.dart';

class ShipmentDetailViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _router = locator<AppRouter>();
  final _snackbarService = locator<SnackbarService>();

  final String shipmentId;
  Shipment? _shipment;

  ShipmentDetailViewModel({required this.shipmentId});

  Shipment? get shipment => _shipment;

  Future<void> initialize() async {
    setBusy(true);
    try {
      _shipment = await _apiService.getShipmentById(shipmentId);
      notifyListeners();
    } catch (e) {
      _snackbarService.showSnackbar(
        message: 'Failed to load shipment: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  void goBack() {
    _router.maybePop();
  }

  String getCountryName(String code) {
    try {
      return Country.countries.firstWhere((c) => c.code == code).name;
    } catch (e) {
      return code;
    }
  }
}
