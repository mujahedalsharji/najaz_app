/*
 * Najaz Mobile App
 * App Constants
 * 
 * This file contains general app constants like app name, version,
 * default values, and supported locales.
 */

import 'package:flutter/material.dart';

/// App Constants - General application constants
class AppConstants {
  // ============================================================
  // APP INFORMATION
  // ============================================================

  /// App name
  static const String appName = "Najaz";

  /// App version (will be updated from pubspec.yaml during build)
  static const String appVersion = "1.0.0";

  /// App package name
  static const String appPackageName = "com.najaz.app";

  // ============================================================
  // DEFAULT VALUES
  // ============================================================

  /// Default splash screen delay (in seconds)
  static const int defaultSplashDelay = 3;

  /// Default language name
  static const String defaultLanguageName = "العربية"; // Arabic

  /// Default language code
  static const String defaultLanguageCode = "ar";

  // ============================================================
  // SUPPORTED LOCALES
  // ============================================================

  /// Supported locales in the app
  /// Primary: Arabic (ar)
  /// Secondary: English (en)
  static const List<Locale> supportedLocales = [
    Locale('ar'), // Arabic (primary)
    Locale('en'), // English (secondary)
  ];

  // ============================================================
  // APP CONFIGURATION
  // ============================================================

  /// Enable pre-fetching (for future use)
  static const bool isPreFetchingEnable = true;

  /// Minimum password length
  static const int minPasswordLength = 8;

  /// Maximum password length
  static const int maxPasswordLength = 30;

  /// OTP code length
  static const int otpCodeLength = 6;

  /// Phone number length (Saudi Arabia)
  static const int phoneNumberLength = 9; // Without country code

  /// Country code for Saudi Arabia
  static const String defaultCountryCode = "+967";

  // ============================================================
  // DATE & TIME FORMATS
  // ============================================================

  /// Default date format
  static const String defaultDateFormat = "yyyy-MM-dd";

  /// Default time format
  static const String defaultTimeFormat = "HH:mm";

  /// Default date-time format
  static const String defaultDateTimeFormat = "yyyy-MM-dd HH:mm";

  // ============================================================
  // PAGINATION
  // ============================================================

  /// Default page size for lists
  static const int defaultPageSize = 20;

  /// Maximum page size
  static const int maxPageSize = 100;

  // ============================================================
  // CACHE & STORAGE
  // ============================================================

  /// Cache expiration time (in seconds)
  static const int cacheExpirationTime = 3600; // 1 hour

  /// Image cache expiration time (in seconds)
  static const int imageCacheExpirationTime = 86400; // 24 hours
}
