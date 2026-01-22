/*
 * Najaz Mobile App
 * Assets Constants
 * 
 * This file contains all asset path constants.
 * Following Bagisto's assets_constants.dart pattern.
 */

/// Asset Constants - All asset paths for the app
class AssetConstants {
  // ============================================================
  // LOTTIE ANIMATIONS
  // ============================================================

  /// Splash screen animation
  static const String splashLottie = "assets/lottie/splash_screen.json";

  /// Empty states animations
  static const String emptyServices = "assets/lottie/empty_services.json";
  static const String emptyBookings = "assets/lottie/empty_catalog.json";
  static const String emptyNotifications =
      "assets/lottie/empty_notifications.json";
  static const String emptySearch = "assets/lottie/empty_search.json";

  /// Loading animations
  static const String loading = "assets/lottie/loading.json";
  static const String success = "assets/lottie/success.json";
  static const String error = "assets/lottie/error.json";

  // ============================================================
  // OVERLAY SVGs
  // ============================================================
  static const String waitingOverlay = "Ui-Ux Screens/Waiting overlay.svg";
  static const String modifyingOverlay =
      "Ui-Ux Screens/modifying overlay-1.svg";
  static const String rejectOverlay = "Ui-Ux Screens/Reject overlay.svg";
  static const String successOverlay = "Ui-Ux Screens/Success overlay.svg";
  static const String processingOverlay =
      "Ui-Ux Screens/processing overlay-1.svg";

  // ============================================================
  // IMAGES
  // ============================================================

  /// Splash screen image
  static const String vector = "assets/images/Vector.png";
  static const String vectorAuth = "assets/images/Vector auth.png";

  static const String homeAppBarVector = "assets/images/HomeVector.png";

  /// Placeholder images
  static const String placeHolder = "assets/images/placeholder.png";
  static const String userPlaceHolder = "assets/images/user_placeholder.png";
  static const String servicePlaceHolder =
      "assets/images/service_placeholder.png";

  /// Icons
  static const String appIcon = "assets/images/app_icon.png";
  static const String logo = "assets/images/Logo.png";

  // ============================================================
  // FONTS
  // ============================================================

  /// Font family (will be updated when brand font is provided)
  /// Currently using Google Fonts Cairo
  static const String fontFamily = "Cairo";

  // ============================================================
  // LANGUAGE FILES
  // ============================================================

  /// Language JSON files path
  static const String languagePath = "assets/language/";

  /// Arabic language file
  static const String languageAr = "assets/language/ar.json";

  /// English language file
  static const String languageEn = "assets/language/en.json";
}
