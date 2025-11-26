import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../../../../app/app.router.dart';
import '../../../../core/models/models.dart';

class ShipmentDetailViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  final Shipment shipment;

  ShipmentDetailViewModel({required this.shipment});

  Future<void> duplicateShipment() async {
    // Show dialog to select invoice type
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.invoiceSelection,
      title: 'Select Invoice Type',
      description: 'Choose the invoice type for the duplicated shipment',
      mainButtonTitle: 'Continue',
      secondaryButtonTitle: 'Cancel',
    );

    if (response?.confirmed == true && response?.data != null) {
      final invoiceType = response!.data as InvoiceType;

      // Navigate to create shipment view with pre-filled data
      _navigationService.navigateTo(
        Routes.createShipmentView,
        arguments: CreateShipmentViewArguments(
          duplicateFrom: shipment.copyWith(invoiceType: invoiceType),
        ),
      );
    }
  }

  void goBack() {
    _navigationService.back();
  }

  String getCountryName(String code) {
    try {
      return Country.countries.firstWhere((c) => c.code == code).name;
    } catch (e) {
      return code;
    }
  }
}

// Dialog types
class DialogType {
  static const int invoiceSelection = 1;
}

// Arguments class for CreateShipmentView
class CreateShipmentViewArguments {
  final Shipment? duplicateFrom;

  CreateShipmentViewArguments({this.duplicateFrom});
}
