/*
 * Najaz Mobile App
 * API Client
 * 
 * This file provides a generic API client wrapper for executing
 * GraphQL queries and mutations with standardized error handling.
 * Follows Bagisto's API client pattern, tailored for Najaz.
 */

import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/base_models/graphql_base_error_model.dart';
import '../utils/app_global_data.dart';
import '../utils/shared_preferences/shared_preference_helper.dart';
import 'graphql_client.dart';

/// Type alias for JSON parser functions
typedef Parser<T> = T Function(Map<String, dynamic> json);

/// API Client for GraphQL operations
/// 
/// Provides methods for executing queries and mutations with
/// standardized response handling and error parsing.
class ApiClient {
  /// GraphQL client instance
  final GraphQLClient _client = graphQLClientConfig.getClient();

  /// Executes a GraphQL query
  /// 
  /// Parameters:
  /// - [document]: GraphQL query document string
  /// - [variables]: Query variables map
  /// - [operationName]: Name of the operation (for logging)
  /// - [parser]: Function to parse the response JSON to model
  /// - [fetchPolicy]: Cache policy (default: networkOnly)
  /// 
  /// Returns parsed model of type T, or null on error.
  Future<T?> query<T>({
    required String document,
    Map<String, dynamic>? variables,
    String? operationName,
    required Parser<T> parser,
    FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
  }) async {
    try {
      final result = await _client.query(
        QueryOptions(
          document: gql(document),
          variables: variables ?? {},
          operationName: operationName,
          fetchPolicy: fetchPolicy,
        ),
      );

      return handleResponse<T>(result, operationName, parser);
    } catch (e) {
      log("Error executing GraphQL query: $e");
      return null;
    }
  }

  /// Executes a GraphQL mutation
  /// 
  /// Parameters:
  /// - [document]: GraphQL mutation document string
  /// - [variables]: Mutation variables map
  /// - [operationName]: Name of the operation (for logging)
  /// - [parser]: Function to parse the response JSON to model
  /// - [fetchPolicy]: Cache policy (default: networkOnly)
  /// 
  /// Returns parsed model of type T, or null on error.
  Future<T?> mutate<T>({
    required String document,
    Map<String, dynamic>? variables,
    String? operationName,
    required Parser<T> parser,
    FetchPolicy fetchPolicy = FetchPolicy.networkOnly,
  }) async {
    try {
      final result = await _client.mutate(
        MutationOptions(
          document: gql(document),
          variables: variables ?? {},
          operationName: operationName,
          fetchPolicy: fetchPolicy,
        ),
      );

      return handleResponse<T>(result, operationName, parser);
    } catch (e) {
      log("Error executing GraphQL mutation: $e");
      return null;
    }
  }

  /// Handles GraphQL response and converts it to model
  /// 
  /// Extracts data from response, handles errors, and parses JSON to model.
  /// Also manages cookies from response headers.
  Future<T?> handleResponse<T>(
    QueryResult<Object?> result,
    String? operationName,
    Parser<T> parser,
  ) async {
    // Extract and save cookie from response headers
    final responseCookie = result.context
            .entry<HttpLinkResponseContext>()
            ?.headers?['set-cookie'] ??
        "";

    // Update GlobalData.cookie (following Bagisto pattern)
    GlobalData.cookie = appStoragePref.getCookieGet();

    if (responseCookie.isNotEmpty) {
      appStoragePref.setCookieGet(responseCookie);
      GlobalData.cookie = responseCookie; // Update GlobalData after saving
      log("Cookie saved from response: $responseCookie");
    }

    log("\nEXCEPTION -> ${result.exception}\n\n");
    log("\nHasException -> ${result.hasException}\n\n");
    
    // Handle errors (following Bagisto pattern)
    if (result.hasException && (result.data?[operationName]) == null) {
      log("\nGraphQL Exception:");
      log("Exception: ${result.exception}");
      
      String? errorMessage;
      if (result.exception!.graphqlErrors.isNotEmpty) {
        log("GraphQL Errors: ${result.exception!.graphqlErrors}");
        errorMessage = result.exception!.graphqlErrors.first.message;
      } else {
        errorMessage = "Some this went wrong connecting to server!";
      }
      
      // Return error model
      return parser({
        'status': false,
        'graphqlErrors': errorMessage,
        'message': errorMessage,
      }) as T?;
    }

    // Extract data from result
    Map<String, dynamic>? data = {};
    
    // If operation name is provided, extract data for that operation
    if (operationName != null && result.data != null) {
      if (result.data![operationName] != null) {
        if (result.data![operationName] is List) {
          data = {'data': result.data![operationName]};
        } else if (result.data![operationName] is Map) {
          data = result.data![operationName] as Map<String, dynamic>?;
        }
      }
    } else if (result.data != null) {
      // If no operation name, use the whole data
      data = result.data!;
    }

    // Add status and success flags if not present
    data?.putIfAbsent('status', () => true);
    data?.putIfAbsent('success', () => true);
    data?.putIfAbsent('responseStatus', () => true);

    log("\nParsed Data before model conversion: $data");

    try {
      return parser(data ?? {});
    } catch (e) {
      log("Error parsing response to model: $e");
      return null;
    }
  }

  /// Checks if error is a network error
  static bool isNetworkError(GraphQLBaseErrorModel? error) {
    if (error == null || error.graphqlErrors == null) return false;
    final errorMessage = error.graphqlErrors!.toLowerCase();
    return errorMessage.contains('network') || errorMessage.contains('connection');
  }

  /// Checks if error is an authentication error
  static bool isAuthenticationError(GraphQLBaseErrorModel? error) {
    if (error == null) return false;
    final errorMessage = error.graphqlErrors?.toLowerCase() ?? '';
    return errorMessage.contains('unauthorized') ||
           errorMessage.contains('authentication') ||
           errorMessage.contains('token') ||
           errorMessage.contains('login');
  }

  /// Extracts error message from error model
  static String getErrorMessage(GraphQLBaseErrorModel? error) {
    if (error == null) return 'An unknown error occurred';
    return error.graphqlErrors ?? error.message ?? 'An error occurred';
  }
}

/// Singleton instance of API client
final apiClient = ApiClient();

