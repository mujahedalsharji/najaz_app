/*
 * Najaz Mobile App
 * App Global Data & State
 * 
 * This file contains global state variables, stream controllers,
 * and app-wide data caching for the Najaz application.
 * Follows Bagisto's GlobalData pattern, tailored for Najaz service-based platform.
 */

import 'dart:async';

//import '../utils/constants/app_constants.dart';
import '../models/locale_models/locales_list_model.dart';
import '../utils/constants/server_configuration.dart';

/// Global Data class to store global data throughout the application
///
/// Stores:
/// - Language and locale settings
/// - Cookie for session management
/// - CMS data (privacy policy, terms, etc.)
/// - Services and categories data
/// - Core configuration data
/// - FCM token for push notifications
/// - Device information
/// - Stream controllers for app-wide state changes
///
/// Note: Tailored for Najaz service-based platform (no currency, cart, products).
class GlobalData {
  // ============================================================
  // LANGUAGE & LOCALE
  // ============================================================

  /// Current locale code (e.g., 'ar', 'en')
  static String locale = defaultStoreCode;

  /// Language data (list of available languages)
  static LocalesListModel? languageData;

  // ============================================================
  // SESSION & AUTHENTICATION
  // ============================================================

  /// Cookie string for session management
  static String? cookie;

  // ============================================================
  // CMS DATA
  // ============================================================

  /// CMS data (privacy policy, terms and conditions, etc.)
  /// TODO: Create CmsData model when needed
  // static CmsData? cmsData;

  // ============================================================
  // SERVICES & CATEGORIES DATA
  // ============================================================

  /// Services categories data (for navigation drawer, home screen)
  /// TODO: Create ServicesCategoriesData model when needed
  // static ServicesCategoriesData? categoriesData;

  /// Cached services data
  /// Key: service ID or category ID, Value: services data
  /// TODO: Create ServicesData model when needed
  // static Map<String, ServicesData?> allServices = {};

  // ============================================================
  // CORE CONFIGURATION
  // ============================================================

  /// Core configuration data from server
  /// TODO: Create CoreConfigs model when needed
  // static CoreConfigs? configData;

  // ============================================================
  // NOTIFICATIONS
  // ============================================================

  /// FCM (Firebase Cloud Messaging) token for push notifications
  static String fcmToken = "";

  // ============================================================
  // DEVICE INFORMATION
  // ============================================================

  /// Device name/model information
  static String deviceName = "";

  // ============================================================
  // STREAM CONTROLLERS
  // ============================================================

  /// Stream controller for notification count updates
  /// Broadcasts notification count changes across the app
  static final StreamController<int> notificationCountController =
      StreamController<int>.broadcast();

  /// Stream controller for services data updates
  /// Broadcasts when services data is updated (refresh, new data, etc.)
  /// TODO: Create ServicesData model when needed
  // static final StreamController<ServicesData?> servicesStream =
  //     StreamController<ServicesData?>.broadcast();

  /// Stream controller for booking updates
  /// Broadcasts when booking status changes or new bookings are created
  /// TODO: Create BookingData model when needed
  // static final StreamController<BookingData?> bookingStream =
  //     StreamController<BookingData?>.broadcast();

  /// Stream controller for app-wide state changes
  /// Can be used for any app-wide state updates (theme changes, language changes, etc.)
  static final StreamController<Map<String, dynamic>> appStateController =
      StreamController<Map<String, dynamic>>.broadcast();

  // ============================================================
  // HELPER METHODS
  // ============================================================

  /// Initializes global data from shared preferences
  /// Should be called during app initialization
  static void initializeFromSharedPreferences() {
    // Locale will be set from SharedPreferences in main.dart
    // Cookie will be set from SharedPreferences when available
    // FCM token will be set when Firebase is initialized
    // Device name will be set when device info is retrieved
  }

  /// Clears all global data
  /// Should be called on logout
  static void clear() {
    cookie = null;
    fcmToken = "";
    deviceName = "";
    languageData = null;
    // cmsData = null;
    // categoriesData = null;
    // allServices.clear();
    // configData = null;
  }

  /// Disposes all stream controllers
  /// Should be called when app is closing
  static void dispose() {
    notificationCountController.close();
    // servicesStream.close();
    // bookingStream.close();
    appStateController.close();
  }
}
