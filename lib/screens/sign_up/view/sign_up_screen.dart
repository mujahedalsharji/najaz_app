/*
 * Najaz Mobile App
 * Sign-Up Screen View
 *
 * This file contains the sign-up screen UI with BLoC pattern.
 * Following the design mockup and Bagisto's sign-up pattern.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/auth_models/sign_up_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/route_constants.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/shared_preferences/shared_preference_helper.dart';
import '../../../widgets/show_message.dart';
import '../../sign_up/bloc/sign_up_bloc.dart';
import '../../sign_up/bloc/sign_up_repository.dart';
import '../../sign_up/bloc/sign_up_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/sign_up_body.dart';

/// Sign-Up Screen
///
/// Displays sign-up form with:
/// - Personal information fields (firstName, middleName, lastName)
/// - Gender dropdown
/// - Phone and National ID fields
/// - Date of birth picker
/// - Password fields
/// - Agreement checkbox
/// - Submit button
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  /// Builder method for BLoC provider setup
  static Widget builder(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(repository: SignUpRepositoryImp()),
      child: const SignUpScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // CommonAppBar(
            //   StringConstants.createAccount.localized(),
            //   centerTitle: true,
            //   // elevation: 2.0,
            //   //  backgroundColor: AppColors.backgroundLight,
            //   imageAssetPath: AssetConstants.vectorAuth,
            //   //  imageHeight: 40.0,
            // ),
            CustomAppBar(title: StringConstants.createAccount.localized()),
            SignUpBlocContainer(),
          ],
        ),
      ),
    );
  }
}

/// BLoC Container for Sign-Up Screen
///
/// Handles BLoC state listening and navigation
class SignUpBlocContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpBaseState>(
      listener: (BuildContext context, SignUpBaseState state) {
        if (state is FetchSignUpState) {
          if (state.status == SignUpStatus.fail) {
            ShowMessage.errorNotification(
              state.error ?? StringConstants.somethingWentWrong.localized(),
              context,
            );
          } else if (state.status == SignUpStatus.success) {
            final signUpModel = state.signUpModel;
            if (signUpModel != null) {
              ShowMessage.successNotification(
                state.successMsg ??
                    signUpModel.message ??
                    StringConstants.success.localized(),
                context,
              );
              if (signUpModel.isSuccess) {
                _updateSharedPreferences(signUpModel);
                // Navigate to home screen after successful sign-up
                // TODO: Update to appropriate screen (e.g., set password screen)
                Future.delayed(const Duration(seconds: 1)).then((value) {
                  if (context.mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      RouteConstants.home,
                      (Route<dynamic> route) => false,
                    );
                  }
                });
              }
            }
          }
        }
      },
      builder: (BuildContext context, SignUpBaseState state) {
        return SignUpForm(isLoading: state is SignUpLoadingState);
      },
    );
  }

  /// Updates shared preferences with sign-up data
  Future<void> _updateSharedPreferences(SignUpModel signUpModel) async {
    appStoragePref.setCitizenLoggedIn(true);

    if (signUpModel.data != null) {
      appStoragePref.setCitizenName(""); // Name not available in response
      appStoragePref.setCitizenEmail(signUpModel.data!.email ?? "");
      appStoragePref.setCitizenPhone(signUpModel.data!.phone ?? "");

      if (signUpModel.data!.id != null) {
        try {
          appStoragePref.setCitizenId(int.parse(signUpModel.data!.id!));
        } catch (e) {
          // Handle parsing error
        }
      }
    }

    // Store token in Bagisto's format: "${tokenType} ${token}"
    if (signUpModel.token != null && signUpModel.tokenType != null) {
      appStoragePref.setCitizenToken(
        "${signUpModel.tokenType} ${signUpModel.token}",
      );
    }
  }
}

/// Sign-Up Form Widget
///
/// Contains the form UI with all input fields
