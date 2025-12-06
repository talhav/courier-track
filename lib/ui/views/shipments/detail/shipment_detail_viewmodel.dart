import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:universal_html/html.dart' as html;

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

  Future<void> downloadInvoice() async {
    if (_shipment == null) return;

    try {
      _snackbarService.showSnackbar(
        message: 'Downloading invoice...',
        duration: const Duration(seconds: 2),
      );

      final bytes = await _apiService.downloadInvoice(_shipment!.id.toString());

      // Create a blob from the bytes
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);

      // Create a temporary anchor element and trigger download
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'invoice-${_shipment!.consigneeNumber}.pdf')
        ..click();

      // Clean up
      html.Url.revokeObjectUrl(url);

      _snackbarService.showSnackbar(
        message: 'Invoice downloaded successfully',
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      _snackbarService.showSnackbar(
        message: 'Failed to download invoice: $e',
        duration: const Duration(seconds: 3),
      );
    }
  }

  String getCountryName(String code) {
    try {
      return Country.countries.firstWhere((c) => c.code == code).name;
    } catch (e) {
      return code;
    }
  }
}
