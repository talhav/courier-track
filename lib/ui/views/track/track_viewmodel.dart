import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../core/models/models.dart';
import '../../../core/services/api_service.dart';

class TrackViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _snackbarService = locator<SnackbarService>();

  final trackingNumberController = TextEditingController();

  Shipment? _foundShipment;
  Shipment? get foundShipment => _foundShipment;

  List<StatusHistoryItem> _statusHistory = [];
  List<StatusHistoryItem> get statusHistory => _statusHistory;

  bool _hasSearched = false;
  bool get hasSearched => _hasSearched;

  Future<void> trackShipment() async {
    final trackingNumber = trackingNumberController.text.trim();

    if (trackingNumber.isEmpty) {
      _snackbarService.showSnackbar(
        message: 'Please enter a tracking number',
        duration: const Duration(seconds: 2),
      );
      return;
    }

    setBusy(true);
    _hasSearched = false;
    _foundShipment = null;
    _statusHistory = [];

    try {
      final response = await _apiService.trackShipment(trackingNumber);
      _foundShipment = Shipment.fromJson(response.shipment);
      _statusHistory = response.statusHistory;
      _hasSearched = true;

      if (_foundShipment == null) {
        _snackbarService.showSnackbar(
          message: 'No shipment found with tracking number: $trackingNumber',
          duration: const Duration(seconds: 3),
        );
      }

      notifyListeners();
    } catch (e) {
      _hasSearched = true;
      _snackbarService.showSnackbar(
        message: 'Failed to track shipment: $e',
        duration: const Duration(seconds: 3),
      );
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }

  void clearSearch() {
    trackingNumberController.clear();
    _foundShipment = null;
    _hasSearched = false;
    notifyListeners();
  }

  String getCountryName(String code) {
    try {
      return Country.countries.firstWhere((c) => c.code == code).name;
    } catch (e) {
      return code;
    }
  }

  @override
  void dispose() {
    trackingNumberController.dispose();
    super.dispose();
  }
}
