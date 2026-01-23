/*
 * Najaz Mobile App
 * App Navigation
 * 
 * This file contains navigation setup including route generation
 * and initial route logic based on authentication and onboarding state.
 */

import 'package:flutter/material.dart';

import '../screens/account_verification/view/account_verification_screen.dart';
import '../screens/language/view/language_screen.dart';
import '../screens/main_tabs/main_tabs_screen.dart';
import '../screens/profile/view/account_info_screen.dart';
import '../screens/privacy_policy/view/privacy_policy_screen.dart';
import '../screens/service_description/view/service_description_screen.dart';
import '../screens/log_in/view/log_in_screen.dart';
import '../screens/notifications/view/notifications_screen.dart';
import '../screens/sign_up/view/sign_up_screen.dart';
import '../screens/welcome/view/welcome_screen.dart';
import 'constants/route_constants.dart';
import 'shared_preferences/shared_preference_helper.dart';

/// App Navigation - Route generation and navigation utilities
///
/// Provides:
/// - Route generation for MaterialApp
/// - Initial route determination based on app state
/// - Navigation helper methods
class AppNavigation {
  /// Shared preference helper instance
  static final SharedPreferenceHelper _prefs = appStoragePref;

  /// Generates routes for MaterialApp
  ///
  /// Returns a map of route names to route builders.
  /// Routes will be created as screens are implemented.
  static Map<String, WidgetBuilder> generateRoutes() {
    return {
      // ============================================================
      // AUTHENTICATION ROUTES
      // ============================================================
      RouteConstants.welcome: (context) => WelcomeScreen.builder(context),
      RouteConstants.signIn: (context) => LogInScreen.builder(context),
      RouteConstants.signUp: (context) => SignUpScreen.builder(context),
      RouteConstants.forgotPassword:
          (context) => _buildPlaceholderScreen(
            context,
            'Forgot Password Screen',
            RouteConstants.forgotPassword,
          ),
      RouteConstants.resetPassword:
          (context) => _buildPlaceholderScreen(
            context,
            'Reset Password Screen',
            RouteConstants.resetPassword,
          ),
      RouteConstants.accountVerification:
          (context) => AccountVerificationScreen.builder(context),

      // ============================================================
      // MAIN APP ROUTES
      // ============================================================
      RouteConstants.home:
          (context) => MainTabsScreen.builder(context, initialIndex: 0),
      RouteConstants.services:
          (context) => MainTabsScreen.builder(context, initialIndex: 1),
      RouteConstants.serviceDetails: (context) {
        final args =
            ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
        return ServiceDescriptionScreen.builder(
          context,
          serviceId: args?['serviceId']?.toString(),
          serviceName: args?['serviceName']?.toString(),
          serviceDescription: args?['serviceDescription']?.toString(),
          serviceImage: args?['serviceImage']?.toString(),
        );
      },
      RouteConstants.history:
          (context) => MainTabsScreen.builder(context, initialIndex: 2),
      RouteConstants.profile:
          (context) => MainTabsScreen.builder(context, initialIndex: 3),

      // ============================================================
      // PROFILE & ACCOUNT ROUTES
      // ============================================================
      RouteConstants.accountInfo:
          (context) => AccountInfoScreen.builder(context, null),
      RouteConstants.editProfile:
          (context) => _buildPlaceholderScreen(
            context,
            'Edit Profile Screen',
            RouteConstants.editProfile,
          ),
      RouteConstants.changePassword:
          (context) => _buildPlaceholderScreen(
            context,
            'Change Password Screen',
            RouteConstants.changePassword,
          ),
      RouteConstants.privacyPolicy: (context) {
        final args =
            ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
        return PrivacyPolicyScreen.builder(context, signUpData: args);
      },
      RouteConstants.termsAndConditions:
          (context) => _buildPlaceholderScreen(
            context,
            'Terms and Conditions Screen',
            RouteConstants.termsAndConditions,
          ),

      // ============================================================
      // SERVICE & BOOKING ROUTES
      // ============================================================
      RouteConstants.bookingDetails:
          (context) => _buildPlaceholderScreen(
            context,
            'Booking Details Screen',
            RouteConstants.bookingDetails,
          ),
      RouteConstants.createBooking:
          (context) => _buildPlaceholderScreen(
            context,
            'Create Booking Screen',
            RouteConstants.createBooking,
          ),
      RouteConstants.bookingConfirmation:
          (context) => _buildPlaceholderScreen(
            context,
            'Booking Confirmation Screen',
            RouteConstants.bookingConfirmation,
          ),
      RouteConstants.requestDetails:
          (context) => _buildPlaceholderScreen(
            context,
            'Request Details Screen',
            RouteConstants.requestDetails,
          ),
      RouteConstants.requestDocument:
          (context) => _buildPlaceholderScreen(
            context,
            'Request Document Screen',
            RouteConstants.requestDocument,
          ),
      RouteConstants.requestEdit:
          (context) => _buildPlaceholderScreen(
            context,
            'Request Edit Screen',
            RouteConstants.requestEdit,
          ),
      RouteConstants.requestRejection:
          (context) => _buildPlaceholderScreen(
            context,
            'Request Rejection Screen',
            RouteConstants.requestRejection,
          ),

      // ============================================================
      // UTILITY ROUTES
      // ============================================================
      RouteConstants.search:
          (context) => _buildPlaceholderScreen(
            context,
            'Search Screen',
            RouteConstants.search,
          ),
      RouteConstants.notifications:
          (context) => NotificationsScreen.builder(context),
      RouteConstants.settings:
          (context) => _buildPlaceholderScreen(
            context,
            'Settings Screen',
            RouteConstants.settings,
          ),
      RouteConstants.language:
          (context) => LanguageScreen.builder(context, null),
      RouteConstants.contactUs:
          (context) => _buildPlaceholderScreen(
            context,
            'Contact Us Screen',
            RouteConstants.contactUs,
          ),
      RouteConstants.aboutApp:
          (context) => _buildPlaceholderScreen(
            context,
            'About App Screen',
            RouteConstants.aboutApp,
          ),
      RouteConstants.support:
          (context) => _buildPlaceholderScreen(
            context,
            'Support Screen',
            RouteConstants.support,
          ),
      RouteConstants.webView:
          (context) => _buildPlaceholderScreen(
            context,
            'Web View Screen',
            RouteConstants.webView,
          ),

      // ============================================================
      // ERROR ROUTES
      // ============================================================
      RouteConstants.noInternet:
          (context) => _buildPlaceholderScreen(
            context,
            'No Internet Screen',
            RouteConstants.noInternet,
          ),
      RouteConstants.error:
          (context) => _buildPlaceholderScreen(
            context,
            'Error Screen',
            RouteConstants.error,
          ),
    };
  }

  /// Determines the initial route based on app state
  ///
  /// Logic:
  /// 1. If first launch → Welcome screen
  /// 2. If not onboarded → Welcome screen
  /// 3. If not logged in → Sign in screen
  /// 4. If logged in → Home screen
  ///
  /// Note: Splash screen is handled by flutter_native_splash package.
  ///
  /// Returns the route name string.
  static String getInitialRoute() {
    // Check if it's the first launch
    if (_prefs.getIsFirstLaunch()) {
      return RouteConstants.welcome;
    }

    // Check if onboarding is completed
    if (!_prefs.getOnboardingCompleted()) {
      return RouteConstants.welcome;
    }

    // Check if user is logged in
    if (!_prefs.getCitizenLoggedIn()) {
      return RouteConstants.signIn;
    }

    // User is logged in, go to home
    return RouteConstants.home;
  }

  /// Builds a placeholder screen for routes that haven't been implemented yet
  ///
  /// This is temporary and will be replaced with actual screen implementations.
  static Widget _buildPlaceholderScreen(
    BuildContext context,
    String screenName,
    String routeName,
  ) {
    return Scaffold(
      appBar: AppBar(title: Text(screenName)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              screenName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Route: $routeName',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const Text(
              'This screen will be implemented soon.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  /// Navigates to a route by name
  ///
  /// Example:
  /// ```dart
  /// AppNavigation.navigateTo(context, RouteConstants.home);
  /// ```
  static void navigateTo(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  /// Navigates to a route and replaces the current route
  ///
  /// Example:
  /// ```dart
  /// AppNavigation.navigateToReplacement(context, RouteConstants.home);
  /// ```
  static void navigateToReplacement(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  /// Navigates to a route and removes all previous routes
  ///
  /// Useful for logout or resetting navigation stack.
  /// Example:
  /// ```dart
  /// AppNavigation.navigateAndRemoveUntil(context, RouteConstants.signIn);
  /// ```
  static void navigateAndRemoveUntil(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }

  /// Pops the current route
  ///
  /// Returns true if a route was popped, false otherwise.
  static bool pop(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      return true;
    }
    return false;
  }

  /// Pops the current route with a result
  ///
  /// Example:
  /// ```dart
  /// AppNavigation.popWithResult(context, {'result': 'success'});
  /// ```
  static void popWithResult(BuildContext context, dynamic result) {
    Navigator.pop(context, result);
  }

  /// Navigates to a route with arguments
  ///
  /// Example:
  /// ```dart
  /// AppNavigation.navigateToWithArgs(
  ///   context,
  ///   RouteConstants.serviceDetails,
  ///   arguments: {'serviceId': '123'},
  /// );
  /// ```
  static void navigateToWithArgs(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }
}
