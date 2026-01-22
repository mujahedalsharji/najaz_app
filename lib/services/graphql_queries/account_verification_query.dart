/*
 * Najaz Mobile App
 * Account Verification GraphQL Query
 * 
 * This file contains GraphQL query strings for account verification.
 */

/// GraphQL queries for account verification
class AccountVerificationQuery {
  /// Get my identity verifications query
  /// 
  /// Returns list of identity verification requests for the current citizen
  /// with full details including status, documents, and citizen information.
  static const String myIdentityVerifications = '''
    query MyIdentityVerifications {
      myIdentityVerifications {
        id
        citizenId
        status
        notes
        documents
        face_video
        reviewedBy
        reviewedAt
        createdAt
        updatedAt
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

