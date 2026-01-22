/*
 * Najaz Mobile App
 * Account Verification GraphQL Mutation
 * 
 * This file contains GraphQL mutation strings for account verification.
 */

/// GraphQL mutations for account verification
class AccountVerificationMutation {
  /// Request identity verification mutation with file uploads
  /// 
  /// Mutation parameters:
  /// - $frontDocument: Upload - Front ID card image file
  /// - $backDocument: Upload - Back ID card image file
  /// - $faceVideo: Upload - Face verification video file
  /// 
  /// Returns:
  /// - success: Boolean
  /// - message: String
  /// - verification: Verification object with id and face_video
  static const String requestIdentityVerification = '''
    mutation RequestIdentityVerification(
      \$frontDocument: Upload
      \$backDocument: Upload
      \$faceVideo: Upload
    ) {
      requestIdentityVerification(
        input: {
          front_document: \$frontDocument
          back_document: \$backDocument
          face_video: \$faceVideo
        }
      ) {
        success
        message
        verification {
          id
          face_video
        }
      }
    }
  ''';

  /// Update identity verification mutation with optional file uploads
  /// 
  /// Mutation parameters:
  /// - $id: ID! - Verification ID to update
  /// - $frontDocument: Upload - Front ID card image file (optional)
  /// - $backDocument: Upload - Back ID card image file (optional)
  /// - $faceVideo: Upload - Face verification video file (optional)
  /// 
  /// Returns:
  /// - success: Boolean
  /// - message: String
  /// - verification: Verification object with full details
  static const String updateMyIdentityVerification = '''
    mutation UpdateMyIdentityVerification(
      \$id: ID!
      \$frontDocument: Upload
      \$backDocument: Upload
      \$faceVideo: Upload
    ) {
      updateMyIdentityVerification(
        id: \$id
        input: {
          front_document: \$frontDocument
          back_document: \$backDocument
          face_video: \$faceVideo
        }
      ) {
        success
        message
        verification {
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
          citizen
        }
      }
    }
  ''';
}

