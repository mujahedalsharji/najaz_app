/*
 * Najaz Mobile App
 * Error Message Widget
 * 
 * This file contains a reusable error message display widget.
 * Follows Bagisto's ErrorMessage pattern, tailored for Najaz.
 */

import 'package:flutter/material.dart';
import '../utils/app_text_styles.dart';
import '../utils/app_colors.dart';
import '../utils/app_spacing.dart';

/// Error Message Widget
/// 
/// Displays an error message in a centered, styled format.
class ErrorMessage {
  /// Builds an error message widget
  /// 
  /// [errorMsg]: Error message text to display
  /// [icon]: Optional icon widget (defaults to error icon)
  /// [textStyle]: Optional text style
  /// 
  /// Returns a centered widget displaying the error message.
  static Widget errorMsg(
    String errorMsg, {
    Widget? icon,
    TextStyle? textStyle,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.spacingWide),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon,
              const SizedBox(height: AppSpacing.spacingNormal),
            ] else ...[
              Icon(
                Icons.error_outline,
                size: 48,
                color: AppColors.error,
              ),
              const SizedBox(height: AppSpacing.spacingNormal),
            ],
            Text(
              errorMsg,
              textAlign: TextAlign.center,
              style: textStyle ??
                  AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a simple inline error message (for form fields, etc.)
  /// 
  /// [errorMsg]: Error message text
  /// [textStyle]: Optional text style
  static Widget inlineErrorMsg(
    String errorMsg, {
    TextStyle? textStyle,
  }) {
    return Text(
      errorMsg,
      style: textStyle ??
          AppTextStyles.bodySmall.copyWith(
            color: AppColors.error,
          ),
    );
  }
}

