import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/models/models.dart';
import 'create_shipment_viewmodel.dart';

class CreateShipmentView extends StatelessWidget {
  const CreateShipmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateShipmentViewModel>.reactive(
      viewModelBuilder: () => CreateShipmentViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.textWhite,
          title: Text(
            'Create New Shipment',
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
              constraints: const BoxConstraints(maxWidth: AppSizes.maxWidthLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Service Type Section
                  _buildCard(
                    title: 'Service Type',
                    children: [
                      DropdownButtonFormField<ServiceType>(
                        value: model.selectedService,
                        decoration: const InputDecoration(
                          labelText: 'Select Service *',
                          filled: true,
                          fillColor: AppColors.surface,
                        ),
                        items: ServiceType.values.map((service) {
                          return DropdownMenuItem(
                            value: service,
                            child: Text(service.displayName),
                          );
                        }).toList(),
                        onChanged: model.setService,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingMd),

                  // Company Name
                  _buildCard(
                    title: 'Company Information',
                    children: [
                      TextFormField(
                        controller: model.companyNameController,
                        decoration: const InputDecoration(
                          labelText: 'Company Name *',
                          filled: true,
                          fillColor: AppColors.surface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingMd),

                  // Shipper Information
                  _buildCard(
                    title: 'Shipper Information',
                    children: [
                      TextFormField(
                        controller: model.shipperNameController,
                        decoration: const InputDecoration(
                          labelText: 'Shipper Name *',
                          filled: true,
                          fillColor: AppColors.surface,
                        ),
                      ),
                      const SizedBox(height: AppSizes.paddingMd),
                      TextFormField(
                        controller: model.shipperPhoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                          filled: true,
                          fillColor: AppColors.surface,
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: AppSizes.paddingMd),
                      TextFormField(
                        controller: model.shipperAddressController,
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          filled: true,
                          fillColor: AppColors.surface,
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: AppSizes.paddingMd),
                      DropdownButtonFormField<String>(
                        value: model.shipperCountry,
                        decoration: const InputDecoration(
                          labelText: 'Country *',
                          filled: true,
                          fillColor: AppColors.surface,
                        ),
                        items: Country.countries.map((country) {
                          return DropdownMenuItem(
                            value: country.code,
                            child: Text(country.name),
                          );
                        }).toList(),
                        onChanged: model.setShipperCountry,
                      ),
                      const SizedBox(height: AppSizes.paddingMd),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: model.shipperCityController,
                              decoration: const InputDecoration(
                                labelText: 'City',
                                filled: true,
                                fillColor: AppColors.surface,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSizes.paddingMd),
                          Expanded(
                            child: TextFormField(
                              controller: model.shipperPostalController,
                              decoration: const InputDecoration(
                                labelText: 'Postal Code',
                                filled: true,
                                fillColor: AppColors.surface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingMd),

                  // Consignee Information
                  _buildCard(
                    title: 'Consignee Information',
                    children: [
                      TextFormField(
                        controller: model.consigneeCompanyController,
                        decoration: const InputDecoration(
                          labelText: 'Company Name',
                          filled: true,
                          fillColor: AppColors.surface,
                        ),
                      ),
                      const SizedBox(height: AppSizes.paddingMd),
                      TextFormField(
                        controller: model.receiverNameController,
                        decoration: const InputDecoration(
                          labelText: 'Receiver Name *',
                          filled: true,
                          fillColor: AppColors.surface,
                        ),
                      ),
                      const SizedBox(height: AppSizes.paddingMd),
                      TextFormField(
                        controller: model.receiverEmailController,
                        decoration: const InputDecoration(
                          labelText: 'Receiver Email',
                          filled: true,
                          fillColor: AppColors.surface,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: AppSizes.paddingMd),
                      TextFormField(
                        controller: model.receiverPhoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                          filled: true,
                          fillColor: AppColors.surface,
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: AppSizes.paddingMd),
                      TextFormField(
                        controller: model.receiverAddressController,
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          filled: true,
                          fillColor: AppColors.surface,
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: AppSizes.paddingMd),
                      DropdownButtonFormField<String>(
                        value: model.receiverCountry,
                        decoration: const InputDecoration(
                          labelText: 'Country *',
                          filled: true,
                          fillColor: AppColors.surface,
                        ),
                        items: Country.countries.map((country) {
                          return DropdownMenuItem(
                            value: country.code,
                            child: Text(country.name),
                          );
                        }).toList(),
                        onChanged: model.setReceiverCountry,
                      ),
                      const SizedBox(height: AppSizes.paddingMd),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: model.receiverCityController,
                              decoration: const InputDecoration(
                                labelText: 'City',
                                filled: true,
                                fillColor: AppColors.surface,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSizes.paddingMd),
                          Expanded(
                            child: TextFormField(
                              controller: model.receiverZipController,
                              decoration: const InputDecoration(
                                labelText: 'Zip Code',
                                filled: true,
                                fillColor: AppColors.surface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingMd),

                  // Shipment Information
                  _buildCard(
                    title: 'Shipment Information',
                    children: [
                      TextFormField(
                        controller: model.accountNoController,
                        decoration: const InputDecoration(
                          labelText: 'Account Number *',
                          filled: true,
                          fillColor: AppColors.surface,
                        ),
                      ),
                      const SizedBox(height: AppSizes.paddingMd),

                      // Shipment Type Radio Buttons
                      Text(
                        'Shipment Type *',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSizes.paddingSm),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                          border: Border.all(color: AppColors.border),
                        ),
                        padding: const EdgeInsets.all(AppSizes.paddingMd),
                        child: Column(
                          children: [
                            RadioListTile<ShipmentType>(
                              title: const Text('Documents'),
                              value: ShipmentType.docs,
                              groupValue: model.shipmentType,
                              onChanged: (value) => model.setShipmentType(value!),
                              dense: true,
                            ),
                            RadioListTile<ShipmentType>(
                              title: const Text('Non-Docs (Flyer)'),
                              value: ShipmentType.nonDocsFlyer,
                              groupValue: model.shipmentType,
                              onChanged: (value) => model.setShipmentType(value!),
                              dense: true,
                            ),
                            RadioListTile<ShipmentType>(
                              title: const Text('Non-Docs (Box)'),
                              value: ShipmentType.nonDocsBox,
                              groupValue: model.shipmentType,
                              onChanged: (value) => model.setShipmentType(value!),
                              dense: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSizes.paddingMd),

                      TextFormField(
                        controller: model.piecesController,
                        decoration: const InputDecoration(
                          labelText: 'Number of Pieces',
                          filled: true,
                          fillColor: AppColors.surface,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: AppSizes.paddingMd),
                      TextFormField(
                        controller: model.descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description *',
                          filled: true,
                          fillColor: AppColors.surface,
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: AppSizes.paddingMd),

                      // Fragile Toggle
                      SwitchListTile(
                        title: const Text('Fragile'),
                        value: model.isFragile,
                        onChanged: model.setFragile,
                        activeColor: AppColors.primary,
                      ),
                      const SizedBox(height: AppSizes.paddingMd),

                      DropdownButtonFormField<CurrencyType>(
                        value: model.currency,
                        decoration: const InputDecoration(
                          labelText: 'Currency',
                          filled: true,
                          fillColor: AppColors.surface,
                        ),
                        items: CurrencyType.values.map((currency) {
                          return DropdownMenuItem(
                            value: currency,
                            child: Text(currency.displayName),
                          );
                        }).toList(),
                        onChanged: model.setCurrency,
                      ),
                      const SizedBox(height: AppSizes.paddingMd),
                      TextFormField(
                        controller: model.shipperReferenceController,
                        decoration: const InputDecoration(
                          labelText: 'Shipper Reference',
                          filled: true,
                          fillColor: AppColors.surface,
                        ),
                      ),
                      const SizedBox(height: AppSizes.paddingMd),
                      TextFormField(
                        controller: model.commentsController,
                        decoration: const InputDecoration(
                          labelText: 'Comments',
                          filled: true,
                          fillColor: AppColors.surface,
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingMd),

                  // Box Dimensions (conditional)
                  if (model.showBoxDimensions)
                    _buildCard(
                      title: 'Box Dimensions',
                      children: [
                        TextFormField(
                          controller: model.volumetricWeightController,
                          decoration: const InputDecoration(
                            labelText: 'Total Volumetric Weight',
                            filled: true,
                            fillColor: AppColors.surface,
                          ),
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                        ),
                        const SizedBox(height: AppSizes.paddingMd),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: model.lengthController,
                                decoration: const InputDecoration(
                                  labelText: 'Length',
                                  filled: true,
                                  fillColor: AppColors.surface,
                                ),
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                              ),
                            ),
                            const SizedBox(width: AppSizes.paddingMd),
                            Expanded(
                              child: TextFormField(
                                controller: model.widthController,
                                decoration: const InputDecoration(
                                  labelText: 'Width',
                                  filled: true,
                                  fillColor: AppColors.surface,
                                ),
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                              ),
                            ),
                            const SizedBox(width: AppSizes.paddingMd),
                            Expanded(
                              child: TextFormField(
                                controller: model.heightController,
                                decoration: const InputDecoration(
                                  labelText: 'Height',
                                  filled: true,
                                  fillColor: AppColors.surface,
                                ),
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.paddingMd),
                        TextFormField(
                          controller: model.weightController,
                          decoration: const InputDecoration(
                            labelText: 'Weight',
                            filled: true,
                            fillColor: AppColors.surface,
                          ),
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                        ),
                      ],
                    ),
                  const SizedBox(height: AppSizes.paddingXl),

                  // Submit Button
                  SizedBox(
                    height: AppSizes.buttonHeightLg,
                    child: ElevatedButton(
                      onPressed: model.isBusy ? null : model.createShipment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.textWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                        ),
                        elevation: 2,
                      ),
                      child: model.isBusy
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.textWhite,
                                ),
                              ),
                            )
                          : Text(
                              'Create Shipment',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.paddingLg),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required List<Widget> children}) {
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
            ...children,
          ],
        ),
      ),
    );
  }
}
