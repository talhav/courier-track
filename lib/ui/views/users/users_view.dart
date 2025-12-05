import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:auto_route/auto_route.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/models/models.dart';
import 'users_viewmodel.dart';

@RoutePage()
class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UsersViewModel>.reactive(
      viewModelBuilder: () => UsersViewModel(),
      onViewModelReady: (model) => model.initialize(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: AppColors.textWhite,
          title: Text(
            'Users Management',
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
                onPressed: () => _showUserDialog(context, model, isEdit: false),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Create User'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: AppColors.textWhite,
                ),
              ),
            ),
          ],
        ),
        body: model.isBusy
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(AppSizes.paddingLg),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: AppSizes.maxWidthXl),
                    child: Card(
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
                              'All Users',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: AppSizes.paddingLg),
                            if (model.users.isEmpty)
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(AppSizes.paddingXl),
                                  child: Text('No users found'),
                                ),
                              )
                            else
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  headingRowColor: WidgetStateProperty.all(
                                    AppColors.primary.withOpacity(0.1),
                                  ),
                                  columns: const [
                                    DataColumn(
                                      label: Text(
                                        'Email',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Full Name',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Phone',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Role',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Status',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Created At',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Actions',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                  rows: model.users.map((user) {
                                    return DataRow(
                                      cells: [
                                        DataCell(Text(user.email)),
                                        DataCell(Text(user.fullName)),
                                        DataCell(Text(user.phone ?? 'N/A')),
                                        DataCell(_buildRoleChip(user.role)),
                                        DataCell(_buildStatusChip(user.isActive)),
                                        DataCell(
                                          Text(
                                            user.createdAt != null
                                                ? DateFormat('yyyy-MM-dd').format(user.createdAt!)
                                                : 'N/A',
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.edit_outlined,
                                                  size: 20,
                                                  color: AppColors.info,
                                                ),
                                                onPressed: () => _showUserDialog(
                                                  context,
                                                  model,
                                                  isEdit: true,
                                                  user: user,
                                                ),
                                                tooltip: 'Edit',
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete_outline,
                                                  size: 20,
                                                  color: AppColors.error,
                                                ),
                                                onPressed: () => _confirmDelete(context, model, user),
                                                tooltip: 'Delete',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildRoleChip(String role) {
    Color color;
    switch (role.toLowerCase()) {
      case 'admin':
        color = AppColors.error;
        break;
      case 'operator':
        color = AppColors.info;
        break;
      case 'viewer':
        color = AppColors.textSecondary;
        break;
      default:
        color = AppColors.textSecondary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingSm,
        vertical: AppSizes.paddingXs,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
      ),
      child: Text(
        role.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildStatusChip(bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingSm,
        vertical: AppSizes.paddingXs,
      ),
      decoration: BoxDecoration(
        color: (isActive ? AppColors.success : AppColors.error).withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
      ),
      child: Text(
        isActive ? 'Active' : 'Inactive',
        style: TextStyle(
          color: isActive ? AppColors.success : AppColors.error,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Future<void> _showUserDialog(
    BuildContext context,
    UsersViewModel model, {
    required bool isEdit,
    User? user,
  }) async {
    if (isEdit && user != null) {
      model.startEditUser(user);
    } else {
      model.startCreateUser();
    }

    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
          title: Text(
            isEdit ? 'Edit User' : 'Create New User',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: 500,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: model.emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email *',
                      filled: true,
                      fillColor: AppColors.background,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: AppSizes.paddingMd),
                  TextFormField(
                    controller: model.fullNameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name *',
                      filled: true,
                      fillColor: AppColors.background,
                    ),
                  ),
                  const SizedBox(height: AppSizes.paddingMd),
                  TextFormField(
                    controller: model.phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      filled: true,
                      fillColor: AppColors.background,
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingMd),
                  if (!isEdit)
                    Column(
                      children: [
                        TextFormField(
                          controller: model.passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Password *',
                            filled: true,
                            fillColor: AppColors.background,
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: AppSizes.paddingMd),
                      ],
                    ),
                  DropdownButtonFormField<String>(
                    value: model.selectedRole,
                    decoration: const InputDecoration(
                      labelText: 'Role *',
                      filled: true,
                      fillColor: AppColors.background,
                    ),
                    items: const [
                      DropdownMenuItem(value: 'viewer', child: Text('Viewer')),
                      DropdownMenuItem(value: 'operator', child: Text('Operator')),
                      DropdownMenuItem(value: 'admin', child: Text('Admin')),
                    ],
                    onChanged: model.setRole,
                  ),
                  const SizedBox(height: AppSizes.paddingMd),
                  SwitchListTile(
                    title: const Text('Active'),
                    value: model.isActive,
                    onChanged: model.setIsActive,
                    activeColor: AppColors.success,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            StatefulBuilder(
              builder: (context, setState) => ElevatedButton(
                onPressed: model.isBusy
                    ? null
                    : () async {
                        setState(() {}); // Trigger rebuild
                        final success = await model.saveUser();
                        if (success && dialogContext.mounted) {
                          Navigator.of(dialogContext).pop();
                        }
                        setState(() {}); // Trigger rebuild
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textWhite,
                ),
                child: model.isBusy
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.textWhite),
                        ),
                      )
                    : Text(isEdit ? 'Update' : 'Create'),
              ),
            ),
          ],
        ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, UsersViewModel model, User user) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Confirm Delete',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to delete user "${user.fullName}"?',
          style: GoogleFonts.roboto(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.textWhite,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await model.deleteUser(user);
    }
  }
}
