/*
 * Najaz Mobile App
 * Dialog Helper
 * 
 * This file contains helper methods for showing common dialogs.
 * Follows Bagisto's dialog helper pattern, tailored for Najaz.
 */

import 'package:flutter/material.dart';
import '../widgets/shimmer_widget.dart';
import 'application_localization.dart';
import 'app_spacing.dart';
import 'constants/string_constants.dart';

/// Dialog Helper class
///
/// Provides static methods for displaying common dialogs throughout the app.
class DialogHelper {
  /// Shows a network error dialog
  ///
  /// Displays an alert dialog when network connection is unavailable.
  ///
  /// [context]: BuildContext to show the dialog
  /// [onConfirm]: Optional callback when user confirms (closes dialog)
  ///
  /// Example:
  /// ```dart
  /// DialogHelper.networkErrorDialog(context);
  /// ```
  static void networkErrorDialog(
    BuildContext context, {
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(
              StringConstants.error.localized(),
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            content: Text(
              StringConstants.noInternet.localized(),
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 16,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  closeDialog(ctx);
                  if (onConfirm != null) {
                    onConfirm();
                  }
                },
                child: Text(
                  StringConstants.ok.localized(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
    );
  }

  /// Shows a confirmation dialog
  ///
  /// Displays an alert dialog with title, message, and confirm/cancel buttons.
  ///
  /// [context]: BuildContext to show the dialog
  /// [title]: Dialog title text
  /// [message]: Dialog message text
  /// [confirmText]: Text for confirm button (default: "OK")
  /// [cancelText]: Text for cancel button (default: "Cancel")
  /// [onConfirm]: Callback when user confirms
  /// [onCancel]: Optional callback when user cancels
  ///
  /// Example:
  /// ```dart
  /// DialogHelper.confirmationDialog(
  ///   context,
  ///   title: "Delete Item",
  ///   message: "Are you sure you want to delete this item?",
  ///   onConfirm: () {
  ///     // Handle confirmation
  ///   },
  /// );
  /// ```
  static void confirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(
              title,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            content: Text(
              message,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 16,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  closeDialog(ctx);
                  if (onCancel != null) {
                    onCancel();
                  }
                },
                child: Text(
                  cancelText ?? StringConstants.cancel.localized(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              TextButton(
                onPressed: () {
                  closeDialog(ctx);
                  onConfirm();
                },
                child: Text(
                  confirmText ?? StringConstants.ok.localized(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  /// Shows an exit confirmation dialog
  ///
  /// Returns true if the user confirms exit, false otherwise.
  static Future<bool?> exitAppConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(
              StringConstants.exitAppTitle.localized(),
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            content: Text(
              StringConstants.exitAppMessage.localized(),
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 16,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text(
                  StringConstants.cancel.localized(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text(
                  StringConstants.confirm.localized(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  /// Shows an error dialog
  ///
  /// Displays an alert dialog with error message.
  ///
  /// [context]: BuildContext to show the dialog
  /// [title]: Dialog title text (default: "Error")
  /// [message]: Error message text
  /// [onConfirm]: Optional callback when user confirms
  ///
  /// Example:
  /// ```dart
  /// DialogHelper.errorDialog(
  ///   context,
  ///   message: "Something went wrong. Please try again.",
  /// );
  /// ```
  static void errorDialog(
    BuildContext context, {
    String? title,
    required String message,
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(
              title ?? StringConstants.error.localized(),
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            content: Text(
              message,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 16,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  closeDialog(ctx);
                  if (onConfirm != null) {
                    onConfirm();
                  }
                },
                child: Text(
                  StringConstants.ok.localized(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
    );
  }

  /// Shows a success dialog
  ///
  /// Displays an alert dialog with success message.
  ///
  /// [context]: BuildContext to show the dialog
  /// [title]: Dialog title text (default: "Success")
  /// [message]: Success message text
  /// [onConfirm]: Optional callback when user confirms
  ///
  /// Example:
  /// ```dart
  /// DialogHelper.successDialog(
  ///   context,
  ///   message: "Operation completed successfully!",
  /// );
  /// ```
  static void successDialog(
    BuildContext context, {
    String? title,
    required String message,
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(
              title ?? StringConstants.success.localized(),
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            content: Text(
              message,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 16,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  closeDialog(ctx);
                  if (onConfirm != null) {
                    onConfirm();
                  }
                },
                child: Text(
                  StringConstants.ok.localized(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  /// Closes the currently displayed dialog
  ///
  /// [context]: BuildContext of the dialog to close
  ///
  /// Example:
  /// ```dart
  /// DialogHelper.closeDialog(context);
  /// ```
  static void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// Shows a loading dialog
  ///
  /// Displays a dialog with a loading indicator.
  ///
  /// [context]: BuildContext to show the dialog
  /// [message]: Optional loading message text
  ///
  /// Returns the BuildContext of the dialog, which can be used to close it.
  ///
  /// Example:
  /// ```dart
  /// final dialogContext = DialogHelper.loadingDialog(context);
  /// // ... perform async operation
  /// DialogHelper.closeDialog(dialogContext);
  /// ```
  static BuildContext loadingDialog(BuildContext context, {String? message}) {
    late BuildContext dialogContext;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        dialogContext = ctx;
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ShimmerContainer(
                width: 40,
                height: 40,
                borderRadius: 20,
              ),
              if (message != null) ...[
                const SizedBox(height: AppSpacing.spacingNormal),
                Text(message, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ],
          ),
        );
      },
    );

    return dialogContext;
  }
}
