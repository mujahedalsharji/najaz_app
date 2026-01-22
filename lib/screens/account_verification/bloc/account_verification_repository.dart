/*
 * Najaz Mobile App
 * Account Verification Repository
 * 
 * This file handles data operations for the Account Verification screen.
 * Follows Bagisto's repository pattern, tailored for Najaz.
 */

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../services/api_client.dart';
import '../../../utils/constants/server_configuration.dart';
import '../../../utils/shared_preferences/shared_preference_helper.dart';
import '../../../services/graphql_mutations/account_verification_mutation.dart';
import '../../../services/graphql_queries/account_verification_query.dart';
import '../../../services/graphql_mutations/profile_mutation.dart';

/// Repository interface for account verification operations
abstract class AccountVerificationRepository {
  /// Check existing identity verification status
  Future<Map<String, dynamic>?> checkVerificationStatus();

  /// Update citizen profile
  Future<Map<String, dynamic>?> updateProfile({
    String? firstName,
    String? middleName,
    String? lastName,
    String? dateOfBirth,
    String? nationalId,
    String? gender,
    String? phone,
  });

  /// Submit identity verification with file uploads
  Future<Map<String, dynamic>?> submitIdentityVerification({
    required File frontDocument,
    required File backDocument,
    File? faceVideo,
  });

  /// Update existing identity verification with optional file uploads
  Future<Map<String, dynamic>?> updateIdentityVerification({
    required String id,
    File? frontDocument,
    File? backDocument,
    File? faceVideo,
  });
}

/// Implementation of AccountVerificationRepository
class AccountVerificationRepositoryImp
    implements AccountVerificationRepository {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<Map<String, dynamic>?> updateProfile({
    String? firstName,
    String? middleName,
    String? lastName,
    String? dateOfBirth,
    String? nationalId,
    String? gender,
    String? phone,
  }) async {
    try {
      final input = <String, dynamic>{};
      if (firstName != null && firstName.isNotEmpty) {
        input['firstName'] = firstName;
      }
      if (middleName != null && middleName.isNotEmpty) {
        input['middleName'] = middleName;
      }
      if (lastName != null && lastName.isNotEmpty) input['lastName'] = lastName;
      if (dateOfBirth != null && dateOfBirth.isNotEmpty) {
        input['dateOfBirth'] = dateOfBirth;
      }
      if (nationalId != null && nationalId.isNotEmpty) {
        input['nationalId'] = nationalId;
      }
      if (gender != null && gender.isNotEmpty) {
        input['gender'] = gender.toUpperCase();
      }
      if (phone != null && phone.isNotEmpty) {
        input['phone'] = phone;
      }

      final response = await _apiClient.mutate<Map<String, dynamic>>(
        document: ProfileMutation.updateMyProfile,
        variables: {'input': input},
        operationName: 'UpdateMyProfile',
        parser: (json) => json,
      );

      debugPrint("updateProfile response: $response");

      if (response != null) {
        // Check for updateMyProfile in response
        if (response.containsKey('updateMyProfile')) {
          final data = response['updateMyProfile'];
          final success = data['success'] ?? false;
          final message = data['message'] ?? '';
          debugPrint("updateProfile success: $success, message: $message");

          // If success is true, ignore any error flags at outer level
          if (success) {
            return {
              'success': true,
              'message': message.isNotEmpty
                  ? message
                  : 'تم تحديث الملف الشخصي بنجاح',
              'citizen': data['citizen'],
            };
          } else {
            // Only return error if success is explicitly false
            return {
              'success': false,
              'message':
                  message.isNotEmpty ? message : 'فشل تحديث الملف الشخصي',
              'citizen': data['citizen'],
            };
          }
        }
        // Also check if response itself contains success field (alternative structure)
        else if (response.containsKey('success')) {
          final success = response['success'] ?? false;
          return {
            'success': success,
            'message': response['message'] ??
                (success ? 'تم التحديث بنجاح' : 'فشل التحديث'),
            'citizen': response['citizen'],
          };
        }
      }

      debugPrint("updateProfile: No valid response structure found");
      return {
        'success': false,
        'message': 'Invalid response format',
      };
    } catch (error, stacktrace) {
      debugPrint("Error in updateProfile --> $error");
      debugPrint("StackTrace --> $stacktrace");
      return {
        'success': false,
        'message': error.toString(),
      };
    }
  }

  @override
  Future<Map<String, dynamic>?> checkVerificationStatus() async {
    try {
      // Don't use operationName to avoid extraction issues
      // Let handleResponse return result.data directly
      final response = await _apiClient.query<Map<String, dynamic>>(
        document: AccountVerificationQuery.myIdentityVerifications,
        variables: {},
        operationName: null, // Don't use operation name, get data directly
        parser: (json) => json, // Return data as-is
      );

      if (response != null) {
        // Check for 'myIdentityVerifications' in response
        if (response.containsKey('myIdentityVerifications')) {
          final verifications = response['myIdentityVerifications'] as List?;
          if (verifications != null && verifications.isNotEmpty) {
            // Return the most recent verification (first in list)
            return {
              'hasVerification': true,
              'verification': verifications.first,
              'allVerifications': verifications,
            };
          }
        }
      }

      return {
        'hasVerification': false,
        'verification': null,
        'allVerifications': [],
      };
    } catch (error, stacktrace) {
      debugPrint("Error in checkVerificationStatus --> $error");
      debugPrint("StackTrace --> $stacktrace");
      return {
        'hasVerification': false,
        'error': error.toString(),
      };
    }
  }

  @override
  Future<Map<String, dynamic>?> submitIdentityVerification({
    required File frontDocument,
    required File backDocument,
    File? faceVideo,
  }) async {
    try {
      // Prepare multipart request
      final uri = Uri.parse(baseUrl);
      final request = http.MultipartRequest('POST', uri);

      // Add headers
      request.headers.addAll({
        "Cookie": appStoragePref.getCookieGet(),
        "x-locale": appStoragePref.getCitizenLanguage().isEmpty
            ? defaultStoreCode
            : appStoragePref.getCitizenLanguage(),
        'Authorization': appStoragePref.getCitizenToken(),
      });

      // Prepare GraphQL mutation
      final mutationString =
          AccountVerificationMutation.requestIdentityVerification;

      // Prepare variables map
      final variables = <String, dynamic>{};

      // Map files to variables
      final fileMap = <String, List<String>>{};
      int fileIndex = 0;

      // Front document
      fileMap["$fileIndex"] = ["variables.frontDocument"];
      variables['frontDocument'] = null; // Will be replaced by file
      fileIndex++;

      // Back document
      fileMap["$fileIndex"] = ["variables.backDocument"];
      variables['backDocument'] = null; // Will be replaced by file
      fileIndex++;

      // Face video (optional)
      if (faceVideo != null) {
        fileMap["$fileIndex"] = ["variables.faceVideo"];
        variables['faceVideo'] = null; // Will be replaced by file
        fileIndex++;
      }

      // Prepare operations JSON
      final operations = json.encode({
        "query": mutationString,
        "variables": variables,
      });

      request.fields['operations'] = operations;
      request.fields['map'] = json.encode(fileMap);

      // Attach files
      // Front document
      final frontMultipartFile = await http.MultipartFile.fromPath(
        "0",
        frontDocument.path,
        filename: frontDocument.path.split('/').last,
      );
      request.files.add(frontMultipartFile);

      // Back document
      final backMultipartFile = await http.MultipartFile.fromPath(
        "1",
        backDocument.path,
        filename: backDocument.path.split('/').last,
      );
      request.files.add(backMultipartFile);

      // Face video (optional)
      if (faceVideo != null) {
        final videoMultipartFile = await http.MultipartFile.fromPath(
          "2",
          faceVideo.path,
          filename: faceVideo.path.split('/').last,
        );
        request.files.add(videoMultipartFile);
      }

      // Send request
      final response = await request.send();
      final responseString = await response.stream.bytesToString();
      final Map<String, dynamic> jsonResponse = json.decode(responseString);

      debugPrint("Identity verification response: $jsonResponse");

      // Extract data from response
      if (jsonResponse.containsKey('data')) {
        final data = jsonResponse['data']?['requestIdentityVerification'];
        if (data != null) {
          return {
            'success': data['success'] ?? false,
            'message': data['message'] ?? '',
            'verification': data['verification'],
          };
        }
      }

      // Handle errors
      if (jsonResponse.containsKey('errors')) {
        final errors = jsonResponse['errors'] as List;
        if (errors.isNotEmpty) {
          final errorMessage = errors.first['message'] ?? 'Unknown error';
          debugPrint("GraphQL error: $errorMessage");
          return {
            'success': false,
            'message': errorMessage,
          };
        }
      }

      return {
        'success': false,
        'message': 'Failed to submit verification',
      };
    } catch (error, stacktrace) {
      debugPrint("Error in submitIdentityVerification --> $error");
      debugPrint("StackTrace --> $stacktrace");
      return {
        'success': false,
        'message': error.toString(),
      };
    }
  }

  @override
  Future<Map<String, dynamic>?> updateIdentityVerification({
    required String id,
    File? frontDocument,
    File? backDocument,
    File? faceVideo,
  }) async {
    try {
      // At least one file must be provided
      if (frontDocument == null && backDocument == null && faceVideo == null) {
        return {
          'success': false,
          'message': 'At least one file must be provided for update',
        };
      }

      // Prepare multipart request
      final uri = Uri.parse(baseUrl);
      final request = http.MultipartRequest('POST', uri);

      // Add headers
      request.headers.addAll({
        "Cookie": appStoragePref.getCookieGet(),
        "x-locale": appStoragePref.getCitizenLanguage().isEmpty
            ? defaultStoreCode
            : appStoragePref.getCitizenLanguage(),
        'Authorization': appStoragePref.getCitizenToken(),
      });

      // Prepare GraphQL mutation
      final mutationString =
          AccountVerificationMutation.updateMyIdentityVerification;

      // Prepare variables map
      final variables = <String, dynamic>{
        'id': id,
      };

      // Map files to variables
      final fileMap = <String, List<String>>{};
      int fileIndex = 0;

      // Front document (optional)
      if (frontDocument != null) {
        fileMap["$fileIndex"] = ["variables.frontDocument"];
        variables['frontDocument'] = null; // Will be replaced by file
        fileIndex++;
      }

      // Back document (optional)
      if (backDocument != null) {
        fileMap["$fileIndex"] = ["variables.backDocument"];
        variables['backDocument'] = null; // Will be replaced by file
        fileIndex++;
      }

      // Face video (optional)
      if (faceVideo != null) {
        fileMap["$fileIndex"] = ["variables.faceVideo"];
        variables['faceVideo'] = null; // Will be replaced by file
        fileIndex++;
      }

      // Prepare operations JSON
      final operations = json.encode({
        "query": mutationString,
        "variables": variables,
      });

      request.fields['operations'] = operations;
      request.fields['map'] = json.encode(fileMap);

      // Attach files
      int fileCounter = 0;

      if (frontDocument != null) {
        final frontMultipartFile = await http.MultipartFile.fromPath(
          "$fileCounter",
          frontDocument.path,
          filename: frontDocument.path.split('/').last,
        );
        request.files.add(frontMultipartFile);
        fileCounter++;
      }

      if (backDocument != null) {
        final backMultipartFile = await http.MultipartFile.fromPath(
          "$fileCounter",
          backDocument.path,
          filename: backDocument.path.split('/').last,
        );
        request.files.add(backMultipartFile);
        fileCounter++;
      }

      if (faceVideo != null) {
        final videoMultipartFile = await http.MultipartFile.fromPath(
          "$fileCounter",
          faceVideo.path,
          filename: faceVideo.path.split('/').last,
        );
        request.files.add(videoMultipartFile);
      }

      // Send request
      final response = await request.send();
      final responseString = await response.stream.bytesToString();
      final Map<String, dynamic> jsonResponse = json.decode(responseString);

      debugPrint("Update identity verification response: $jsonResponse");

      // Extract data from response
      if (jsonResponse.containsKey('data')) {
        final data = jsonResponse['data']?['updateMyIdentityVerification'];
        if (data != null) {
          return {
            'success': data['success'] ?? false,
            'message': data['message'] ?? '',
            'verification': data['verification'],
          };
        }
      }

      // Handle errors
      if (jsonResponse.containsKey('errors')) {
        final errors = jsonResponse['errors'] as List;
        if (errors.isNotEmpty) {
          final errorMessage = errors.first['message'] ?? 'Unknown error';
          debugPrint("GraphQL error: $errorMessage");
          return {
            'success': false,
            'message': errorMessage,
          };
        }
      }

      return {
        'success': false,
        'message': 'Failed to update verification',
      };
    } catch (error, stacktrace) {
      debugPrint("Error in updateIdentityVerification --> $error");
      debugPrint("StackTrace --> $stacktrace");
      return {
        'success': false,
        'message': error.toString(),
      };
    }
  }
}

