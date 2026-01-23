/*
 * Najaz Mobile App
 * My Profile GraphQL Query
 */

class MyProfileQuery {
  static const String myProfile = '''
    query myProfile {
      myProfile {
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
        citizenTypeName
        createdAt
        updatedAt
        identityVerification {
          id
          citizenId
          status
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
            citizenTypeName
          }
        }
      }
    }
  ''';
}

