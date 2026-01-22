/*
 * Najaz Mobile App
 * Color System - Extracted from Figma Designs
 * 
 * This file contains all color constants used throughout the app.
 * Colors are extracted from Figma designs and organized by category.
 * 
 * NOTE: Colors marked with [TODO: Extract from Figma] need to be updated
 *       with actual values from the Figma design files.
 * 
 * IMPORTANT: This is a service-based app (not e-commerce).
 * - No payment method colors
 * - No order status colors (using booking status colors instead)
 * - Rating colors are optional (only if reviews feature is implemented)
 */

import 'package:flutter/material.dart';

/// App Colors - All color constants for Najaz App
/// 
/// Colors are organized into categories:
/// - Brand Colors (Primary, Secondary - from brand guidelines)
/// - UI Colors (Backgrounds, Surfaces, Borders)
/// - Text Colors
/// - Semantic Colors (Success, Error, Warning, Info)
/// - Status Colors (for booking statuses)
/// - Neutral Colors (Grays)
class AppColors {
  // ============================================================
  // BRAND COLORS
  // ============================================================
  // Extracted from Najaz Figma designs
  // Primary brand color - used in buttons, borders, primary actions
  // Found in: Sign-up buttons, Welcome screen buttons, input focused borders
  static const Color primaryColor = Color(0xFF483A1E); // #483A1E - Dark brown/beige (Najaz brand color)
  
  // Secondary brand color - decorative backgrounds
  // Found in: Splash screen background, Welcome screen decorative elements
  static const Color secondaryColor = Color(0xFFDFCA9F); // #DFCA9F - Light beige (decorative background)
  
  // Primary color variants (light/dark shades)
  static const Color primaryLight = Color(0xFF6B5A3D); // Lighter shade of primary
  static const Color primaryDark = Color(0xFF2A2114);  // Darker shade of primary
  
  // Brand accent color (gold/brown variant)
  // Found in: Datepicker selected dates, calendar highlights
  static const Color brandAccent = Color(0xFFB3914C); // #B3914C - Gold/brown accent color
  
  // ============================================================
  // BACKGROUND & SURFACE COLORS
  // ============================================================
  // Extracted from Najaz Figma designs
  // Main screen background - used across all screens
  static const Color backgroundLight = Color(0xFFFCFBF8); // #FCFBF8 - Very light beige/cream (main background)
  static const Color backgroundDark = Color(0xFF121212);  // Dark mode background (if applicable in future)
  
  // Surface colors (cards, containers, elevated surfaces)
  static const Color surfaceLight = Color(0xFFFFFFFF);    // White for cards/surfaces
  static const Color surfaceDark = Color(0xFF1E1E1E);     // Dark mode surface (if applicable)
  
  // Additional background colors from designs
  static const Color backgroundSecondary = Color(0xFFF7F4ED); // #F7F4ED - Light beige (alternative background)
  static const Color backgroundGray = Color(0xFFEDEDED);      // #EDEDED - Light gray background
  
  // Scaffold background
  static const Color scaffoldBackgroundLight = Color(0xFFFCFBF8); // Same as backgroundLight

  static const Color scaffoldBackgroundSplash = Color(0xFFDFCA9F);
  static const Color scaffoldBackgroundDark = Color(0xFF000000);  // Dark mode scaffold
  
  // ============================================================
  // TEXT COLORS
  // ============================================================
  // Extracted from Najaz Figma designs
  // Primary text color - main headings, body text
  static const Color textPrimary = Color(0xFF1D1B20);     // #1D1B20 - Very dark (almost black) - main text
  static const Color textSecondary = Color(0xFF757575);   // Medium gray for secondary text
  static const Color textTertiary = Color(0xFFBDBDBD);    // Light gray for tertiary/disabled text
  static const Color textOnPrimary = Color(0xFFFFFFFF);   // White text on primary colored background (buttons)
  static const Color textOnSecondary = Color(0xFF1D1B20); // Dark text on secondary background
  static const Color textHint = Color(0xFF9E9E9E);        // Gray for input field hint text
  static const Color textDisabled = Color(0xFFBDBDBD);    // Light gray for disabled text
  
  // Text colors for dark mode (if applicable)
  static const Color textPrimaryDark = Color(0xFFFFFFFF); // White text for dark mode
  static const Color textSecondaryDark = Color(0xFFB0B0B0); // Light gray for dark mode
  
  // Additional text colors from new UI designs
  static const Color textDatepicker = Color(0xFF131A29); // #131A29 - Dark text used in datepicker (slightly different from textPrimary)
  static const Color textDisabledGray = Color(0xFFC4C4C4); // #C4C4C4 - Gray for disabled/inactive text (datepicker inactive days)
  static const Color textMediumGray = Color(0xFF888888); // #888888 - Medium gray text (datepicker button text)
  
  // ============================================================
  // SEMANTIC COLORS (Success, Error, Warning, Info)
  // ============================================================
  // Extracted from Najaz Figma designs
  // Error color - used in error states, error borders, error messages
  // Found in: Error screens (phone already used, invalid OTP)
  static const Color error = Color(0xFFDC3545);           // #DC3545 - Red (error states, error borders)
  static const Color errorLight = Color(0xFFFFEBEE);      // Light red variant for error backgrounds
  static const Color errorDark = Color(0xFFC62828);       // Darker red for emphasis
  
  // Success color - used for success states, validation
  // Found in: Success indicators in designs
  static const Color success = Color(0xFF28A745);         // #28A745 - Green (success states)
  static const Color successLight = Color(0xFFE8F5E9);    // Light green variant
  static const Color successDark = Color(0xFF2E7D32);     // Darker green
  static const Color successOverlay = Color(0xFFEAFAEE);  // #EAFAEE - Light green background for success overlays
  
  // Warning color - for warning states
  static const Color warning = Color(0xFFFF9800);         // Orange for warnings
  static const Color warningLight = Color(0xFFFFF3E0);    // Light orange variant
  static const Color warningDark = Color(0xFFE65100);     // Darker orange
  
  // Info color - for informational messages
  static const Color info = Color(0xFF2196F3);            // Blue for info
  static const Color infoLight = Color(0xFFE3F2FD);       // Light blue variant
  static const Color infoDark = Color(0xFF0D47A1);        // Darker blue
  
  // ============================================================
  // INPUT FIELD COLORS
  // ============================================================
  // Extracted from Najaz Figma designs
  // Input field styles - from Sign-up, Sign-in, OTP screens
  static const Color inputBackground = Color(0xFFE6E6E6);     // #E6E6E6 - Light gray input background
  static const Color inputBorder = Color(0xFF555555);         // #555555 - Gray default border
  static const Color inputBorderFocused = Color(0xFF483A1E);  // #483A1E - Primary color for focused border
  static const Color inputBorderError = Color(0xFFDC3545);    // #DC3545 - Red error border
  static const Color inputLabel = Color(0xFF1D1B20);          // Dark text for labels
  static const Color inputHint = Color(0xFF9E9E9E);           // Gray for hint text
  
  // ============================================================
  // BUTTON COLORS
  // ============================================================
  // Extracted from Najaz Figma designs
  // Button styles - from Sign-up, Welcome, Sign-in screens
  static const Color buttonPrimary = Color(0xFF483A1E);       // #483A1E - Primary button background (brand color)
  static const Color buttonPrimaryText = Color(0xFFFFFFFF);   // White text on primary button
  static const Color buttonSecondary = Color(0xFFFFFFFF);     // White/secondary button background
  static const Color buttonSecondaryText = Color(0xFF483A1E); // Primary color text on secondary button
  static const Color buttonDisabled = Color(0xFFE6E6E6);      // Light gray for disabled button
  static const Color buttonDisabledText = Color(0xFF9E9E9E);  // Gray text for disabled button
  
  // ============================================================
  // APP BAR & NAVIGATION COLORS
  // ============================================================
  // Extracted from Najaz Figma designs
  // App bar styles - matching screen backgrounds
  static const Color appBarBackground = Color(0xFFFCFBF8);    // Same as background - light beige
  static const Color appBarText = Color(0xFF1D1B20);          // Dark text matching primary text
  static const Color appBarIcon = Color(0xFF1D1B20);          // Dark icons matching text color
  
  // ============================================================
  // DIVIDER & BORDER COLORS
  // ============================================================
  // Extracted from Najaz Figma designs
  static const Color divider = Color(0xFFE0E0E0);          // Light gray divider
  static const Color dividerDark = Color(0xFF424242);      // Darker divider for dark mode
  static const Color border = Color(0xFF555555);           // #555555 - Gray border (matching input borders)
  static const Color borderDark = Color(0xFF424242);       // Darker border for dark mode
  
  // ============================================================
  // NEUTRAL COLORS (Grays)
  // ============================================================
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);  // #F5F5F5 - Used in datepicker borders, calendar backgrounds
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey250 = Color(0xFFDDDDDD);  // #DDDDDD - Light gray used in datepicker buttons
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey350 = Color(0xFFC4C4C4);  // #C4C4C4 - Gray for disabled/inactive states (datepicker inactive days)
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey450 = Color(0xFF888888);  // #888888 - Medium gray (datepicker button text)
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);
  
  // Material Grey (can be used if needed)
  static const MaterialColor greyColor = Colors.grey;
  
  // ============================================================
  // UTILITY COLORS
  // ============================================================
  static const Color transparent = Colors.transparent;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  
  // Skeleton loader colors (for loading states)
  static const Color skeletonLoaderLight = Color(0xFFE6E6E6);  // Light gray matching input background
  static const Color skeletonLoaderDark = Color(0xFF424242);   // Darker gray for dark mode
  
  // Shimmer colors (for shimmer loading effects)
  static const Color shimmerBase = Color(0xFFE0E0E0);        // Light gray base color
  static const Color shimmerHighlight = Color(0xFFF5F5F5);   // Lighter gray highlight color
  
  // Link color
  static const Color link = Color(0xFF483A1E);                 // Primary brand color for links
  
  // Shadow colors
  static const Color shadowLight = Color(0x1A000000);          // 10% opacity black
  static const Color shadowMedium = Color(0x33000000);         // 20% opacity black
  static const Color shadowDark = Color(0x4D000000);           // 30% opacity black
  
  // ============================================================
  // BOOKING STATUS COLORS
  // ============================================================
  // Colors for booking statuses (service-based app)
  // TODO: Extract from Figma if status colors are defined
  // These are used for booking status badges (pending, confirmed, completed, cancelled)
  static const Color bookingPending = Color(0xFFFF9800);        // Orange - Booking pending confirmation
  static const Color bookingConfirmed = Color(0xFF4CAF50);      // Green - Booking confirmed
  static const Color bookingCompleted = Color(0xFF4CAF50);      // Green - Service completed
  static const Color bookingCancelled = Color(0xFFE53935);      // Red - Booking cancelled
  static const Color bookingInProgress = Color(0xFF2196F3);     // Blue - Service in progress
  
  // ============================================================
  // OVERLAY & MODAL COLORS
  // ============================================================
  static const Color overlay = Color(0x80000000);              // 50% opacity black for overlays
  static const Color modalBackground = Color(0xFFFFFFFF);      // TODO: Extract from Figma
  
}

/// Helper class for getting colors based on theme mode
class AppColorsHelper {
  /// Get background color based on theme mode
  static Color getBackground({required bool isDarkMode}) {
    return isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight;
  }
  
  /// Get surface color based on theme mode
  static Color getSurface({required bool isDarkMode}) {
    return isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight;
  }
  
  /// Get primary text color based on theme mode
  static Color getTextPrimary({required bool isDarkMode}) {
    return isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;
  }
  
  /// Get secondary text color based on theme mode
  static Color getTextSecondary({required bool isDarkMode}) {
    return isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondary;
  }
  
  /// Get divider color based on theme mode
  static Color getDivider({required bool isDarkMode}) {
    return isDarkMode ? AppColors.dividerDark : AppColors.divider;
  }
}

