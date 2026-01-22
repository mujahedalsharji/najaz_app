/*
 * Najaz Mobile App
 * Internet Connection Checker
 * 
 * This file provides utility functions to check internet connectivity.
 * Follows Bagisto's internet connection checker pattern.
 */

import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Checks if the device has an active internet connection
/// 
/// Uses InternetConnectionChecker to verify connectivity.
/// 
/// Returns `true` if internet connection is available, `false` otherwise.
/// 
/// Example:
/// ```dart
/// bool isConnected = await checkInternetConnection();
/// if (isConnected) {
///   // Perform network operations
/// } else {
///   // Show offline message
/// }
/// ```
Future<bool> checkInternetConnection() async {
  bool result = await InternetConnectionChecker().hasConnection;
  return result;
}

/// Creates a singleton instance of InternetConnectionChecker
/// 
/// Can be reused for better performance instead of creating new instances.
/// 
/// Example:
/// ```dart
/// final checker = getInternetConnectionChecker();
/// bool isConnected = await checker.hasConnection;
/// ```
InternetConnectionChecker getInternetConnectionChecker() {
  return InternetConnectionChecker();
}

/// Checks internet connection with timeout
/// 
/// [timeout]: Maximum duration to wait for connection check
/// 
/// Returns `true` if connection is available within timeout, `false` otherwise.
/// 
/// Example:
/// ```dart
/// bool isConnected = await checkInternetConnectionWithTimeout(
///   Duration(seconds: 5),
/// );
/// ```
Future<bool> checkInternetConnectionWithTimeout(Duration timeout) async {
  try {
    return await InternetConnectionChecker()
        .hasConnection
        .timeout(timeout, onTimeout: () => false);
  } catch (e) {
    return false;
  }
}

