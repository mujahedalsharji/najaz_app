/*
 * Najaz Mobile App
 * Profile Body
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../models/profile_models/my_profile_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_navigation.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/route_constants.dart';
import '../../../utils/constants/string_constants.dart';

class ProfileBody extends StatefulWidget {
  final MyProfileModel? profile;
  final VoidCallback onRefresh;

  const ProfileBody({
    super.key,
    required this.profile,
    required this.onRefresh,
  });

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  File? _profileImage;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => widget.onRefresh(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 30),
            _buildPrimarySection(context),
            const SizedBox(height: 12),
            _buildSecondarySection(context),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final userTypeLabel = _citizenTypeLabel(widget.profile);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 146,
              height: 145,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE9D3A5), width: 1),
              ),
              child: CircleAvatar(
                backgroundColor: const Color(0xFFF4F3EF),
                backgroundImage:
                    _profileImage == null ? null : FileImage(_profileImage!),
                child:
                    _profileImage == null
                        ? Icon(
                          Icons.person_rounded,
                          size: 60,
                          color: Colors.grey.shade400,
                        )
                        : null,
              ),
            ),
            Positioned(
              bottom: 4,
              right: 4,
              child: GestureDetector(
                onTap: _pickProfileImage,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          _fullName(widget.profile),
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        if (userTypeLabel.isNotEmpty)
          Text(
            userTypeLabel,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }

  Widget _buildPrimarySection(BuildContext context) {
    return _buildMenuCard(
      items: [
        _ProfileMenuItem(
          label: StringConstants.personalInfo.localized(),
          icon: Icons.account_circle_outlined,
          onTap:
              () =>
                  AppNavigation.navigateTo(context, RouteConstants.accountInfo),
        ),
        _ProfileMenuItem(
          label: StringConstants.changePassword.localized(),
          icon: Icons.lock_outline,
          onTap:
              () => AppNavigation.navigateTo(
                context,
                RouteConstants.changePassword,
              ),
        ),
        _ProfileMenuItem(
          label: StringConstants.notifications.localized(),
          icon: Icons.notifications_outlined,
          onTap:
              () => AppNavigation.navigateTo(
                context,
                RouteConstants.notifications,
              ),
        ),
        _ProfileMenuItem(
          label: StringConstants.language.localized(),
          icon: Icons.language,
          onTap:
              () => AppNavigation.navigateTo(context, RouteConstants.language),
        ),
      ],
    );
  }

  Widget _buildSecondarySection(BuildContext context) {
    return _buildMenuCard(
      items: [
        _ProfileMenuItem(
          label: StringConstants.aboutApp.localized(),
          icon: Icons.info_outline,
          onTap:
              () => AppNavigation.navigateTo(context, RouteConstants.aboutApp),
        ),
        _ProfileMenuItem(
          label: StringConstants.support.localized(),
          icon: Icons.message_outlined,
          onTap:
              () => AppNavigation.navigateTo(context, RouteConstants.support),
        ),
        _ProfileMenuItem(
          label: StringConstants.signOut.localized(),
          icon: Icons.login_outlined,
          color: AppColors.error,
          onTap: () {},
        ),
        // _ProfileMenuItem(
        //   label: StringConstants.deactivateAccount.localized(),
        //   icon: Icons.delete_outline,
        //   color: AppColors.error,
        //   onTap: () {},
        // ),
      ],
    );
  }

  Widget _buildMenuCard({required List<_ProfileMenuItem> items}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0E9DB), width: 1),
      ),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            _buildMenuTile(items[i]),
            if (i != items.length - 1)
              Divider(
                height: 1,
                color: AppColors.primaryColor.withValues(alpha: 0.15),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildMenuTile(_ProfileMenuItem item) {
    final color = item.color ?? AppColors.textPrimary;
    return InkWell(
      onTap: item.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(item.icon, size: 20, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.label,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  String _fullName(MyProfileModel? profile) {
    final parts =
        [
          profile?.firstName,
          profile?.middleName,
          profile?.lastName,
        ].where((part) => part != null && part.trim().isNotEmpty).toList();
    if (parts.isEmpty) {
      return StringConstants.profile.localized();
    }
    return parts.map((e) => e!.trim()).join(' ');
  }

  String _citizenTypeLabel(MyProfileModel? profile) {
    final typeId =
        int.tryParse(
          profile?.citizenTypeId ??
              profile?.identityVerification?.citizen?.citizenTypeId ??
              '',
        ) ??
        0;
    switch (typeId) {
      case 1:
        return 'مواطن';
      case 2:
        return 'امين شرعي';
      case 3:
        return 'قاضي';
      default:
        return '';
    }
  }

  Future<void> _pickProfileImage() async {
    final ImagePicker picker = ImagePicker();

    bool hasPermission = false;
    if (Platform.isAndroid) {
      hasPermission = await _requestPermission(Permission.photos);
      if (!hasPermission) {
        hasPermission = await _requestPermission(Permission.storage);
      }
    } else {
      hasPermission = await _requestPermission(Permission.photos);
    }

    if (!hasPermission) {
      return;
    }

    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${StringConstants.errorPickingImage.localized()}: ${e.toString()}',
          ),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    final status = await permission.status;

    if (status.isGranted) {
      return true;
    }

    if (status.isDenied) {
      final newStatus = await permission.request();
      if (newStatus.isGranted) {
        return true;
      }
      if (newStatus.isPermanentlyDenied) {
        _showPermissionDeniedDialog(permission);
      }
      return false;
    }

    if (status.isPermanentlyDenied) {
      _showPermissionDeniedDialog(permission);
      return false;
    }

    return false;
  }

  void _showPermissionDeniedDialog(Permission permission) {
    final permissionName = StringConstants.gallery.localized();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(StringConstants.permissionRequired.localized()),
            content: Text(
              StringConstants.permissionDeniedMessage.localized().replaceAll(
                '{permission}',
                permissionName,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(StringConstants.cancel.localized()),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
                child: Text(StringConstants.openSettings.localized()),
              ),
            ],
          ),
    );
  }
}

class _ProfileMenuItem {
  final String label;
  final IconData icon;
  final Color? color;
  final VoidCallback onTap;

  _ProfileMenuItem({
    required this.label,
    required this.icon,
    required this.onTap,
    this.color,
  });
}
