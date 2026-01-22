/*
 * Najaz Mobile App
 * Spacing System
 * 
 * This file contains all spacing constants used throughout the app.
 * Follows Bagisto's AppSizes pattern for consistency.
 */

import 'package:flutter/material.dart';

/// App Spacing - All spacing constants for Najaz App
/// 
/// Follows Bagisto's simple spacing approach.
/// Use MediaQuery.of(context) directly in widgets for responsive layouts.
class AppSpacing {
  // ============================================================
  // BASE SPACING VALUES
  // ============================================================
  
  /// Small spacing: 4dp
  static const double spacingSmall = 4.0;
  
  /// Normal spacing: 8dp
  static const double spacingNormal = 8.0;
  
  /// Medium spacing: 12dp
  static const double spacingMedium = 12.0;
  
  /// Large spacing: 16dp
  static const double spacingLarge = 16.0;
  
  /// Wide spacing: 20dp
  static const double spacingWide = 20.0;
  
  // ============================================================
  // SIZES
  // ============================================================
  
  /// Button height (standard)
  static const double buttonHeight = 48.0;
  
  /// Button width (standard) - optional, can use full width with MediaQuery
  static const double buttonWidth = 270.0;
  
  // ============================================================
  // SCREEN DIMENSIONS
  // ============================================================
  /// Screen dimensions (static - from platform dispatcher)
  /// Similar to Bagisto's approach
  /// 
  /// For widget-specific dimensions, use MediaQuery.of(context).size directly
  
  static double get safeAreaPadding =>
      MediaQueryData.fromView(
        WidgetsBinding.instance.platformDispatcher.views.single,
      ).padding.top;
  
  static double get screenHeight =>
      MediaQueryData.fromView(
        WidgetsBinding.instance.platformDispatcher.views.single,
      ).size.height;
  
  static double get screenWidth =>
      MediaQueryData.fromView(
        WidgetsBinding.instance.platformDispatcher.views.single,
      ).size.width;
  
  // ============================================================
  // HELPER METHODS (Context-based - use in widgets)
  // ============================================================
  /// Use these methods when you need context-aware dimensions in widgets
  
  /// Get screen width from context
  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  
  /// Get screen height from context
  static double getScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  
  /// Get safe area top padding from context
  static double getSafeAreaTop(BuildContext context) =>
      MediaQuery.of(context).padding.top;
  
  /// Get safe area bottom padding from context
  static double getSafeAreaBottom(BuildContext context) =>
      MediaQuery.of(context).padding.bottom;
}


