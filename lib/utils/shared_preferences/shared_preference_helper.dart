/*
 * Najaz Mobile App
 * Shared Preference Helper
 * 
 * This file provides helper methods for storing and retrieving data
 * from local storage using get_storage package.
 * Tailored for Najaz app (service-based platform).
 */

import 'package:get_storage/get_storage.dart';

import '../constants/app_constants.dart';
import 'shared_preference_keys.dart';

/// Shared Preference Helper - Singleton instance for app-wide use

final appStoragePref = SharedPreferenceHelper();

/// Shared Preference Helper Class
///
/// Provides methods to store and retrieve data from local storage.
/// Uses GetStorage for efficient key-value storage.
///
/// Note: This is tailored for Najaz (service-based platform),
/// does not include e-commerce features like cart, orders, payments, reviews.
class SharedPreferenceHelper {
  // Named storage box for storing app configuration data
  // Use only for user app configuration data
  final GetStorage _configurationStorage = GetStorage("configurationStorage");

  // ============================================================
  // AUTHENTICATION & USER DATA
  // ============================================================

  String getCitizenToken() {
    return _configurationStorage.read(citizenToken) ?? "";
  }

  void setCitizenToken(String customerTokenValue) {
    _configurationStorage.write(citizenToken, customerTokenValue);
  }

  String getRefreshToken() {
    return _configurationStorage.read(refreshToken) ?? "";
  }

  void setRefreshToken(String refreshTokenValue) {
    _configurationStorage.write(refreshToken, refreshTokenValue);
  }

  bool getCitizenLoggedIn() {
    return _configurationStorage.read(citizenLoggedIn) ?? false;
  }

  void setCitizenLoggedIn(bool isLoggedIn) {
    _configurationStorage.write(citizenLoggedIn, isLoggedIn);
  }

  int getCitizenId() {
    return _configurationStorage.read(citizenId) ?? 0;
  }

  void setCitizenId(int customerIdNew) {
    _configurationStorage.write(citizenId, customerIdNew);
  }

  String getCitizenName() {
    return _configurationStorage.read(citizenName) ?? "";
  }

  void setCitizenName(String customerNameValue) {
    _configurationStorage.write(citizenName, customerNameValue);
  }

  String getCitizenEmail() {
    return _configurationStorage.read(citizenEmail) ?? "";
  }

  void setCitizenEmail(String customerEmailNew) {
    _configurationStorage.write(citizenEmail, customerEmailNew);
  }

  String getCitizenPhone() {
    return _configurationStorage.read(citizenPhone) ?? "";
  }

  void setCitizenPhone(String phone) {
    _configurationStorage.write(citizenPhone, phone);
  }

  String getCitizenImage() {
    return _configurationStorage.read(citizenImage) ?? "";
  }

  void setCitizenImage(String customerImageValue) {
    _configurationStorage.write(citizenImage, customerImageValue);
  }

  String getCitizenProfilePicUrl() {
    return _configurationStorage.read(citizenProfilePicUrl) ?? "";
  }

  void setCitizenProfilePicUrl(String url) {
    _configurationStorage.write(citizenProfilePicUrl, url);
  }

  Map<String, dynamic>? getCitizenDetails() {
    return _configurationStorage.read(citizenDetails);
  }

  void setCitizenDetails(Map<String, dynamic>? details) {
    if (details != null) {
      _configurationStorage.write(citizenDetails, details);
    } else {
      _configurationStorage.remove(citizenDetails);
    }
  }

  // ============================================================
  // APP CONFIGURATION
  // ============================================================

  String getTheme() {
    return _configurationStorage.read(themeKey) ?? "light";
  }

  void setTheme(String value) {
    _configurationStorage.write(themeKey, value);
  }

  String getLanguageName() {
    return _configurationStorage.read(language) ??
        AppConstants.defaultLanguageName;
  }

  void setLanguageName(String customerLanguage) {
    _configurationStorage.write(language, customerLanguage);
  }

  String getCitizenLanguage() {
    return _configurationStorage.read(citizenLanguage) ??
        AppConstants.defaultLanguageCode;
  }

  void setCitizenLanguage(String languageCode) {
    _configurationStorage.write(citizenLanguage, languageCode);
  }

  // ============================================================
  // ONBOARDING & FIRST TIME
  // ============================================================

  bool getOnboardingCompleted() {
    return _configurationStorage.read(onboardingCompleted) ?? false;
  }

  void setOnboardingCompleted(bool completed) {
    _configurationStorage.write(onboardingCompleted, completed);
  }

  bool getIsFirstLaunch() {
    return _configurationStorage.read(isFirstLaunch) ?? true;
  }

  void setIsFirstLaunch(bool isFirst) {
    _configurationStorage.write(isFirstLaunch, isFirst);
  }

  // ============================================================
  // APP STATE
  // ============================================================

  String getDate() {
    return _configurationStorage.read(date) ?? "";
  }

  void setDate(String setDate) {
    _configurationStorage.write(date, setDate);
  }

  String getSortName() {
    return _configurationStorage.read(sort) ?? "";
  }

  void setSortName(String selectedSort) {
    _configurationStorage.write(sort, selectedSort);
  }

  String getCookieGet() {
    return _configurationStorage.read(cookie) ?? "";
  }

  void setCookieGet(String cookieData) {
    _configurationStorage.write(cookie, cookieData);
  }

  // ============================================================
  // ACCOUNT VERIFICATION (Najaz specific - video verification)
  // ============================================================

  bool getAccountVerified() {
    return _configurationStorage.read(accountVerified) ?? false;
  }

  void setAccountVerified(bool verified) {
    _configurationStorage.write(accountVerified, verified);
  }

  Map<String, dynamic>? getAccountVerificationData() {
    return _configurationStorage.read(accountVerificationData);
  }

  void setAccountVerificationData(Map<String, dynamic>? data) {
    if (data != null) {
      _configurationStorage.write(accountVerificationData, data);
    } else {
      _configurationStorage.remove(accountVerificationData);
    }
  }

  // ============================================================
  // NOTIFICATIONS
  // ============================================================

  bool getNotificationPermissionGranted() {
    return _configurationStorage.read(notificationPermissionGranted) ?? false;
  }

  void setNotificationPermissionGranted(bool granted) {
    _configurationStorage.write(notificationPermissionGranted, granted);
  }

  String getFcmToken() {
    return _configurationStorage.read(fcmToken) ?? "";
  }

  void setFcmToken(String token) {
    _configurationStorage.write(fcmToken, token);
  }

  // ============================================================
  // CACHE & DATA (Najaz specific - services and bookings)
  // ============================================================

  Map<String, dynamic>? getServicesCache() {
    return _configurationStorage.read(servicesCache);
  }

  void setServicesCache(Map<String, dynamic>? data) {
    if (data != null) {
      _configurationStorage.write(servicesCache, data);
    } else {
      _configurationStorage.remove(servicesCache);
    }
  }

  Map<String, dynamic>? getCategoriesCache() {
    return _configurationStorage.read(categoriesCache);
  }

  void setCategoriesCache(Map<String, dynamic>? data) {
    if (data != null) {
      _configurationStorage.write(categoriesCache, data);
    } else {
      _configurationStorage.remove(categoriesCache);
    }
  }

  int getLastCacheUpdate() {
    return _configurationStorage.read(lastCacheUpdate) ?? 0;
  }

  void setLastCacheUpdate(int timestamp) {
    _configurationStorage.write(lastCacheUpdate, timestamp);
  }

  // ============================================================
  // UTILITY METHODS
  // ============================================================

  /// Clear all user data (logout)
  void onUserLogout() {
    _configurationStorage.write(citizenLoggedIn, false);
    _configurationStorage.write(citizenToken, "");
    _configurationStorage.write(refreshToken, "");
    _configurationStorage.write(citizenName, "");
    _configurationStorage.write(citizenEmail, "");
    _configurationStorage.write(citizenPhone, "");
    _configurationStorage.write(citizenProfilePicUrl, "");
    _configurationStorage.write(citizenImage, "");
    _configurationStorage.write(citizenId, 0);
    _configurationStorage.remove(citizenDetails);
    _configurationStorage.remove(accountVerificationData);
  }

  /// Clear all data (including app settings)
  void clearAllData() {
    _configurationStorage.erase();
  }

  /// Remove specific key
  void remove(String key) {
    _configurationStorage.remove(key);
  }
}
