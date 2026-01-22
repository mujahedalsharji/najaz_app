/*
 * Najaz Mobile App
 * Log-In Event
 * 
 * This file contains BLoC events for the log-in screen.
 * Follows Bagisto's SignInEvent pattern, tailored for Najaz.
 */

/// Base event class for log-in BLoC
abstract class LogInBaseEvent {}

/// Event to fetch log-in data
class FetchLogInEvent extends LogInBaseEvent {
  /// Email or National ID (user can login with either)
  final String? emailOrNationalId;

  /// Password
  final String? password;

  /// Remember me flag
  final bool remember;

  FetchLogInEvent({
    this.emailOrNationalId,
    this.password,
    required this.remember,
  });
}

