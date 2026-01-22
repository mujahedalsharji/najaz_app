/*
 * Najaz Mobile App
 * Sign-Up GraphQL Mutation
 * 
 * This file contains GraphQL mutation strings for citizen sign-up.
 */

/// GraphQL mutation for citizen sign-up
class SignUpMutation {
  /// Citizen sign-up mutation
  /// 
  /// Mutation fields:
  /// - firstName: First name
  /// - middleName: Middle name
  /// - lastName: Last name
  /// - gender: Gender (MALE/FEMALE)
  /// - phone: Phone number
  /// - nationalId: National ID
  /// - dateOfBirth: Date of birth (ISO format string)
  /// - citizenTypeId: Citizen type ID (integer)
  /// - password: Password
  /// - passwordConfirmation: Password confirmation
  static const String citizenSignUp = '''
    mutation citizenSignUp(\$input: CitizenSignUpInput!) {
      citizenSignUp(input: \$input) {
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

