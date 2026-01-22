/*
 * Najaz Mobile App
 * Empty State Widget
 * 
 * This file contains a reusable empty state widget.
 * Follows Bagisto's EmptyDataView pattern, tailored for Najaz.
 */

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../utils/app_spacing.dart';
import '../utils/app_text_styles.dart';
import '../utils/app_colors.dart';
import '../utils/constants/assets_constants.dart';
import '../utils/constants/string_constants.dart';
import '../utils/application_localization.dart';

/// Empty State Widget
/// 
/// Displays an empty state with Lottie animation and message.
/// Used when there's no data to display (empty lists, no results, etc.).
class EmptyState extends StatelessWidget {
  /// Path to Lottie animation asset
  final String assetPath;

  /// Message to display below animation
  final String message;

  /// Optional description text to display below message
  final String? description;

  /// Whether to show description
  final bool showDescription;

  /// Animation width
  final double width;

  /// Animation height
  final double height;

  /// Optional action button
  final Widget? actionButton;

  const EmptyState({
    Key? key,
    this.assetPath = AssetConstants.emptySearch,
    this.message = StringConstants.noData,
    this.description,
    this.showDescription = false,
    this.width = 200,
    this.height = 200,
    this.actionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.spacingWide),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie Animation
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                AppColors.textSecondary,
                BlendMode.srcIn,
              ),
              child: LottieBuilder.asset(
                assetPath,
                width: width,
                height: height,
                fit: BoxFit.contain,
              ),
            ),
            
            const SizedBox(height: AppSpacing.spacingWide),
            
            // Message
            Text(
              message.localized(),
              textAlign: TextAlign.center,
              style: AppTextStyles.headlineSmall.copyWith(
                color: AppColors.textPrimary,
              ),
              softWrap: true,
            ),
            
            // Description (if enabled)
            if (showDescription && description != null) ...[
              const SizedBox(height: AppSpacing.spacingNormal),
              Text(
                description!.localized(),
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                softWrap: true,
              ),
            ],
            
            // Action button (if provided)
            if (actionButton != null) ...[
              const SizedBox(height: AppSpacing.spacingWide),
              actionButton!,
            ],
          ],
        ),
      ),
    );
  }
}

