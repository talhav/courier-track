import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:auto_route/auto_route.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/models/models.dart';
import 'track_viewmodel.dart';

@RoutePage()
class TrackView extends StatelessWidget {
  const TrackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TrackViewModel>.reactive(
      viewModelBuilder: () => TrackViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.textWhite,
          title: Text(
            'Track Shipment',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.paddingLg),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: AppSizes.maxWidthMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Search Card
                  Card(
                    elevation: AppSizes.cardElevation,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.paddingLg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.search,
                                color: AppColors.primary,
                                size: 32,
                              ),
                              const SizedBox(width: AppSizes.paddingMd),
                              Expanded(
                                child: Text(
                                  'Enter Tracking Number',
                                  style: GoogleFonts.poppins(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSizes.paddingLg),
                          TextField(
                            controller: model.trackingNumberController,
                            decoration: InputDecoration(
                              labelText: 'Tracking Number',
                              hintText: 'Enter consignee number',
                              prefixIcon: const Icon(Icons.confirmation_number),
                              filled: true,
                              fillColor: AppColors.background,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                              ),
                            ),
                            onSubmitted: (_) => model.trackShipment(),
                          ),
                          const SizedBox(height: AppSizes.paddingLg),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: AppSizes.buttonHeightLg,
                                  child: ElevatedButton.icon(
                                    onPressed: model.isBusy ? null : model.trackShipment,
                                    icon: const Icon(Icons.track_changes),
                                    label: Text(
                                      'Track Shipment',
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: AppColors.textWhite,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (model.hasSearched) ...[
                                const SizedBox(width: AppSizes.paddingMd),
                                SizedBox(
                                  height: AppSizes.buttonHeightLg,
                                  child: OutlinedButton.icon(
                                    onPressed: model.clearSearch,
                                    icon: const Icon(Icons.clear),
                                    label: const Text('Clear'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: AppColors.textSecondary,
                                      side: const BorderSide(color: AppColors.border),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.paddingLg),

                  // Loading Indicator
                  if (model.isBusy)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppSizes.paddingXl),
                        child: CircularProgressIndicator(),
                      ),
                    ),

                  // Not Found Message
                  if (model.hasSearched && !model.isBusy && model.foundShipment == null)
                    Card(
                      elevation: AppSizes.cardElevation,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSizes.paddingXl),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.search_off,
                              size: 64,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(height: AppSizes.paddingMd),
                            Text(
                              'Shipment Not Found',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: AppSizes.paddingSm),
                            Text(
                              'No shipment found with the provided tracking number',
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Shipment Details
                  if (model.foundShipment != null) ...[
                    // Status Header
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
                            const Icon(
                              Icons.check_circle_outline,
                              size: 64,
                              color: AppColors.textWhite,
                            ),
                            const SizedBox(height: AppSizes.paddingMd),
                            Text(
                              'Shipment Found!',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textWhite,
                              ),
                            ),
                            const SizedBox(height: AppSizes.paddingSm),
                            Text(
                              model.foundShipment!.consigneeNumber,
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: AppColors.textWhite.withOpacity(0.9),
                              ),
                            ),
                            const SizedBox(height: AppSizes.paddingMd),
                            _buildStatusChip(model.foundShipment!.status),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingMd),

                    // Shipment Info
                    _buildInfoCard(
                      title: 'Shipment Information',
                      items: [
                        _InfoItem(label: 'Service', value: model.foundShipment!.service.displayName),
                        _InfoItem(label: 'Company', value: model.foundShipment!.companyName),
                        _InfoItem(
                          label: 'Created',
                          value: DateFormat('MMM dd, yyyy HH:mm').format(model.foundShipment!.createdAt),
                        ),
                        _InfoItem(label: 'Type', value: model.foundShipment!.shipmentType.displayName),
                        _InfoItem(label: 'Pieces', value: model.foundShipment!.pieces.toString()),
                      ],
                    ),
                    const SizedBox(height: AppSizes.paddingMd),

                    // Shipper Info
                    _buildInfoCard(
                      title: 'Shipper Details',
                      items: [
                        _InfoItem(label: 'Name', value: model.foundShipment!.shipperName),
                        _InfoItem(label: 'Phone', value: model.foundShipment!.shipperPhone),
                        _InfoItem(label: 'Address', value: model.foundShipment!.shipperAddress),
                        _InfoItem(
                          label: 'Location',
                          value:
                              '${model.foundShipment!.shipperCity}, ${model.getCountryName(model.foundShipment!.shipperCountry)}',
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.paddingMd),

                    // Receiver Info
                    _buildInfoCard(
                      title: 'Receiver Details',
                      items: [
                        _InfoItem(label: 'Name', value: model.foundShipment!.receiverName),
                        _InfoItem(label: 'Email', value: model.foundShipment!.receiverEmail),
                        _InfoItem(label: 'Phone', value: model.foundShipment!.receiverPhone),
                        _InfoItem(label: 'Address', value: model.foundShipment!.receiverAddress),
                        _InfoItem(
                          label: 'Location',
                          value:
                              '${model.foundShipment!.receiverCity}, ${model.getCountryName(model.foundShipment!.receiverCountry)}',
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.paddingMd),

                    // Status History
                    if (model.statusHistory.isNotEmpty)
                      Card(
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
                                'Status History',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: AppSizes.paddingMd),
                              ...model.statusHistory.map((history) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: AppSizes.paddingMd),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 12,
                                        height: 12,
                                        margin: const EdgeInsets.only(top: 4),
                                        decoration: const BoxDecoration(
                                          color: AppColors.primary,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: AppSizes.paddingMd),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              history.status.toUpperCase(),
                                              style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                            if (history.notes != null) ...[
                                              const SizedBox(height: 4),
                                              Text(
                                                history.notes!,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 13,
                                                  color: AppColors.textSecondary,
                                                ),
                                              ),
                                            ],
                                            if (history.location != null) ...[
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  const Icon(Icons.location_on, size: 14, color: AppColors.textSecondary),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    history.location!,
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 13,
                                                      color: AppColors.textSecondary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                            const SizedBox(height: 4),
                                            Text(
                                              DateFormat('MMM dd, yyyy HH:mm').format(history.createdAt),
                                              style: GoogleFonts.roboto(
                                                fontSize: 12,
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                            if (history.createdByName != null) ...[
                                              const SizedBox(height: 2),
                                              Text(
                                                'By: ${history.createdByName}',
                                                style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  color: AppColors.textSecondary,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
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
            width: 120,
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
}

class _InfoItem {
  final String label;
  final String value;

  _InfoItem({required this.label, required this.value});
}
