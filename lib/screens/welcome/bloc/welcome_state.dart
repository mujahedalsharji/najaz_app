/*
 * Najaz Mobile App
 * Welcome Screen States
 * 
 * This file contains all states for the welcome screen BLoC.
 */

import 'package:equatable/equatable.dart';

/// Base class for all welcome screen states
abstract class WelcomeState extends Equatable {
  const WelcomeState();

  @override
  List<Object?> get props => [];
}

/// Initial state of welcome screen
class WelcomeInitialState extends WelcomeState {
  const WelcomeInitialState();
}

/// Default state with navigation flags
class WelcomeLoadedState extends WelcomeState {
  /// Flag to navigate to sign in screen
  final bool shouldNavigateToSignIn;

  /// Flag to navigate to sign up screen
  final bool shouldNavigateToSignUp;

  const WelcomeLoadedState({
    this.shouldNavigateToSignIn = false,
    this.shouldNavigateToSignUp = false,
  });

  /// Creates a copy of this state with updated values
  WelcomeLoadedState copyWith({
    bool? shouldNavigateToSignIn,
    bool? shouldNavigateToSignUp,
  }) {
    return WelcomeLoadedState(
      shouldNavigateToSignIn: shouldNavigateToSignIn ?? this.shouldNavigateToSignIn,
      shouldNavigateToSignUp: shouldNavigateToSignUp ?? this.shouldNavigateToSignUp,
    );
  }

  @override
  List<Object?> get props => [shouldNavigateToSignIn, shouldNavigateToSignUp];
}

