/*
 * Najaz Mobile App
 * Locale Service
 * 
 * This file contains the service for fetching current locale from GraphQL API.
 */

import 'package:flutter/foundation.dart';

import '../models/locale_models/current_locale_model.dart';
import '../models/locale_models/locales_list_model.dart';
import '../services/api_client.dart';
import '../services/graphql_queries/current_locale_query.dart';
import '../services/graphql_queries/locales_query.dart';

/// Service for locale operations
class LocaleService {
  final ApiClient _apiClient = ApiClient();

  /// Fetches the current locale from the backend
  ///
  /// Returns CurrentLocaleModel if successful, null otherwise
  Future<CurrentLocaleModel?> fetchCurrentLocale() async {
    CurrentLocaleModel? currentLocaleResponseModel;
    try {
      currentLocaleResponseModel = await _apiClient.query<CurrentLocaleModel>(
        document: CurrentLocaleQuery.currentLocale,
        variables: <String, dynamic>{},
        operationName: 'currentLocale',
        parser: (json) => CurrentLocaleModel.fromJson(json),
      );
    } catch (error, stacktrace) {
      debugPrint("Error in LocaleService.fetchCurrentLocale --> $error");
      debugPrint("StackTrace --> $stacktrace");
    }
    return currentLocaleResponseModel;
  }

  /// Fetches the list of available locales from the backend
  ///
  /// Returns LocalesListModel if successful, null otherwise
  Future<LocalesListModel?> fetchAvailableLocales() async {
    LocalesListModel? localesListResponseModel;
    try {
      localesListResponseModel = await _apiClient.query<LocalesListModel>(
        document: LocalesQuery.locales,
        variables: <String, dynamic>{},
        operationName: 'locales',
        parser: (json) {
          // ApiClient.handleResponse() extracts 'locales' from result.data
          // If result.data['locales'] is a List, ApiClient wraps it as {'data': [...]}
          // If result.data['locales'] is a Map, ApiClient uses it directly
          // We need to convert to {'locales': [...]} format
          if (json.containsKey('data') && json['data'] is List) {
            // ApiClient wrapped the list as {'data': [...]}
            return LocalesListModel.fromJson({'locales': json['data']});
          } else if (json.containsKey('locales')) {
            // Already has 'locales' key
            return LocalesListModel.fromJson(json);
          } else if (json is Map && json.isEmpty) {
            // Empty response
            return LocalesListModel.fromJson({'locales': []});
          }
          // Fallback: assume json is the locales list directly (shouldn't happen but safe)
          return LocalesListModel.fromJson(json);
        },
      );
    } catch (error, stacktrace) {
      debugPrint("Error in LocaleService.fetchAvailableLocales --> $error");
      debugPrint("StackTrace --> $stacktrace");
    }
    return localesListResponseModel;
  }
}

