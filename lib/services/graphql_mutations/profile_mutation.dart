/*
 * Najaz Mobile App
 * Profile GraphQL Mutation
 * 
 * This file contains GraphQL mutation strings for profile updates.
 */

/// GraphQL mutations for profile operations
class ProfileMutation {
  /// Update my profile mutation
  /// 
  /// Mutation parameters (all optional):
  /// - firstName: String - First name
  /// - middleName: String - Middle name
  /// - lastName: String - Last name
  /// - gender: String - Gender (MALE/FEMALE)
  /// - email: String - Email address
  /// - phone: String - Phone number
  /// - nationalId: String - National ID
  /// - dateOfBirth: String - Date of birth (ISO format)
  /// 
  /// Returns:
  /// - success: Boolean
  /// - message: String
  /// - citizen: Citizen object with updated data
  static const String updateMyProfile = '''
    mutation UpdateMyProfile(\$input: UpdateProfileInput!) {
      updateMyProfile(input: \$input) {
        success
        message
        citizen {
          id
          firstName
          middleName
          lastName
          gender
          email
          phone
          nationalId
          dateOfBirth
          status
          isVerified
          identityVerificationStatus
          citizenTypeId
          createdAt
          updatedAt
        }
      }
    }
  ''';
}

