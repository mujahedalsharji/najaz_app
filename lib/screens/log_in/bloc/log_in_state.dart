/*
 * Najaz Mobile App
 * Log-In State
 * 
 * This file contains BLoC states for the log-in screen.
 * Follows Bagisto's SignInState pattern, tailored for Najaz.
 */

import '../../../models/auth_models/log_in_model.dart';

/// Base state class for log-in BLoC
abstract class LogInBaseState {}

/// Log-in status enum
enum LogInStatus { success, fail }

/// Initial state
class InitialLogInState extends LogInBaseState {}

/// Loading state
class LogInLoadingState extends LogInBaseState {}

/// Fetch log-in state
class FetchLogInState extends LogInBaseState {
  /// Status of the operation
  final LogInStatus? status;

  /// Error message (if any)
  final String? error;

  /// Success message (if any)
  final String? successMsg;

  /// Log-in model response
  final LogInModel? logInModel;

  FetchLogInState.success({
    this.logInModel,
    this.successMsg,
  }) : status = LogInStatus.success,
       error = null;

  FetchLogInState.fail({
    this.error,
  }) : status = LogInStatus.fail,
       successMsg = null,
       logInModel = null;
}

