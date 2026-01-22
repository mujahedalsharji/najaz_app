/*
 * Najaz Mobile App
 * Server Configuration
 * 
 * This file contains server configuration constants including
 * base URL, API endpoints, and default headers.
 * Tailored for Najaz app (service-based platform, no e-commerce).
 */

import 'package:flutter/material.dart';

/// Server Configuration - API and server settings
///
/// Tailored for Najaz service-based platform.
/// Note: Does not include e-commerce features (currency, payments, orders, etc.)

/// Default splash screen delay (in seconds)
const int defaultSplashDelay = 10;

/// Base domain for Najaz API
const String baseDomain = "https://najaz.rawnaqq.com";

/// Base URL for GraphQL endpoint
const String baseUrl = "$baseDomain/graphql";

/// Default language code
const String defaultStoreCode = "ar"; // Arabic default for Najaz

/// Default language name
const String defaultLanguageName = "العربية"; // Arabic

/// Supported locales in app
/// Primary: Arabic (ar)
/// Secondary: English (en)
List<Locale> supportedLocale = [
  Locale('ar'), // Arabic (primary)
  Locale('en'), // English (secondary)
];

/// Enable pre-fetching (for future use)
const bool isPreFetchingEnable = true;

/// Default app title
const String defaultAppTitle = "Najaz";
