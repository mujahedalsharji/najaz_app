/*
 * Najaz Mobile App
 * Sign-Up Repository
 * 
 * This file handles data operations for the Sign-Up screen.
 * Follows Bagisto's sign-up repository pattern, tailored for Najaz.
 */

import 'package:flutter/foundation.dart';

import '../../../models/auth_models/sign_up_model.dart';
import '../../../services/api_client.dart';
import '../../../services/graphql_mutations/sign_up_mutation.dart';

/// Repository interface for sign-up operations
abstract class SignUpRepository {
  Future<SignUpModel?> callSignUpApi({
    required String firstName,
    required String? middleName,
    required String lastName,
    required String gender,
    required String phone,
    required String nationalId,
    required String dateOfBirth,
    required int citizenTypeId,
    required String password,
    required String passwordConfirmation,
  });
}

/// Implementation of SignUpRepository
class SignUpRepositoryImp implements SignUpRepository {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<SignUpModel?> callSignUpApi({
    required String firstName,
    required String? middleName,
    required String lastName,
    required String gender,
    required String phone,
    required String nationalId,
    required String dateOfBirth,
    required int citizenTypeId,
    required String password,
    required String passwordConfirmation,
  }) async {
    SignUpModel? signUpResponseModel;

    try {
      // Prepare input variables for the mutation
      final input = {
        'firstName': firstName,
        //   if (middleName != null && middleName.isNotEmpty)
        'middleName': middleName,
        'lastName': lastName,
        'gender': gender.toUpperCase(), // Ensure uppercase (MALE/FEMALE)
        'phone': phone,
        'nationalId': nationalId,
        'dateOfBirth': dateOfBirth,
        // Note: citizenTypeId is not accepted by the backend schema
        'password': password,
        'passwordConfirmation': passwordConfirmation,
      };

      signUpResponseModel = await _apiClient.mutate<SignUpModel>(
        document: SignUpMutation.citizenSignUp,
        variables: {'input': input},
        operationName: 'citizenSignUp',
        parser: (json) => SignUpModel.fromJson(json),
      );
    } catch (error, stacktrace) {
      debugPrint("Error in SignUpRepository.callSignUpApi --> $error");
      debugPrint("StackTrace --> $stacktrace");
    }

    return signUpResponseModel;
  }
}
