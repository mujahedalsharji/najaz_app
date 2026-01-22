/*
 * Najaz Mobile App
 * Route Constants
 * 
 * This file contains all route name constants used for navigation.
 * Following Bagisto's route_constants.dart pattern.
 */

/// Route Constants - All route names for navigation
class RouteConstants {
  // ============================================================
  // AUTHENTICATION ROUTES
  // ============================================================
  
  /// Welcome/Onboarding screen route
  /// Note: Splash screen is handled by flutter_native_splash package
  static const String welcome = 'welcomeScreen';
  
  /// Sign up screen route
  static const String signUp = 'signUp';
  
  /// Sign in screen route
  static const String signIn = 'signIn';
  
  /// Forgot password screen route
  static const String forgotPassword = 'forgotPassword';
  
  /// Reset password screen route
  static const String resetPassword = 'resetPassword';
  
  /// Account verification screen route
  static const String accountVerification = 'accountVerification';
  
  // ============================================================
  // MAIN APP ROUTES
  // ============================================================
  
  /// Home screen route
  static const String home = 'homeScreen';
  
  /// Services screen route
  static const String services = 'servicesScreen';
  
  /// Service details screen route
  static const String serviceDetails = 'serviceDetailsScreen';
  
  /// History screen route
  static const String history = 'historyScreen';
  
  /// Profile screen route
  static const String profile = 'profileScreen';
  
  // ============================================================
  // PROFILE & ACCOUNT ROUTES
  // ============================================================
  
  /// Account information screen route
  static const String accountInfo = 'accountInfo';
  
  /// Edit profile screen route
  static const String editProfile = 'editProfile';
  
  /// Change password screen route
  static const String changePassword = 'changePassword';
  
  /// Privacy policy screen route
  static const String privacyPolicy = 'privacyPolicy';
  
  /// Terms and conditions screen route
  static const String termsAndConditions = 'termsAndConditions';
  
  // ============================================================
  // SERVICE & BOOKING ROUTES
  // ============================================================
  
  /// Booking details screen route
  static const String bookingDetails = 'bookingDetailsScreen';
  
  /// Create booking screen route
  static const String createBooking = 'createBookingScreen';
  
  /// Booking confirmation screen route
  static const String bookingConfirmation = 'bookingConfirmationScreen';

  // ============================================================
  // REQUEST ROUTES
  // ============================================================

  /// Request details screen route
  static const String requestDetails = 'requestDetailsScreen';

  /// Request document screen route
  static const String requestDocument = 'requestDocumentScreen';

  /// Request edit screen route
  static const String requestEdit = 'requestEditScreen';

  /// Request rejection screen route
  static const String requestRejection = 'requestRejectionScreen';
  
  // ============================================================
  // UTILITY ROUTES
  // ============================================================
  
  /// Search screen route
  static const String search = 'searchScreen';
  
  /// Notifications screen route
  static const String notifications = 'notificationsScreen';
  
  /// Settings screen route
  static const String settings = 'settingsScreen';
  
  /// Language selection screen route
  static const String language = 'languageScreen';
  
  /// Contact us screen route
  static const String contactUs = 'contactUsScreen';
  
  /// Web view screen route (for external content)
  static const String webView = 'webViewScreen';

  /// About app screen route
  static const String aboutApp = 'aboutAppScreen';

  /// Support screen route
  static const String support = 'supportScreen';
  
  // ============================================================
  // ERROR ROUTES
  // ============================================================
  
  /// No internet error screen route
  static const String noInternet = 'noInternetScreen';
  
  /// Error screen route
  static const String error = 'errorScreen';
}

