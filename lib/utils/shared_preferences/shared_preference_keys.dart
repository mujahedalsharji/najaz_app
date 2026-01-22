/*
 * Najaz Mobile App
 * Shared Preference Keys
 * 
 * This file contains all keys used for shared preferences storage.
 * Tailored for Najaz app (service-based, no payment/orders/reviews).
 */

// Shared Preference Keys - All keys for local storage

/// Configuration Shared Preference Keys
// const String configCurrencyCode = "configCurrencyCode";
// const String configCurrencySymbol = "configCurrencySymbol";
// const String configCurrencyLabel = "configCurrencyLabel";
const String themeKey = "najazTheme";

/// Customer Shared Preference Keys
const String citizenLoggedIn = "citizenIsLoggedIn";
const String citizenToken = "citizenToken";
const String refreshToken = "refreshToken";
const String citizenName = "citizenName";
const String citizenImage = "citizenImage";
const String citizenEmail = "citizenEmail";
const String citizenPhone = "citizenPhone";
const String citizenProfilePicUrl = "citizenProfilePicUrl";
const String citizenId = "citizenId";
const String cookie = "cookie";
const String citizenLanguage = "citizenLanguage";
const String citizenDetails = "citizenDetails";

/// Onboarding & First Launch Keys
const String onboardingCompleted = "onboardingCompleted";
const String isFirstLaunch = "isFirstLaunch";

/// App State Keys
const String date = "date";
const String language = "language";
const String sort = "sort";

/// Account Verification Keys (Najaz specific - video verification)
const String accountVerified = "accountVerified";
const String accountVerificationData = "accountVerificationData";

/// Notification Keys
const String notificationPermissionGranted = "notificationPermissionGranted";
const String fcmToken = "fcmToken";

/// Cache Keys (Najaz specific - services and bookings)
const String servicesCache = "servicesCache";
const String categoriesCache = "categoriesCache";
const String lastCacheUpdate = "lastCacheUpdate";
