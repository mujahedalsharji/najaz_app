/*
 * Najaz Mobile App
 * GraphQL Client
 * 
 * This file contains GraphQL client configuration including
 * HTTP link, authentication link, and error handling.
 * Follows Bagisto's GraphQL client pattern, tailored for Najaz.
 */

import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';

import '../utils/constants/app_constants.dart';
import '../utils/constants/server_configuration.dart';
import '../utils/shared_preferences/shared_preference_helper.dart';

/// GraphQL Client Configuration
///
/// Provides GraphQL client instance with authentication and logging.
/// Tailored for Najaz service-based platform.
class GraphQLClientConfig {
  /// Logger link for logging GraphQL operations
  final loggerLink = LoggerLink();

  /// Auth link for injecting authentication token
  /// Following Bagisto pattern: token is stored as "${tokenType} ${token}" format
  /// So we use it directly without adding "Bearer" prefix
  final authLink = AuthLink(getToken: appStoragePref.getCitizenToken);

  /// Creates and returns a configured GraphQL client
  ///
  /// The client includes:
  /// - HTTP link with default headers (locale, cookie)
  /// - Authentication link for token injection
  /// - Logger link for request/response logging
  /// - HiveStore for persistent GraphQL cache (following Bagisto pattern)
  GraphQLClient getClient() {
    // Get current locale from shared preferences or use default
    final locale =
        appStoragePref.getCitizenLanguage().isNotEmpty
            ? appStoragePref.getCitizenLanguage()
            : AppConstants.defaultLanguageCode;

    // Get cookie from shared preferences
    final cookie = appStoragePref.getCookieGet();

    // Configure HTTP link with headers (following Bagisto pattern)
    final httpLink = HttpLink(
      baseUrl,
      defaultHeaders: {
        'Accept-Language': locale,
        'Content-Type': 'application/json',
        if (cookie.isNotEmpty) 'Cookie': cookie,
        if (cookie.isNotEmpty) 'is-cookie-exist': '1',
      },
    );

    log("GraphQL Client Configuration:");
    log("Base URL: $baseUrl");
    log("Locale: $locale");
    log(
      "Auth Token: ${appStoragePref.getCitizenToken().isNotEmpty ? 'Present' : 'Not set'}",
    );
    log("Cookie: ${cookie.isNotEmpty ? 'Present' : 'Not set'}");

    return GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      queryRequestTimeout: const Duration(seconds: 40),
      link: loggerLink.concat(authLink.concat(httpLink)),
    );
  }

  /// Creates a GraphQL client with custom headers
  ///
  /// Useful for requests that need additional headers.
  GraphQLClient getClientWithHeaders(Map<String, String> additionalHeaders) {
    final locale =
        appStoragePref.getCitizenLanguage().isNotEmpty
            ? appStoragePref.getCitizenLanguage()
            : AppConstants.defaultLanguageCode;

    final cookie = appStoragePref.getCookieGet();

    final headers = {
      'Accept-Language': locale,
      'Content-Type': 'application/json',
      if (cookie.isNotEmpty) 'Cookie': cookie,
      if (cookie.isNotEmpty) 'is-cookie-exist': '1',
      ...additionalHeaders,
    };

    final httpLink = HttpLink(baseUrl, defaultHeaders: headers);

    return GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      queryRequestTimeout: const Duration(seconds: 40),
      link: loggerLink.concat(authLink.concat(httpLink)),
    );
  }
}

/// Logger Link for logging GraphQL operations
///
/// Logs operation name and details for debugging.
class LoggerLink extends Link {
  @override
  Stream<Response> request(Request request, [NextLink? forward]) {
    log("\n=== GraphQL Request ===");
    log("Operation: ${request.operation.operationName ?? 'Anonymous'}");
    log("Document: ${request.operation.document}");
    log("Variables: ${request.variables}");
    log("=======================\n");

    return forward!(request).map((response) {
      log("\n=== GraphQL Response ===");
      log("Data: ${response.data}");
      log("Errors: ${response.errors}");
      log("========================\n");
      return response;
    });
  }
}

/// Singleton instance of GraphQL client configuration
final graphQLClientConfig = GraphQLClientConfig();
