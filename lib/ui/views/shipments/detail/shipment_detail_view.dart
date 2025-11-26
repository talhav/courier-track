import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../app/app.locator.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/models/models.dart';
import 'shipment_detail_viewmodel.dart';

class ShipmentDetailView extends StatelessWidget {
  final Shipment? shipment;

  const ShipmentDetailView({Key? key, this.shipment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get shipment from arguments if not provided directly
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final actualShipment = shipment ?? args?['shipment'] as Shipment?;

    if (actualShipment == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.textWhite,
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Shipment not found'),
        ),
      );
    }

    return ViewModelBuilder<ShipmentDetailViewModel>.reactive(
      viewModelBuilder: () => ShipmentDetailViewModel(shipment: actualShipment),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.textWhite,
          title: Text(
            'Shipment Details',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: AppSizes.paddingMd),
              child: ElevatedButton.icon(
                onPressed: () => _showInvoiceTypeDialog(context, model),
                icon: const Icon(Icons.copy, size: 18),
                label: const Text('Duplicate Shipment'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: AppColors.textWhite,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.paddingLg),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: AppSizes.maxWidthLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Status Header Card
                  Card(
                    elevation: AppSizes.cardElevation,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(AppSizes.paddingLg),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primary,
                            AppColors.primaryDark,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                      ),
                      child: Column(
                        children: [
                          Text(
                            actualShipment.consigneeNumber,
                            style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textWhite,
                            ),
                          ),
                          const SizedBox(height: AppSizes.paddingSm),
                          _buildStatusChip(actualShipment.status),
                          const SizedBox(height: AppSizes.paddingMd),
                          Text(
                            'Created: ${DateFormat('MMM dd, yyyy HH:mm').format(actualShipment.createdAt)}',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: AppColors.textWhite.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.paddingMd),

                  // Service & Company Info
                  _buildInfoCard(
                    title: 'Service & Company',
                    items: [
                      _InfoItem(label: 'Service Type', value: actualShipment.service.displayName),
                      _InfoItem(label: 'Company Name', value: actualShipment.companyName),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingMd),

                  // Shipper Information
                  _buildInfoCard(
                    title: 'Shipper Information',
                    items: [
                      _InfoItem(label: 'Name', value: actualShipment.shipperName),
                      _InfoItem(label: 'Phone', value: actualShipment.shipperPhone),
                      _InfoItem(label: 'Address', value: actualShipment.shipperAddress),
                      _InfoItem(label: 'Country', value: model.getCountryName(actualShipment.shipperCountry)),
                      _InfoItem(label: 'City', value: actualShipment.shipperCity),
                      _InfoItem(label: 'Postal Code', value: actualShipment.shipperPostal),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingMd),

                  // Consignee Information
                  _buildInfoCard(
                    title: 'Consignee Information',
                    items: [
                      _InfoItem(label: 'Company Name', value: actualShipment.consigneeCompanyName),
                      _InfoItem(label: 'Receiver Name', value: actualShipment.receiverName),
                      _InfoItem(label: 'Email', value: actualShipment.receiverEmail),
                      _InfoItem(label: 'Phone', value: actualShipment.receiverPhone),
                      _InfoItem(label: 'Address', value: actualShipment.receiverAddress),
                      _InfoItem(label: 'Country', value: model.getCountryName(actualShipment.receiverCountry)),
                      _InfoItem(label: 'City', value: actualShipment.receiverCity),
                      _InfoItem(label: 'Zip Code', value: actualShipment.receiverZip),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingMd),

                  // Shipment Details
                  _buildInfoCard(
                    title: 'Shipment Details',
                    items: [
                      _InfoItem(label: 'Account Number', value: actualShipment.accountNo),
                      _InfoItem(label: 'Shipment Type', value: actualShipment.shipmentType.displayName),
                      _InfoItem(label: 'Pieces', value: actualShipment.pieces.toString()),
                      _InfoItem(label: 'Description', value: actualShipment.description),
                      _InfoItem(label: 'Fragile', value: actualShipment.fragile ? 'Yes' : 'No'),
                      _InfoItem(label: 'Currency', value: actualShipment.currency.displayName),
                      if (actualShipment.shipperReference != null)
                        _InfoItem(label: 'Shipper Reference', value: actualShipment.shipperReference!),
                      if (actualShipment.comments != null)
                        _InfoItem(label: 'Comments', value: actualShipment.comments!),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingMd),

                  // Box Dimensions (if applicable)
                  if (actualShipment.shipmentType == ShipmentType.nonDocsBox)
                    _buildInfoCard(
                      title: 'Box Dimensions',
                      items: [
                        if (actualShipment.totalVolumetricWeight != null)
                          _InfoItem(
                            label: 'Total Volumetric Weight',
                            value: actualShipment.totalVolumetricWeight.toString(),
                          ),
                        if (actualShipment.dimensions != null)
                          _InfoItem(label: 'Dimensions (L x W x H)', value: actualShipment.dimensions!),
                        if (actualShipment.weight != null)
                          _InfoItem(label: 'Weight', value: actualShipment.weight.toString()),
                      ],
                    ),

                  // Invoice Type (if duplicated)
                  if (actualShipment.invoiceType != null) ...[
                    const SizedBox(height: AppSizes.paddingMd),
                    _buildInfoCard(
                      title: 'Invoice Information',
                      items: [
                        _InfoItem(label: 'Invoice Type', value: actualShipment.invoiceType!.displayName),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required List<_InfoItem> items}) {
    return Card(
      elevation: AppSizes.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSizes.paddingMd),
            ...items.map((item) => _buildInfoRow(item.label, item.value)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.paddingSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(
              label,
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(ShipmentStatus status) {
    Color color;
    switch (status) {
      case ShipmentStatus.delivered:
        color = AppColors.success;
        break;
      case ShipmentStatus.inTransit:
        color = AppColors.info;
        break;
      case ShipmentStatus.pending:
        color = AppColors.warning;
        break;
      case ShipmentStatus.cancelled:
      case ShipmentStatus.returned:
        color = AppColors.error;
        break;
      case ShipmentStatus.onHold:
        color = AppColors.textSecondary;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMd,
        vertical: AppSizes.paddingSm,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: Text(
        status.displayName,
        style: GoogleFonts.roboto(
          color: AppColors.textWhite,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Future<void> _showInvoiceTypeDialog(BuildContext context, ShipmentDetailViewModel model) async {
    InvoiceType? selectedInvoiceType;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(
            'Select Invoice Type',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose the invoice type for the duplicated shipment',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSizes.paddingLg),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                  child: Column(
                    children: InvoiceType.values.map((type) {
                      return RadioListTile<InvoiceType>(
                        title: Text(type.displayName),
                        value: type,
                        groupValue: selectedInvoiceType,
                        onChanged: (value) {
                          setState(() {
                            selectedInvoiceType = value;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: selectedInvoiceType != null
                  ? () => Navigator.of(context).pop(true)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textWhite,
              ),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );

    if (result == true && selectedInvoiceType != null) {
      // Navigate to create shipment with duplicated data
      final duplicatedShipment = model.shipment.copyWith(
        invoiceType: selectedInvoiceType,
      );

      // Use the navigation service to navigate with arguments
      final navigationService = locator<NavigationService>();
      await navigationService.navigateTo(
        '/create-shipment-view',
        arguments: {'duplicateFrom': duplicatedShipment},
      );
    }
  }
}

class _InfoItem {
  final String label;
  final String value;

  _InfoItem({required this.label, required this.value});
}

// For arguments compatibility with router
class ShipmentDetailViewArguments {
  final Shipment shipment;

  ShipmentDetailViewArguments({required this.shipment});
}
