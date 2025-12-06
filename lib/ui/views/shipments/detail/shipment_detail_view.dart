import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:auto_route/auto_route.dart';

import '../../../../app/app.locator.dart';
import '../../../../app/router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/models/models.dart';
import 'shipment_detail_viewmodel.dart';

@RoutePage()
class ShipmentDetailView extends StatelessWidget {
  final String id;

  const ShipmentDetailView({Key? key, @PathParam('id') required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ShipmentDetailViewModel>.reactive(
      viewModelBuilder: () => ShipmentDetailViewModel(shipmentId: id),
      onViewModelReady: (model) => model.initialize(),
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
          actions: model.shipment != null
              ? [
                  Padding(
                    padding: const EdgeInsets.only(right: AppSizes.paddingSm),
                    child: ElevatedButton.icon(
                      onPressed: model.downloadInvoice,
                      icon: const Icon(Icons.download_outlined, size: 18),
                      label: const Text('Download Invoice'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.textWhite,
                      ),
                    ),
                  ),
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
                ]
              : null,
        ),
        body: model.isBusy
            ? const Center(child: CircularProgressIndicator())
            : model.shipment == null
                ? const Center(child: Text('Shipment not found'))
                : SingleChildScrollView(
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
                            model.shipment!.consigneeNumber,
                            style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textWhite,
                            ),
                          ),
                          const SizedBox(height: AppSizes.paddingSm),
                          _buildStatusChip(model.shipment!.status),
                          const SizedBox(height: AppSizes.paddingMd),
                          Text(
                            'Created: ${DateFormat('MMM dd, yyyy HH:mm').format(model.shipment!.createdAt)}',
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
                      _InfoItem(label: 'Service Type', value: model.shipment!.service.displayName),
                      _InfoItem(label: 'Company Name', value: model.shipment!.companyName),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingMd),

                  // Shipper Information
                  _buildInfoCard(
                    title: 'Shipper Information',
                    items: [
                      _InfoItem(label: 'Name', value: model.shipment!.shipperName),
                      _InfoItem(label: 'Phone', value: model.shipment!.shipperPhone),
                      _InfoItem(label: 'Address', value: model.shipment!.shipperAddress),
                      _InfoItem(label: 'Country', value: model.getCountryName(model.shipment!.shipperCountry)),
                      _InfoItem(label: 'City', value: model.shipment!.shipperCity),
                      _InfoItem(label: 'Postal Code', value: model.shipment!.shipperPostal),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingMd),

                  // Consignee Information
                  _buildInfoCard(
                    title: 'Consignee Information',
                    items: [
                      _InfoItem(label: 'Company Name', value: model.shipment!.consigneeCompanyName),
                      _InfoItem(label: 'Receiver Name', value: model.shipment!.receiverName),
                      _InfoItem(label: 'Email', value: model.shipment!.receiverEmail),
                      _InfoItem(label: 'Phone', value: model.shipment!.receiverPhone),
                      _InfoItem(label: 'Address', value: model.shipment!.receiverAddress),
                      _InfoItem(label: 'Country', value: model.getCountryName(model.shipment!.receiverCountry)),
                      _InfoItem(label: 'City', value: model.shipment!.receiverCity),
                      _InfoItem(label: 'Zip Code', value: model.shipment!.receiverZip),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingMd),

                  // Shipment Details
                  _buildInfoCard(
                    title: 'Shipment Details',
                    items: [
                      _InfoItem(label: 'Account Number', value: model.shipment!.accountNo),
                      _InfoItem(label: 'Shipment Type', value: model.shipment!.shipmentType.displayName),
                      _InfoItem(label: 'Pieces', value: model.shipment!.pieces.toString()),
                      _InfoItem(label: 'Description', value: model.shipment!.description),
                      _InfoItem(label: 'Fragile', value: model.shipment!.fragile ? 'Yes' : 'No'),
                      _InfoItem(label: 'Currency', value: model.shipment!.currency.displayName),
                      if (model.shipment!.shipperReference != null)
                        _InfoItem(label: 'Shipper Reference', value: model.shipment!.shipperReference!),
                      if (model.shipment!.comments != null)
                        _InfoItem(label: 'Comments', value: model.shipment!.comments!),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingMd),

                  // Box Dimensions (if applicable)
                  if (model.shipment!.shipmentType == ShipmentType.nonDocsBox)
                    _buildInfoCard(
                      title: 'Box Dimensions',
                      items: [
                        if (model.shipment!.totalVolumetricWeight != null)
                          _InfoItem(
                            label: 'Total Volumetric Weight',
                            value: model.shipment!.totalVolumetricWeight.toString(),
                          ),
                        if (model.shipment!.dimensions != null)
                          _InfoItem(label: 'Dimensions (L x W x H)', value: model.shipment!.dimensions!),
                        if (model.shipment!.weight != null)
                          _InfoItem(label: 'Weight', value: model.shipment!.weight.toString()),
                      ],
                    ),

                  // Invoice Type (if duplicated)
                  if (model.shipment!.invoiceType != null) ...[
                    const SizedBox(height: AppSizes.paddingMd),
                    _buildInfoCard(
                      title: 'Invoice Information',
                      items: [
                        _InfoItem(label: 'Invoice Type', value: model.shipment!.invoiceType!.displayName),
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
      // TODO: Pass duplicated shipment data to CreateShipmentViewModel
      // final duplicatedShipment = model.shipment?.copyWith(
      //   invoiceType: selectedInvoiceType,
      // );

      // Use AutoRoute to navigate
      final router = locator<AppRouter>();
      await router.push(const CreateShipmentRoute());
    }
  }
}

class _InfoItem {
  final String label;
  final String value;

  _InfoItem({required this.label, required this.value});
}
