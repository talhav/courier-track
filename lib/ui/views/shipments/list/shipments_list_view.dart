import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:auto_route/auto_route.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/models/models.dart';
import 'shipments_list_viewmodel.dart';

@RoutePage()
class ShipmentsListView extends StatelessWidget {
  const ShipmentsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ShipmentsListViewModel>.reactive(
      viewModelBuilder: () => ShipmentsListViewModel(),
      onViewModelReady: (model) => model.initialize(),
      builder: (context, model, child) => Scaffold(
        body: Row(
          children: [
            // Sidebar
            _buildSidebar(context, model),

            // Main Content
            Expanded(
              child: Column(
                children: [
                  // Top AppBar
                  _buildTopBar(context, model),

                  // Filters Section
                  _buildFiltersSection(context, model),

                  // Shipments List
                  Expanded(
                    child: model.isBusy
                        ? const Center(child: CircularProgressIndicator())
                        : _buildShipmentsList(context, model),
                  ),

                  // Pagination
                  _buildPagination(context, model),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar(BuildContext context, ShipmentsListViewModel model) {
    return Container(
      width: 250,
      color: AppColors.primaryDark,
      child: Column(
        children: [
          // Logo Section
          Container(
            padding: const EdgeInsets.all(AppSizes.paddingLg),
            child: Row(
              children: [
                const Icon(
                  Icons.local_shipping_rounded,
                  color: AppColors.textWhite,
                  size: AppSizes.iconLg,
                ),
                const SizedBox(width: AppSizes.paddingMd),
                Text(
                  'Courier Track',
                  style: GoogleFonts.poppins(
                    color: AppColors.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.primaryLight, height: 1),

          // Navigation Menu
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingMd),
              children: [
                _buildMenuItem(
                  icon: Icons.dashboard_outlined,
                  label: 'Shipments',
                  isSelected: true,
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.add_box_outlined,
                  label: 'Create Shipment',
                  onTap: model.navigateToCreateShipment,
                ),
                _buildMenuItem(
                  icon: Icons.search_outlined,
                  label: 'Track Shipment',
                  onTap: model.navigateToTrack,
                ),
                const Divider(color: AppColors.primaryLight, height: 32),
                _buildMenuItem(
                  icon: Icons.people_outline,
                  label: 'Users',
                  onTap: model.navigateToUsers,
                ),
              ],
            ),
          ),

          // User Profile Section
          Container(
            padding: const EdgeInsets.all(AppSizes.paddingMd),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.primaryLight),
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.accent,
                    child: Text(
                      model.currentUser?.fullName.substring(0, 1).toUpperCase() ?? 'U',
                      style: const TextStyle(
                        color: AppColors.textWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    model.currentUser?.fullName ?? 'User',
                    style: const TextStyle(
                      color: AppColors.textWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    model.currentUser?.email ?? '',
                    style: const TextStyle(
                      color: AppColors.textWhite,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: AppSizes.paddingSm),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: model.logout,
                    icon: const Icon(Icons.logout, size: 18),
                    label: const Text('Logout'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textWhite,
                      side: const BorderSide(color: AppColors.textWhite),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    bool isSelected = false,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingSm,
        vertical: AppSizes.paddingXs,
      ),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.textWhite,
          size: AppSizes.iconMd,
        ),
        title: Text(
          label,
          style: GoogleFonts.roboto(
            color: AppColors.textWhite,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: onTap,
        dense: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, ShipmentsListViewModel model) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLg),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.border),
        ),
      ),
      child: Row(
        children: [
          Text(
            'Shipments',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: model.navigateToCreateShipment,
            icon: const Icon(Icons.add),
            label: const Text('Create Shipment'),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection(BuildContext context, ShipmentsListViewModel model) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingLg),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.border),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filters',
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSizes.paddingMd),
          Wrap(
            spacing: AppSizes.paddingMd,
            runSpacing: AppSizes.paddingMd,
            children: [
              // Start Date
              SizedBox(
                width: 200,
                child: InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: model.startDate ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (date != null) model.setStartDate(date);
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Start Date',
                      suffixIcon: Icon(Icons.calendar_today, size: 18),
                      isDense: true,
                    ),
                    child: Text(
                      model.startDate != null
                          ? DateFormat('yyyy-MM-dd').format(model.startDate!)
                          : 'Select date',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),

              // End Date
              SizedBox(
                width: 200,
                child: InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: model.endDate ?? DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (date != null) model.setEndDate(date);
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'End Date',
                      suffixIcon: Icon(Icons.calendar_today, size: 18),
                      isDense: true,
                    ),
                    child: Text(
                      model.endDate != null
                          ? DateFormat('yyyy-MM-dd').format(model.endDate!)
                          : 'Select date',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),

              // Destination
              SizedBox(
                width: 200,
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Destination',
                    isDense: true,
                  ),
                  onChanged: model.setDestination,
                ),
              ),

              // Service
              SizedBox(
                width: 200,
                child: DropdownButtonFormField<ServiceType>(
                  decoration: const InputDecoration(
                    labelText: 'Service',
                    isDense: true,
                  ),
                  value: model.selectedService,
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('All Services'),
                    ),
                    ...ServiceType.values.map((service) {
                      return DropdownMenuItem(
                        value: service,
                        child: Text(service.displayName),
                      );
                    }).toList(),
                  ],
                  onChanged: model.setService,
                ),
              ),

              const SizedBox(width: AppSizes.paddingMd),

              // Apply Button
              ElevatedButton(
                onPressed: model.applyFilters,
                child: const Text('Apply Filters'),
              ),

              // Clear Button
              OutlinedButton(
                onPressed: model.clearFilters,
                child: const Text('Clear'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShipmentsList(BuildContext context, ShipmentsListViewModel model) {
    if (model.shipments.isEmpty) {
      return const Center(
        child: Text('No shipments found'),
      );
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(AppSizes.paddingLg),
        child: Card(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(
                AppColors.primary.withOpacity(0.1),
              ),
              columns: const [
                DataColumn(label: Text('Consignee #', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Shipper Name', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Consignee Name', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Service', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: model.shipments.map((shipment) {
                return DataRow(
                  cells: [
                    DataCell(Text(shipment.consigneeNumber)),
                    DataCell(Text(shipment.shipperName)),
                    DataCell(Text(shipment.receiverName)),
                    DataCell(_buildServiceChip(shipment.service)),
                    DataCell(Text(DateFormat('yyyy-MM-dd HH:mm').format(shipment.createdAt))),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.visibility_outlined, size: 20),
                            onPressed: () => model.navigateToShipmentDetail(shipment),
                            tooltip: 'View Details',
                          ),
                          IconButton(
                            icon: const Icon(Icons.download_outlined, size: 20),
                            onPressed: () => model.downloadInvoice(shipment),
                            tooltip: 'Download Invoice',
                          ),
                        ],
                      ),
                    ),
                  ],
                  onSelectChanged: (_) => model.navigateToShipmentDetail(shipment),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceChip(ServiceType service) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingSm,
        vertical: AppSizes.paddingXs,
      ),
      decoration: BoxDecoration(
        color: AppColors.info.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
      ),
      child: Text(
        service.displayName,
        style: const TextStyle(
          color: AppColors.info,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPagination(BuildContext context, ShipmentsListViewModel model) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMd),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: model.currentPage > 1 ? model.previousPage : null,
          ),
          const SizedBox(width: AppSizes.paddingMd),
          Text(
            'Page ${model.currentPage} of ${model.totalPages}',
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: AppSizes.paddingMd),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: model.currentPage < model.totalPages ? model.nextPage : null,
          ),
        ],
      ),
    );
  }
}
