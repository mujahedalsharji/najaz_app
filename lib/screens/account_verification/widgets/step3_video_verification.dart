/*
 * Najaz Mobile App
 * Step 3: Video Verification
 * 
 * This widget displays the video verification interface for verification Step 3.
 * Note: Requires camera package for video recording.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/string_constants.dart';
import '../bloc/account_verification_bloc.dart';
import '../bloc/account_verification_event.dart';
import '../bloc/account_verification_state.dart';

/// Step 3: Video Verification Form
class Step3VideoVerification extends StatefulWidget {
  final VerificationStepState state;

  const Step3VideoVerification({super.key, required this.state});

  @override
  State<Step3VideoVerification> createState() => _Step3VideoVerificationState();
}

class _Step3VideoVerificationState extends State<Step3VideoVerification> {
  String? _videoPath;
  String? _videoUrl;

  @override
  void initState() {
    super.initState();
    _videoPath = widget.state.videoPath;
    _videoUrl = widget.state.videoUrl;
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
            StringConstants.videoVerification.localized(),
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.spacingMedium),
          // Description
          Text(
            StringConstants.videoVerificationDescription.localized(),
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.spacingLarge),
          // Instructions
          Container(
            padding: const EdgeInsets.all(AppSpacing.spacingLarge),
            decoration: BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: BorderRadius.circular(AppSpacing.spacingNormal),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringConstants.videoInstructions.localized(),
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.spacingMedium),
                Text(
                  StringConstants.videoInstructionsContent.localized(),
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.spacingLarge),
          // Video recording area
          Builder(
            builder: (context) {
              final hasVideo =
                  _videoPath != null || (_videoUrl != null && _videoUrl!.isNotEmpty);

              return Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppSpacing.spacingNormal),
                  border: Border.all(
                    color: hasVideo ? AppColors.primaryColor : AppColors.border,
                    width: 2,
                  ),
                ),
                child: hasVideo
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          // Video preview placeholder
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.video_library,
                                  size: 64,
                                  color: AppColors.textSecondary,
                                ),
                                const SizedBox(height: AppSpacing.spacingMedium),
                                Text(
                                  _videoPath != null
                                      ? StringConstants.videoRecorded.localized()
                                      : StringConstants.existingVideo.localized(),
                                  style: AppTextStyles.bodyMedium,
                                ),
                                if (_videoUrl != null && _videoPath == null) ...[
                                  const SizedBox(height: AppSpacing.spacingSmall),
                                  Text(
                                    StringConstants.existingVideoWillReplace
                                        .localized(),
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _videoPath = null;
                                  _videoUrl = null;
                                });
                                _updateState();
                              },
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
                          const Icon(
                            Icons.videocam,
                            size: 64,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(height: AppSpacing.spacingMedium),
                          Text(
                            StringConstants.tapToRecordVideo.localized(),
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.spacingLarge),
          // Record button
          ElevatedButton.icon(
            onPressed: _videoPath == null ? () => _recordVideo() : null,
            icon: const Icon(Icons.videocam),
            label: Text(StringConstants.recordVideo.localized()),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
          const SizedBox(height: AppSpacing.spacingWide),
        ],
      ),
    );
  }

  /// Record video
  Future<void> _recordVideo() async {
    final ImagePicker picker = ImagePicker();

    // Request camera and microphone permissions
    final hasCameraPermission = await _requestPermission(Permission.camera);
    if (!hasCameraPermission) {
      return;
    }

    final hasAudioPermission = await _requestPermission(Permission.microphone);
    if (!hasAudioPermission) {
      return;
    }

    try {
      // Record video using camera
      final XFile? videoFile = await picker.pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(seconds: 60), // Limit to 60 seconds
      );

      if (videoFile != null) {
        setState(() {
          _videoPath = videoFile.path;
        });

        // Update BLoC state
        _updateState();
      }
    } catch (e) {
      // Handle errors (permissions, etc.)
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${StringConstants.errorRecordingVideo.localized()}: ${e.toString()}',
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
          _showPermissionDeniedDialog();
        }
        return false;
      }
      return false;
    }

    if (status.isPermanentlyDenied) {
      // Show dialog to open settings
      if (context.mounted) {
        _showPermissionDeniedDialog();
      }
      return false;
    }

    return false;
  }

  /// Show dialog when permission is permanently denied
  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(StringConstants.permissionRequired.localized()),
        content: Text(
          StringConstants.permissionDeniedMessage.localized()
              .replaceAll('{permission}', StringConstants.camera.localized()),
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

  /// Update BLoC state with video path
  void _updateState() {
    context.read<AccountVerificationBloc>().add(
          SaveVideoPathEvent(videoPath: _videoPath),
        );
  }
}

