/*
 * Najaz Mobile App
 * Log-In Repository
 * 
 * This file contains the repository for log-in API calls.
 * Follows Bagisto's SignInRepository pattern, tailored for Najaz.
 */

import 'package:flutter/foundation.dart';

import '../../../models/auth_models/log_in_model.dart';
import '../../../services/api_client.dart';
import '../../../services/graphql_mutations/log_in_mutation.dart';
import '../../../utils/validators/form_validator_helper.dart';

/// Repository interface for log-in operations
abstract class LogInRepository {
  /// Calls the log-in API
  ///
  /// [emailOrNationalId]: User's email or national ID
  /// [password]: User's password
  /// [remember]: Remember me flag
  Future<LogInModel> callLogInApi(
    String emailOrNationalId,
    String password,
    bool remember,
  );
}

/// Implementation of LogInRepository
class LogInRepositoryImp implements LogInRepository {
  @override
  Future<LogInModel> callLogInApi(
    String emailOrNationalId,
    String password,
    bool remember,
  ) async {
    try {
      // Detect input type (email or nationalId)
      final inputType = FormValidatorHelper.detectInputType(emailOrNationalId);

      if (inputType == null) {
        throw Exception('Invalid input: must be email or national ID');
      }

      // Construct mutation input based on detected type
      final Map<String, dynamic> input;
      if (inputType == 'email') {
        input = {
          'email': emailOrNationalId.trim(),
          'nationalId': '',
          'password': password,
          'remember': remember,
        };
      } else {
        // nationalId
        input = {
          'email': '',
          'nationalId': emailOrNationalId.trim(),
          'password': password,
          'remember': remember,
        };
      }

      // Call GraphQL mutation
      final logInModel = await ApiClient().mutate<LogInModel>(
        document: LogInMutation.citizenLogin,
        variables: {'input': input},
        operationName: 'citizenLogin',
        parser: (json) => LogInModel.fromJson(json),
      );

      return logInModel!;
    } catch (e, stackTrace) {
      debugPrint("Error in callLogInApi --> $e");
      debugPrint("StackTrace --> $stackTrace");
      rethrow;
    }
  }
}

