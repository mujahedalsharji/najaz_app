/*
 * Najaz Mobile App
 * Welcome Screen View
 *
 * This file contains the welcome/onboarding screen UI with BLoC pattern.
 * Uses Column layout instead of Stack.
 * Following the design mockup.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najaz_app/screens/welcome/utils/welcome_screen__top_section.dart';

import '../../../utils/constants/route_constants.dart';
import '../bloc/welcome_bloc.dart';
import '../bloc/welcome_event.dart';
import '../bloc/welcome_state.dart';
import '../utils/welcome_screen__buttons_section.dart';
import '../utils/welcome_screen__description_section.dart';

/// Welcome/Onboarding Screen
///
/// Displays welcome screen with:
/// - Logo and app name in top section (beige background)
/// - Welcome text in middle section
/// - Action buttons in bottom section
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  /// Builder method for BLoC provider setup
  static Widget builder(BuildContext context) {
    return BlocProvider<WelcomeBloc>(
      create: (context) => WelcomeBloc()..add(const WelcomeInitialEvent()),
      child: const WelcomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: AppColors.scaffoldBackgroundSplash, // Beige background
      body: BlocConsumer<WelcomeBloc, WelcomeState>(
        listener: (context, state) {
          if (state is WelcomeLoadedState) {
            if (state.shouldNavigateToSignIn) {
              Navigator.pushReplacementNamed(context, RouteConstants.signIn);
            }
            if (state.shouldNavigateToSignUp) {
              Navigator.pushReplacementNamed(context, RouteConstants.signUp);
            }
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: SizedBox(
              height: screenHeight,
              child: Column(
                children: [
                  WelcomeScreen_TopSection(context: context, state: state),
                  WelcomeScreen_DescriptionSection(
                    context: context,
                    state: state,
                  ),
                  WelcomeScreen_ButtonsSection(context: context, state: state),
                  // _buildBottomDivider(context, state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
