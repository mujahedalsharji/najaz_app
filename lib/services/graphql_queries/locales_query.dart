/*
 * Najaz Mobile App
 * Locales GraphQL Query
 * 
 * This file contains the GraphQL query for fetching available locales.
 * Similar to getLanguageCurrencyList in Bagisto.
 */

class LocalesQuery {
  /// GraphQL query to fetch available locales
  /// 
  /// Returns list of available locales with all fields
  static const String locales = '''
    query locales {
      locales {
        id
        code
        name
        direction
        logoUrl
        createdAt
        updatedAt
      }
    }
  ''';
}

