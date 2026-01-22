/*
 * Najaz Mobile App
 * Current Locale GraphQL Query
 * 
 * This file contains the GraphQL query for fetching the current locale.
 */

class CurrentLocaleQuery {
  static const String currentLocale = '''
    query currentLocale {
      currentLocale {
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

