/*
 * Najaz Mobile App
 * Show Message Widget
 * 
 * This file provides toast-style notification methods for showing
 * success, error, warning, and custom messages to users.
 * Follows Bagisto's ShowMessage pattern, tailored for Najaz.
 */

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../utils/application_localization.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/constants/string_constants.dart';

/// Show Message class
/// 
/// Provides static methods for displaying toast-style notifications
/// using overlay_support package.
/// 
/// Notifications appear at the top of the screen and can be dismissed by swiping up.
class ShowMessage {
  /// Shows a success notification
  /// 
  /// Displays a green notification with check icon indicating successful operation.
  /// 
  /// [msg]: Success message to display
  /// [context]: BuildContext (required for overlay)
  /// 
  /// Example:
  /// ```dart
  /// ShowMessage.successNotification("Operation completed successfully!", context);
  /// ```
  static void successNotification(String msg, BuildContext context) {
    showSimpleNotification(
      Text(
        StringConstants.success.localized(),
        style: AppTextStyles.bodyLarge.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      context: context,
      background: AppColors.success,
      leading: const Icon(
        Icons.check_circle_outline,
        color: Colors.white,
        size: 24,
      ),
      slideDismissDirection: DismissDirection.up,
      subtitle: Text(
        msg,
        style: AppTextStyles.bodyMedium.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }

  /// Shows an error notification
  /// 
  /// Displays a red notification with cancel icon indicating an error occurred.
  /// 
  /// [msg]: Error message to display
  /// [context]: BuildContext (required for overlay)
  /// 
  /// Example:
  /// ```dart
  /// ShowMessage.errorNotification("Something went wrong. Please try again.", context);
  /// ```
  static void errorNotification(String msg, BuildContext context) {
    showSimpleNotification(
      Text(
        StringConstants.error.localized(),
        style: AppTextStyles.bodyLarge.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      context: context,
      background: AppColors.error,
      leading: const Icon(
        Icons.cancel_outlined,
        color: Colors.white,
        size: 24,
      ),
      slideDismissDirection: DismissDirection.up,
      subtitle: Text(
        msg,
        style: AppTextStyles.bodyMedium.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }

  /// Shows a warning notification
  /// 
  /// Displays an amber/orange notification with warning icon indicating a warning.
  /// 
  /// [msg]: Warning message to display
  /// [context]: BuildContext (required for overlay)
  /// [title]: Optional custom title (defaults to "Warning")
  /// 
  /// Example:
  /// ```dart
  /// ShowMessage.warningNotification("Please check your input.", context);
  /// ```
  static void warningNotification(
    String msg,
    BuildContext context, {
    String? title,
  }) {
    showSimpleNotification(
      Text(
        title ?? StringConstants.warning.localized(),
        style: AppTextStyles.bodyLarge.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      context: context,
      background: AppColors.warning,
      leading: const Icon(
        Icons.warning_amber,
        color: Colors.white,
        size: 24,
      ),
      slideDismissDirection: DismissDirection.up,
      subtitle: Text(
        msg,
        style: AppTextStyles.bodyMedium.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }

  /// Shows a custom notification
  /// 
  /// Displays a notification with custom title, message, color, and icon.
  /// 
  /// [title]: Notification title
  /// [message]: Notification message (optional)
  /// [color]: Background color for the notification
  /// [icon]: Icon to display
  /// [context]: BuildContext (required for overlay)
  /// 
  /// Example:
  /// ```dart
  /// ShowMessage.showNotification(
  ///   "Info",
  ///   "New update available",
  ///   AppColors.info,
  ///   const Icon(Icons.info_outline, color: Colors.white),
  ///   context,
  /// );
  /// ```
  static void showNotification(
    String title,
    String? message,
    Color color,
    Icon icon,
    BuildContext context,
  ) {
    showSimpleNotification(
      Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      context: context,
      background: color,
      leading: icon,
      slideDismissDirection: DismissDirection.up,
      subtitle: Text(
        message ?? StringConstants.somethingWentWrong.localized(),
        style: AppTextStyles.bodyMedium.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }

  /// Shows an info notification
  /// 
  /// Displays a blue notification with info icon for informational messages.
  /// 
  /// [msg]: Info message to display
  /// [context]: BuildContext (required for overlay)
  /// 
  /// Example:
  /// ```dart
  /// ShowMessage.infoNotification("New feature available!", context);
  /// ```
  static void infoNotification(String msg, BuildContext context) {
    showSimpleNotification(
      Text(
        StringConstants.info.localized(),
        style: AppTextStyles.bodyLarge.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      context: context,
      background: AppColors.info,
      leading: const Icon(
        Icons.info_outline,
        color: Colors.white,
        size: 24,
      ),
      slideDismissDirection: DismissDirection.up,
      subtitle: Text(
        msg,
        style: AppTextStyles.bodyMedium.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}

