/*
 * Najaz Mobile App
 * Welcome Screen BLoC
 * 
 * This file contains the business logic for the welcome screen.
 */

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/shared_preferences/shared_preference_helper.dart';
import 'welcome_event.dart';
import 'welcome_state.dart';

/// Welcome Screen BLoC
/// 
/// Handles welcome screen business logic and state management.
class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(const WelcomeLoadedState()) {
    on<WelcomeInitialEvent>(_onWelcomeInitialEvent);
    on<SignInButtonPressedEvent>(_onSignInButtonPressedEvent);
    on<SignUpButtonPressedEvent>(_onSignUpButtonPressedEvent);
  }

  /// Handles welcome screen initialization
  void _onWelcomeInitialEvent(
    WelcomeInitialEvent event,
    Emitter<WelcomeState> emit,
  ) {
    emit(const WelcomeLoadedState());
  }

  /// Handles sign in button press
  void _onSignInButtonPressedEvent(
    SignInButtonPressedEvent event,
    Emitter<WelcomeState> emit,
  ) {
    if (state is WelcomeLoadedState) {
      // Mark onboarding as completed and first launch as false
      // This ensures user won't see welcome screen again on next app launch
      appStoragePref.setOnboardingCompleted(true);
      appStoragePref.setIsFirstLaunch(false);
      
      emit((state as WelcomeLoadedState).copyWith(
        shouldNavigateToSignIn: true,
      ));
      
      // Reset navigation flag after a short delay
      Future.delayed(const Duration(milliseconds: 100), () {
        if (state is WelcomeLoadedState) {
          emit((state as WelcomeLoadedState).copyWith(
            shouldNavigateToSignIn: false,
          ));
        }
      });
    }
  }

  /// Handles sign up button press
  void _onSignUpButtonPressedEvent(
    SignUpButtonPressedEvent event,
    Emitter<WelcomeState> emit,
  ) {
    if (state is WelcomeLoadedState) {
      // Mark onboarding as completed and first launch as false
      // This ensures user won't see welcome screen again on next app launch
      appStoragePref.setOnboardingCompleted(true);
      appStoragePref.setIsFirstLaunch(false);
      
      emit((state as WelcomeLoadedState).copyWith(
        shouldNavigateToSignUp: true,
      ));
      
      // Reset navigation flag after a short delay
      Future.delayed(const Duration(milliseconds: 100), () {
        if (state is WelcomeLoadedState) {
          emit((state as WelcomeLoadedState).copyWith(
            shouldNavigateToSignUp: false,
          ));
        }
      });
    }
  }
}

