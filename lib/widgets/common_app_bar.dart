/*
 * Najaz Mobile App
 * Common App Bar
 * 
 * This file contains a reusable app bar widget.
 * Follows Bagisto's CommonAppBar pattern, tailored for Najaz service-based platform.
 */

import 'package:flutter/material.dart';

import '../utils/app_navigation.dart';
import '../utils/app_text_styles.dart';
import '../utils/constants/route_constants.dart';

/// Common App Bar Widget
///
/// A reusable app bar with customizable title and actions.
/// Tailored for Najaz service-based platform (no cart, compare features).
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// App bar title
  final String title;

  /// Optional leading widget (back button or custom widget)
  final Widget? leading;

  /// List of action widgets (icons, buttons, etc.)
  final List<Widget>? actions;

  /// Whether to show search icon in actions
  final bool showSearch;

  /// Whether to show notification icon in actions
  final bool showNotifications;

  /// Unread notifications count (for badge)
  final int? unreadNotificationsCount;

  /// Optional callback for search button tap
  final VoidCallback? onSearchTap;

  /// Optional callback for notification button tap
  final VoidCallback? onNotificationTap;

  /// Whether to center the title
  final bool centerTitle;

  /// Optional background color
  final Color? backgroundColor;

  /// Optional elevation
  final double? elevation;

  /// Optional image asset path to display in the app bar
  final String? imageAssetPath;

  /// Optional image height (defaults to 40.0)
  final double? imageHeight;

  /// Optional image width (defaults to null, maintains aspect ratio)
  final double? imageWidth;

  /// Optional title text style
  final TextStyle? titleStyle;

  /// Optional flexible space widget
  final Widget? flexibleSpace;

  const CommonAppBar(
    this.title, {
    Key? key,
    this.leading,
    this.actions,
    this.showSearch = false,
    this.showNotifications = false,
    this.unreadNotificationsCount,
    this.onSearchTap,
    this.onNotificationTap,
    this.centerTitle = false,
    this.backgroundColor,
    this.elevation,
    this.imageAssetPath,
    this.imageHeight,
    this.imageWidth,
    this.titleStyle,
    this.flexibleSpace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> appBarActions = [];

    // Add search icon if enabled
    if (showSearch) {
      appBarActions.add(
        IconButton(
          onPressed:
              onSearchTap ??
              () {
                AppNavigation.navigateTo(context, RouteConstants.search);
              },
          icon: const Icon(Icons.search),
          tooltip: 'Search',
        ),
      );
    }

    // Add notification icon if enabled (with badge if count > 0)
    if (showNotifications) {
      appBarActions.add(
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed:
                  onNotificationTap ??
                  () {
                    AppNavigation.navigateTo(
                      context,
                      RouteConstants.notifications,
                    );
                  },
              icon: const Icon(Icons.notifications_outlined),
              tooltip: 'Notifications',
            ),
            if (unreadNotificationsCount != null &&
                unreadNotificationsCount! > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFB300), // Badge color
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    unreadNotificationsCount! > 99
                        ? '99+'
                        : '${unreadNotificationsCount}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      );
    }

    // Add custom actions if provided
    if (actions != null) {
      appBarActions.addAll(actions!);
    }

    return AppBar(
      elevation: elevation ?? 4.0,
      centerTitle: centerTitle,
      backgroundColor:
          backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
      surfaceTintColor: backgroundColor,
      flexibleSpace: flexibleSpace,
      leading: leading,
      title: _buildTitle(context),
      actions: appBarActions.isNotEmpty ? appBarActions : null,
    );
  }

  /// Builds the title widget with image if provided
  Widget _buildTitle(BuildContext context) {
    // Default title with image if provided
    if (imageAssetPath != null) {
      return Row(
        children: [
          Image.asset(imageAssetPath!, height: imageHeight, width: imageWidth),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.headlineMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }

    // Simple title
    return Text(
      title,
      style: titleStyle ?? AppTextStyles.headlineMedium.copyWith(fontWeight: FontWeight.bold),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
