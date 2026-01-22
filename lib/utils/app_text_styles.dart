/*
 * Najaz Mobile App
 * Typography System - Text Styles
 * 
 * This file contains all text style definitions used throughout the app.
 * Typography follows Material Design guidelines with Najaz-specific customizations.
 * 
 * NOTE: Font family will be updated when brand font is provided.
 *       Currently using Google Fonts as placeholder.
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// App Text Styles - All typography constants for Najaz App
/// 
/// Text styles are organized by usage:
/// - Display (large headings)
/// - Headline (section headings)
/// - Title (card titles, screen titles)
/// - Label (buttons, form labels)
/// - Body (paragraphs, descriptions)
/// - Caption (small text, hints)
class AppTextStyles {
  // ============================================================
  // FONT FAMILY
  // ============================================================
  // TODO: Replace with brand font when provided
  // Currently using Google Fonts as placeholder
  // Common Arabic-friendly fonts: Cairo, Tajawal, Almarai
  static String? get fontFamily => GoogleFonts.cairo().fontFamily;
  
  // Alternative font options (can be switched when brand font is provided):
  // static String? get fontFamily => GoogleFonts.tajawal().fontFamily;
  // static String? get fontFamily => GoogleFonts.almarai().fontFamily;
  // static String? get fontFamily => 'BrandFontName'; // When brand font is provided
  
  // ============================================================
  // DISPLAY TEXT STYLES (Large Headings)
  // ============================================================
  // Used for: Splash screen titles, major page headings
  static TextStyle get displayLarge => TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
    height: 1.2,
  );
  
  static TextStyle get displayMedium => TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
    height: 1.2,
  );
  
  static TextStyle get displaySmall => TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
    height: 1.2,
  );
  
  // ============================================================
  // HEADLINE TEXT STYLES (Section Headings)
  // ============================================================
  // Used for: Screen titles, section headers, welcome headings
  static TextStyle get headlineLarge => TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
    height: 1.3,
  );
  
  static TextStyle get headlineMedium => TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
    height: 1.3,
  );
  
  static TextStyle get headlineSmall => TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
    height: 1.3,
  );
  
  // ============================================================
  // TITLE TEXT STYLES (Card Titles, Subheadings)
  // ============================================================
  // Used for: Card titles, list item titles, app bar titles
  static TextStyle get titleLarge => TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
    height: 1.4,
  );
  
  static TextStyle get titleMedium => TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
    height: 1.4,
  );
  
  static TextStyle get titleSmall => TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
    height: 1.4,
  );
  
  // ============================================================
  // LABEL TEXT STYLES (Buttons, Form Labels)
  // ============================================================
  // Used for: Button text, form field labels, navigation labels
  static TextStyle get labelLarge => TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
    height: 1.5,
    letterSpacing: 0.5,
  );
  
  static TextStyle get labelMedium => TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
    height: 1.5,
    letterSpacing: 0.5,
  );
  
  static TextStyle get labelSmall => TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
    height: 1.5,
    letterSpacing: 0.5,
  );
  
  // ============================================================
  // BODY TEXT STYLES (Paragraphs, Descriptions)
  // ============================================================
  // Used for: Body text, descriptions, content paragraphs
  static TextStyle get bodyLarge => TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
    height: 1.5,
  );
  
  static TextStyle get bodyMedium => TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
    height: 1.5,
  );
  
  static TextStyle get bodySmall => TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
    height: 1.5,
  );
  
  // ============================================================
  // CAPTION TEXT STYLES (Small Text, Hints)
  // ============================================================
  // Used for: Captions, hints, timestamps, small labels
  static TextStyle get captionLarge => TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    fontFamily: fontFamily,
    height: 1.4,
  );
  
  static TextStyle get captionMedium => TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    fontFamily: fontFamily,
    height: 1.4,
  );
  
  static TextStyle get captionSmall => TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textTertiary,
    fontFamily: fontFamily,
    height: 1.4,
  );
  
  // ============================================================
  // BUTTON TEXT STYLES
  // ============================================================
  // Used for: Primary buttons, secondary buttons
  static TextStyle get buttonPrimary => TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: AppColors.buttonPrimaryText,
    fontFamily: fontFamily,
    letterSpacing: 0.5,
  );
  
  static TextStyle get buttonSecondary => TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: AppColors.buttonSecondaryText,
    fontFamily: fontFamily,
    letterSpacing: 0.5,
  );
  
  static TextStyle get buttonText => TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryColor,
    fontFamily: fontFamily,
    letterSpacing: 0.5,
  );
  
  // ============================================================
  // INPUT FIELD TEXT STYLES
  // ============================================================
  // Used for: Input field text, placeholders, labels
  static TextStyle get inputLabel => TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: AppColors.inputLabel,
    fontFamily: fontFamily,
    height: 1.4,
  );
  
  static TextStyle get inputText => TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    fontFamily: fontFamily,
    height: 1.5,
  );
  
  static TextStyle get inputHint => TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: AppColors.inputHint,
    fontFamily: fontFamily,
    height: 1.5,
  );
  
  static TextStyle get inputError => TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: AppColors.error,
    fontFamily: fontFamily,
    height: 1.4,
  );
  
  // ============================================================
  // APP BAR TEXT STYLES
  // ============================================================
  // Used for: App bar titles
  static TextStyle get appBarTitle => TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: AppColors.appBarText,
    fontFamily: fontFamily,
  );
  
  // ============================================================
  // LINK TEXT STYLES
  // ============================================================
  // Used for: Clickable links, navigation links
  static TextStyle get link => TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: AppColors.link,
    fontFamily: fontFamily,
    decoration: TextDecoration.underline,
    height: 1.5,
  );
  
  // ============================================================
  // ERROR TEXT STYLES
  // ============================================================
  // Used for: Error messages, validation errors
  static TextStyle get error => TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: AppColors.error,
    fontFamily: fontFamily,
    height: 1.4,
  );
  
  static TextStyle get errorLarge => TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: AppColors.error,
    fontFamily: fontFamily,
    height: 1.4,
  );
  
  // ============================================================
  // SUCCESS TEXT STYLES
  // ============================================================
  // Used for: Success messages, confirmation text
  static TextStyle get success => TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    color: AppColors.success,
    fontFamily: fontFamily,
    height: 1.4,
  );
  
  static TextStyle get successLarge => TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: AppColors.success,
    fontFamily: fontFamily,
    height: 1.4,
  );
  
  // ============================================================
  // OVERRIDE METHODS (for custom colors)
  // ============================================================
  // Helper methods to apply custom colors to text styles
  
  static TextStyle displayLargeWithColor(Color color) => displayLarge.copyWith(color: color);
  static TextStyle headlineLargeWithColor(Color color) => headlineLarge.copyWith(color: color);
  static TextStyle titleLargeWithColor(Color color) => titleLarge.copyWith(color: color);
  static TextStyle bodyLargeWithColor(Color color) => bodyLarge.copyWith(color: color);
  static TextStyle bodyMediumWithColor(Color color) => bodyMedium.copyWith(color: color);
  static TextStyle labelLargeWithColor(Color color) => labelLarge.copyWith(color: color);
}

/// Helper class for theme-aware text styles
class AppTextStylesHelper {
  /// Get text style based on theme mode
  static TextStyle getTextStyle({
    required TextStyle lightStyle,
    required TextStyle darkStyle,
    required bool isDarkMode,
  }) {
    return isDarkMode ? darkStyle : lightStyle;
  }
  
  /// Get primary text color based on theme
  static Color getTextColor({required bool isDarkMode}) {
    return isDarkMode ? AppColors.textPrimaryDark : AppColors.textPrimary;
  }
  
  /// Get secondary text color based on theme
  static Color getSecondaryTextColor({required bool isDarkMode}) {
    return isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondary;
  }
}

