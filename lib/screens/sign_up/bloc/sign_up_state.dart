/*
 * Najaz Mobile App
 * Sign-Up State
 * 
 * This file defines states for the Sign-Up BLoC.
 * Follows Bagisto's sign-up state pattern, tailored for Najaz.
 */

import '../../../models/auth_models/sign_up_model.dart';

/// Base state class for sign-up
abstract class SignUpBaseState {}

/// Enum for sign-up status
enum SignUpStatus { success, fail }

/// Initial sign-up state
class InitialSignUpState extends SignUpBaseState {
  InitialSignUpState();
}

/// Loading sign-up state
class SignUpLoadingState extends SignUpBaseState {
  SignUpLoadingState();
}

/// Fetch sign-up state (success or fail)
class FetchSignUpState extends SignUpBaseState {
  final SignUpStatus? status;
  final String? error;
  final String? successMsg;
  final SignUpModel? signUpModel;

  FetchSignUpState.success({this.signUpModel, this.successMsg})
    : status = SignUpStatus.success,
      error = null;

  FetchSignUpState.fail({this.error})
    : status = SignUpStatus.fail,
      successMsg = null,
      signUpModel = null;
}
