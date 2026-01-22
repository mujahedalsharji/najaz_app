/*
 * Najaz Mobile App
 * Main App Entry Point
 * 
 * This file contains the main app setup including MaterialApp configuration,
 * theme setup, localization, providers, and route configuration.
 * Follows Bagisto's main.dart pattern, tailored for Najaz service-based platform.
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'models/locale_models/locales_list_model.dart';
import 'services/locale_service.dart';
import 'utils/app_global_data.dart';
import 'utils/app_navigation.dart';
import 'utils/app_theme.dart';
import 'utils/application_localization.dart';
import 'utils/constants/app_constants.dart';
import 'utils/constants/server_configuration.dart';
import 'utils/shared_preferences/shared_preference_helper.dart';
import 'utils/theme_provider.dart';

/// Main entry point for the Najaz app
///
/// Initializes app-wide services and configuration:
/// - GetStorage for local storage
/// - WidgetsFlutterBinding for Flutter framework
/// - SystemChrome for orientation preferences
/// - GraphQL cache initialization
/// - GlobalData initialization from shared preferences
Future<void> main() async {
  // Initialize GetStorage for local storage
  await GetStorage.init("configurationStorage");

  // Initialize Flutter bindings
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations (portrait only for now)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize GraphQL cache
  await initHiveForFlutter();

  // Initialize global data from shared preferences
  _initializeGlobalData();

  // Run the app
  runApp(const RestartWidget(child: NajazApp()));
}

/// Initializes global data from shared preferences
///
/// Loads stored locale and other global settings.
/// Note: Locale will be updated from GraphQL query in NajazApp.initState
void _initializeGlobalData() {
  // Get locale from shared preferences or use default (will be updated from API)
  final storedLocale = appStoragePref.getCitizenLanguage();
  GlobalData.locale = storedLocale.isNotEmpty ? storedLocale : defaultStoreCode;

  // Get cookie from shared preferences if available
  final cookie = appStoragePref.getCookieGet();
  if (cookie.isNotEmpty) {
    GlobalData.cookie = cookie;
  }
}

/// Restart Widget
///
/// Allows restarting the entire app by changing the key.
/// Useful for language changes, theme changes, etc.
class RestartWidget extends StatefulWidget {
  const RestartWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  /// Restarts the app by changing the widget key
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key _key = UniqueKey();

  void restartApp() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: _key, child: widget.child);
  }
}

/// Najaz App Widget
///
/// Main app widget that configures MaterialApp with:
/// - Theme (light theme, with dark theme placeholder)
/// - Localization (Arabic and English)
/// - Route generation
/// - Initial route logic
/// - Providers (ThemeProvider)
class NajazApp extends StatefulWidget {
  const NajazApp({Key? key}) : super(key: key);

  @override
  State<NajazApp> createState() => _NajazAppState();
}

class _NajazAppState extends State<NajazApp> {
  Locale? _locale;
  final LocaleService _localeService = LocaleService();

  @override
  void initState() {
    super.initState();
    _initializeLocale();
    _loadDeviceInfo();
  }

  /// Initializes locale from shared preferences
  Future<void> _initializeLocale() async {
    // Initialize locale synchronously from SharedPreferences (like Bagisto)
    // This prevents language flickering on app start
    GlobalData.locale = appStoragePref.getCitizenLanguage();

    // Properly construct Locale from stored string
    final localeString = GlobalData.locale.isNotEmpty
        ? GlobalData.locale
        : defaultStoreCode;

    if (localeString.contains('_')) {
      final parts = localeString.split('_');
      _locale = Locale(parts[0], parts[1]);
    } else {
      _locale = Locale(localeString);
    }

    // Update GlobalData if it was empty
    if (GlobalData.locale.isEmpty) {
      GlobalData.locale = localeString;
    }

    // Fetch locale from API in background (optional, won't cause flickering)
    _syncLocaleFromAPI();
    _initializeLanguages();
  }

  /// Syncs locale from API in background without updating UI
  /// This ensures SharedPreferences stays in sync with server, but doesn't cause flickering
  Future<void> _syncLocaleFromAPI() async {
    try {
      final currentLocaleData = await _localeService.fetchCurrentLocale();

      if (currentLocaleData != null &&
          currentLocaleData.success == true &&
          currentLocaleData.status == true &&
          currentLocaleData.currentLocale != null) {
        final localeCode = currentLocaleData.currentLocale!.code;

        if (localeCode != null &&
            localeCode.isNotEmpty &&
            localeCode != GlobalData.locale) {
          // Only update if different from stored locale
          // Store the fetched locale in shared preferences for next app start
          appStoragePref.setCitizenLanguage(localeCode);
          GlobalData.locale = localeCode;

          // Don't update _locale or call setState() to prevent flickering
          // The locale will be applied on next app restart
        }
      }
    } catch (e) {
      debugPrint('Error syncing locale from API: $e');
    }
  }

  /// Initializes available languages from GraphQL query or fallback
  Future<void> _initializeLanguages() async {
    // Try to fetch available languages from API
    try {
      final localesListData = await _localeService.fetchAvailableLocales();

      if (localesListData != null &&
          localesListData.success == true &&
          localesListData.status == true &&
          localesListData.locales != null &&
          localesListData.locales!.isNotEmpty) {
        // Store in GlobalData
        GlobalData.languageData = localesListData;
        return;
      }
    } catch (e) {
      debugPrint('Error fetching available locales from API: $e');
    }

    // Fallback: Create LocalesListModel from supportedLocale
    final fallbackLocales = supportedLocale.map((locale) {
      String name;
      switch (locale.languageCode) {
        case 'ar':
          name = AppConstants.defaultLanguageName;
          break;
        case 'en':
          name = 'English';
          break;
        default:
          name = locale.languageCode;
      }

      return LocaleItemModel(
        id: locale.languageCode,
        code: locale.languageCode,
        name: name,
      );
    }).toList();

    GlobalData.languageData = LocalesListModel(
      locales: fallbackLocales,
      success: true,
      status: true,
    );
  }

  /// Loads device information (for future use)
  /// TODO: Implement when device_info_plus is added
  void _loadDeviceInfo() {
    // Future implementation for device info
    // Will set GlobalData.deviceName when device_info_plus is added
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: Consumer<ThemeProvider>(
          builder: (context, ThemeProvider themeNotifier, child) {
            return MaterialApp(
              // Theme Configuration
              theme: AppTheme.lightTheme,
              //   darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.light, // Currently only light theme
              // Localization Configuration
              locale: _locale,
              supportedLocales: supportedLocale,
              localizationsDelegates: const [
                ApplicationLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (locale, supportedLocales) {
                // Try to find exact match (same as Bagisto)
                for (var supportedLocaleLanguage in supportedLocales) {
                  if (supportedLocaleLanguage.languageCode ==
                          locale?.languageCode &&
                      supportedLocaleLanguage.countryCode ==
                          locale?.countryCode) {
                    return supportedLocaleLanguage;
                  }
                }
                // Default to first supported locale (Arabic)
                return supportedLocales.first;
              },

              // Route Configuration
              initialRoute: AppNavigation.getInitialRoute(),
              onGenerateRoute: _generateRoute,

              // App Configuration
              title: defaultAppTitle,
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }

  /// Generates routes for navigation
  ///
  /// Uses AppNavigation.generateRoutes() to get route builders.
  Route<dynamic>? _generateRoute(RouteSettings settings) {
    final routes = AppNavigation.generateRoutes();
    final builder = routes[settings.name];

    if (builder != null) {
      return MaterialPageRoute(builder: builder, settings: settings);
    }

    // Default route (404)
    return MaterialPageRoute(
      builder:
          (context) => Scaffold(
            appBar: AppBar(title: const Text('Page Not Found')),
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
    );
  }
}

/// HTTP Overrides for development
///
/// Allows self-signed certificates during development.
/// TODO: Remove or make conditional for production builds
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
