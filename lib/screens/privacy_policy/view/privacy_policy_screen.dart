/*
 * Najaz Mobile App
 * Privacy Policy Screen
 *
 * This file contains the privacy policy screen UI.
 * Displays the privacy policy content to users.
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
import '../../sign_up/widgets/custom_app_bar.dart';
import '../widgets/privacy_policy_body.dart';

/// Privacy Policy Screen
///
/// Displays privacy policy content to users and handles sign-up submission
class PrivacyPolicyScreen extends StatelessWidget {
  final Map<String, dynamic>? signUpData;

  const PrivacyPolicyScreen({super.key, this.signUpData});

  /// Builder method for BLoC provider setup
  static Widget builder(BuildContext context,
      {Map<String, dynamic>? signUpData}) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(repository: SignUpRepositoryImp()),
      child: PrivacyPolicyBlocContainer(signUpData: signUpData),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(title: StringConstants.privacyPolicy.localized()),
            PrivacyPolicyBody(signUpData: signUpData),
          ],
        ),
      ),
    );
  }
}

/// BLoC Container for Privacy Policy Screen
///
/// Handles BLoC state listening and navigation
class PrivacyPolicyBlocContainer extends StatelessWidget {
  final Map<String, dynamic>? signUpData;

  const PrivacyPolicyBlocContainer({super.key, this.signUpData});

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
        return Scaffold(
          backgroundColor: AppColors.backgroundLight,
          body: SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(title: StringConstants.privacyPolicy.localized()),
                PrivacyPolicyBody(signUpData: signUpData),
              ],
            ),
          ),
        );
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

