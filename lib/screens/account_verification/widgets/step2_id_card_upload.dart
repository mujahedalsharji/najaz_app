/*
 * Najaz Mobile App
 * Step 2: ID Card Upload
 * 
 * This widget displays the ID card upload interface for verification Step 2.
 * Note: Requires image_picker package for camera/gallery access.
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_radii.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/image_view.dart';
import '../bloc/account_verification_bloc.dart';
import '../bloc/account_verification_event.dart';
import '../bloc/account_verification_state.dart';

/// Step 2: ID Card Upload Form
class Step2IdCardUpload extends StatefulWidget {
  final VerificationStepState state;

  const Step2IdCardUpload({super.key, required this.state});

  @override
  State<Step2IdCardUpload> createState() => _Step2IdCardUploadState();
}

class _Step2IdCardUploadState extends State<Step2IdCardUpload> {
  File? _frontImage;
  File? _backImage;

  @override
  void initState() {
    super.initState();
    _frontImage = widget.state.frontImage;
    _backImage = widget.state.backImage;
  }

  @override
  void didUpdateWidget(Step2IdCardUpload oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update images when state changes from parent
    if (widget.state.frontImage != oldWidget.state.frontImage) {
      _frontImage = widget.state.frontImage;
    }
    if (widget.state.backImage != oldWidget.state.backImage) {
      _backImage = widget.state.backImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.spacingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          Text(
            StringConstants.idCard.localized(),
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.spacingMedium),
          // Description
          Text(
            StringConstants.idCardDescription.localized(),
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.spacingLarge),
          // Front Image Upload
          _buildImageUpload(
            context: context,
            title: StringConstants.idCardFront.localized(),
            image: _frontImage,
            imageUrl: widget.state.frontImageUrl,
            onTap: () => _pickImage(isFront: true),
            onRemove: () {
              setState(() {
                _frontImage = null;
              });
              _updateState(clearFrontUrl: true);
            },
          ),
          const SizedBox(height: AppSpacing.spacingLarge),
          // Back Image Upload
          _buildImageUpload(
            context: context,
            title: StringConstants.idCardBack.localized(),
            image: _backImage,
            imageUrl: widget.state.backImageUrl,
            onTap: () => _pickImage(isFront: false),
            onRemove: () {
              setState(() {
                _backImage = null;
              });
              _updateState(clearBackUrl: true);
            },
          ),
          const SizedBox(height: AppSpacing.spacingWide),
        ],
      ),
    );
  }

  /// Build image upload widget
  Widget _buildImageUpload({
    required BuildContext context,
    required String title,
    File? image,
    String? imageUrl,
    required VoidCallback onTap,
    VoidCallback? onRemove,
  }) {
    final hasImage = image != null || (imageUrl != null && imageUrl.isNotEmpty);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.spacingMedium),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppRadii.input),
              border: Border.all(
                color: hasImage ? AppColors.primaryColor : AppColors.border,
                width: 2,
              ),
            ),
            child: hasImage
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadii.input),
                        child: image != null
                            ? Image.file(
                                image,
                                fit: BoxFit.cover,
                              )
                            : ImageView(
                                url: imageUrl,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                      ),
                      if (onRemove != null)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: onRemove,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: AppColors.error,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: AppColors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate,
                        size: 48,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(height: AppSpacing.spacingMedium),
                      Text(
                        StringConstants.tapToUpload.localized(),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  /// Pick image from camera or gallery
  Future<void> _pickImage({required bool isFront}) async {
    final ImagePicker picker = ImagePicker();

    // Show dialog to select source
    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(StringConstants.selectImageSource.localized()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(StringConstants.camera.localized()),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(StringConstants.gallery.localized()),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    // Request permission based on source
    bool hasPermission = false;
    if (source == ImageSource.camera) {
      hasPermission = await _requestPermission(Permission.camera);
    } else {
      // For gallery, try photos first (Android 13+), then storage (older Android)
      if (Platform.isAndroid) {
        hasPermission = await _requestPermission(Permission.photos);
        if (!hasPermission) {
          hasPermission = await _requestPermission(Permission.storage);
        }
      } else {
        // iOS uses photos permission
        hasPermission = await _requestPermission(Permission.photos);
      }
    }

    if (!hasPermission) {
      return;
    }

    try {
      // Pick image
      final XFile? pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 85, // Compress image to reduce file size
        maxWidth: 1920, // Limit image width
        maxHeight: 1920, // Limit image height
      );

      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);

        setState(() {
          if (isFront) {
            _frontImage = imageFile;
          } else {
            _backImage = imageFile;
          }
        });

        // Update BLoC state and clear the corresponding URL if a new image is selected
        _updateState(
          clearFrontUrl: isFront,
          clearBackUrl: !isFront,
        );
      }
    } catch (e) {
      // Handle errors (permissions, etc.)
      if (context.mounted) {
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
  }

  /// Request permission and handle different states
  Future<bool> _requestPermission(Permission permission) async {
    final status = await permission.status;

    if (status.isGranted) {
      return true;
    }

    if (status.isDenied) {
      // Request permission
      final newStatus = await permission.request();
      if (newStatus.isGranted) {
        return true;
      } else if (newStatus.isPermanentlyDenied) {
        // Show dialog to open settings
        if (context.mounted) {
          _showPermissionDeniedDialog(permission);
        }
        return false;
      }
      return false;
    }

    if (status.isPermanentlyDenied) {
      // Show dialog to open settings
      if (context.mounted) {
        _showPermissionDeniedDialog(permission);
      }
      return false;
    }

    return false;
  }

  /// Show dialog when permission is permanently denied
  void _showPermissionDeniedDialog(Permission permission) {
    final permissionName = permission == Permission.camera
        ? StringConstants.camera.localized()
        : StringConstants.gallery.localized();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(StringConstants.permissionRequired.localized()),
        content: Text(
          StringConstants.permissionDeniedMessage.localized()
              .replaceAll('{permission}', permissionName),
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

  /// Update BLoC state with current images
  void _updateState({
    bool clearFrontUrl = false,
    bool clearBackUrl = false,
  }) {
    context.read<AccountVerificationBloc>().add(
          UploadIdCardEvent(
            frontImage: _frontImage,
            backImage: _backImage,
            clearFrontImageUrl: clearFrontUrl,
            clearBackImageUrl: clearBackUrl,
          ),
        );
  }
}

