/*
 * Najaz Mobile App
 * Log-In GraphQL Mutation
 * 
 * This file contains GraphQL mutation strings for citizen log-in.
 */

/// GraphQL mutation for citizen log-in
class LogInMutation {
  /// Citizen log-in mutation
  /// 
  /// Mutation fields:
  /// - email: Email address (optional, if nationalId is not provided)
  /// - nationalId: National ID (optional, if email is not provided)
  /// - password: Password
  /// - remember: Remember me flag
  static const String citizenLogin = '''
    mutation citizenLogin(\$input: CitizenLoginInput!) {
      citizenLogin(input: \$input) {
        success
        message
        accessToken
        tokenType
        citizen {
          id
          phone
          email
          nationalId
        }
      }
    }
  ''';
}

