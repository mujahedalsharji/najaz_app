/*
 * Najaz Mobile App
 * Welcome Screen Events
 * 
 * This file contains all events for the welcome screen BLoC.
 */

import 'package:equatable/equatable.dart';

/// Base class for all welcome screen events
abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();

  @override
  List<Object?> get props => [];
}

/// Event fired when welcome screen is initialized
class WelcomeInitialEvent extends WelcomeEvent {
  const WelcomeInitialEvent();
}

/// Event fired when Sign In button is pressed
class SignInButtonPressedEvent extends WelcomeEvent {
  const SignInButtonPressedEvent();
}

/// Event fired when Sign Up (Create Account) button is pressed
class SignUpButtonPressedEvent extends WelcomeEvent {
  const SignUpButtonPressedEvent();
}

