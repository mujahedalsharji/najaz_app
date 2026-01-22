/*
 * Najaz Mobile App
 * Application Localization
 * 
 * This file handles app localization and provides methods for
 * translating strings based on the selected language.
 * Follows Bagisto's application_localization pattern, tailored for Najaz.
 */

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/server_configuration.dart';
import 'shared_preferences/shared_preference_helper.dart';

/// Application Localizations
///
/// Manages localization for the app, loading language files
/// and providing translation methods.
class ApplicationLocalizations {
  static ApplicationLocalizations? instance;

  ApplicationLocalizations._init(Locale locale) {
    instance = this;
    appLocale = locale;
  }

  Locale? appLocale;

  ApplicationLocalizations({this.appLocale});

  /// Gets the ApplicationLocalizations instance from context
  ///
  /// [context]: BuildContext to retrieve localization instance
  ///
  /// Returns ApplicationLocalizations instance or null if not available
  static ApplicationLocalizations? of(BuildContext? context) {
    return Localizations.of<ApplicationLocalizations>(
      context!,
      ApplicationLocalizations,
    );
  }

  /// Localizations delegate for MaterialApp
  static const LocalizationsDelegate<ApplicationLocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, String>? _localizedStrings;

  /// Loads localization strings from JSON file
  ///
  /// Determines the correct language file based on stored preferences
  /// and loads it from assets/language/ directory.
  ///
  /// Returns true if loading was successful, false otherwise
  Future<bool> load() async {
    // Get selected language from shared preferences
    var selectedCode = appStoragePref.getCitizenLanguage();
    
    // If no stored locale, use default
    if (selectedCode.isEmpty) {
      selectedCode = defaultStoreCode;
    }

    // Find matching locale from supported locales
    Locale selectedLocale = supportedLocale.firstWhere(
      (locale) =>
          locale.toString() == selectedCode ||
          locale.languageCode == selectedCode ||
          '${locale.languageCode}_${locale.countryCode}' == selectedCode,
      orElse:
          () =>
              supportedLocale
                  .first, // Default to first supported locale (Arabic)
    );

    // Construct locale file name
    // Format: "ar.json" or "en.json" (or "ar_SA.json" if country code is present)
    String localeFile =
        selectedLocale.countryCode != null &&
                selectedLocale.countryCode!.isNotEmpty
            ? '${selectedLocale.languageCode}_${selectedLocale.countryCode}'
            : selectedLocale.languageCode;

    try {
      // Load language file from assets
      String jsonString = await rootBundle.loadString(
        'assets/language/$localeFile.json',
      );
      Map<String, dynamic> jsonLanguageMap = json.decode(jsonString);

      // Convert to Map<String, String>
      _localizedStrings = jsonLanguageMap.map((key, value) {
        return MapEntry(key, value.toString());
      });

      return true;
    } catch (e) {
      // If language file doesn't exist, try to load default (Arabic)
      try {
        String jsonString = await rootBundle.loadString(
          'assets/language/ar.json',
        );
        Map<String, dynamic> jsonLanguageMap = json.decode(jsonString);
        _localizedStrings = jsonLanguageMap.map((key, value) {
          return MapEntry(key, value.toString());
        });
        return true;
      } catch (e2) {
        // If even default fails, return false
        debugPrint('Error loading localization: $e2');
        return false;
      }
    }
  }

  /// Translates a string key to localized text
  ///
  /// [jsonkey]: The key from StringConstants to translate
  ///
  /// Returns the translated string, or the key itself if translation not found
  ///
  /// Example:
  /// ```dart
  /// ApplicationLocalizations.instance?.translate(StringConstants.welcome)
  /// ```
  String translate(String jsonkey) {
    return _localizedStrings?[jsonkey] ?? jsonkey;
  }
}

/// Localizations Delegate
///
/// Handles loading of localization data for Flutter's localization system.
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<ApplicationLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Check if locale is in supported locales list
    return supportedLocale.any(
      (supported) =>
          supported.languageCode == locale.languageCode &&
          (supported.countryCode == null ||
              supported.countryCode == locale.countryCode),
    );
  }

  @override
  Future<ApplicationLocalizations> load(Locale locale) async {
    // Initialize and load localization data
    ApplicationLocalizations localizations = ApplicationLocalizations._init(
      locale,
    );
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

/// Extension on String for easy localization
///
/// Provides `.localized()` method to translate strings directly.
///
/// Example:
/// ```dart
/// StringConstants.welcome.localized() // Returns translated "welcome" string
/// ```
extension StringExtend on String {
  /// Returns the localized version of this string key
  ///
  /// If localization is not available, returns the key itself.
  String localized() {
    return ApplicationLocalizations.instance?.translate(this) ?? this;
  }
}
