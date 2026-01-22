/*
 * Najaz Mobile App
 * Theme Provider
 * 
 * This file manages theme state for the app.
 * Currently only light theme is supported, but structure is prepared
 * for future dark theme implementation.
 * 
 * Follows Bagisto's theme provider pattern.
 */

import 'package:flutter/material.dart';

// TODO: Import SharedPreferenceHelper when it's created
// import 'package:najaz_app/utils/shared_preference_helper.dart';

/// Theme Provider for managing app theme state
/// 
/// Manages theme preference using ChangeNotifier pattern.
/// Currently only supports light theme, but structure allows for future dark theme.
class ThemeProvider extends ChangeNotifier {
  late String _isDark;
  // TODO: Uncomment when SharedPreferenceHelper is created
  // late final SharedPreferenceHelper appStoragePref;

  String get isDark => _isDark;

  /// Returns true if dark theme is selected (for future use)
  bool get isDarkMode => _isDark == "true";

  ThemeProvider() {
    // Currently default to light theme only
    _isDark = "false";
    // TODO: Uncomment when SharedPreferenceHelper is created
    // appStoragePref = SharedPreferenceHelper();
    // getPreferences();
  }

  /// Set theme mode
  /// Currently only "false" (light) is supported
  set isDark(String value) {
    _isDark = value;
    // TODO: Uncomment when SharedPreferenceHelper is created
    // appStoragePref.setTheme(value);
    notifyListeners();
  }

  /// Toggle theme (for future dark theme support)
  /// Currently no-op since only light theme is supported
  void toggleTheme() {
    // TODO: Implement when dark theme is added
    // _isDark = _isDark == "true" ? "false" : "true";
    // appStoragePref.setTheme(_isDark);
    // notifyListeners();
  }

  /// Getting the theme from shared preferences and setting the theme to the theme provider.
  /// If the theme is not set in the shared preferences, defaults to light theme.
  /// 
  /// Currently simplified since only light theme is supported.
  /// TODO: Uncomment and enhance when SharedPreferenceHelper is created and dark theme is added
  /*
  getPreferences() async {
    _isDark = appStoragePref.getTheme();
    notifyListeners();
    if (_isDark == "") {
      // Default to light theme if no preference is set
      // TODO: Optionally check system theme when dark theme is added:
      // if (MediaQueryData.fromView(
      //             WidgetsBinding.instance.platformDispatcher.views.single)
      //         .platformBrightness ==
      //     Brightness.dark) {
      //   _isDark = "true";
      //   appStoragePref.setTheme("true");
      // } else {
        _isDark = "false";
        appStoragePref.setTheme("false");
      // }
    } else {
      _isDark = appStoragePref.getTheme();
      notifyListeners();
    }
  }
  */
}

