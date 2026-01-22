/*
 * Najaz Mobile App
 * Log-In Screen View
 *
 * This file contains the log-in screen UI with BLoC pattern.
 * Following the design mockup and Bagisto's log-in pattern.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/auth_models/log_in_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/route_constants.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/shared_preferences/shared_preference_helper.dart';
import '../../../widgets/show_message.dart';
import '../../log_in/bloc/log_in_bloc.dart';
import '../../log_in/bloc/log_in_repository.dart';
import '../../log_in/bloc/log_in_state.dart';
import '../../sign_up/widgets/custom_app_bar.dart';
import '../widgets/log_in_body.dart';

/// Log-In Screen
///
/// Displays log-in form with:
/// - Email or National ID input
/// - Password input
/// - Remember me checkbox
/// - Forgot password link
/// - Sign-in button
/// - Sign-up link
class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  /// Builder method for BLoC provider setup
  static Widget builder(BuildContext context) {
    return BlocProvider<LogInBloc>(
      create: (context) => LogInBloc(repository: LogInRepositoryImp()),
      child: const LogInScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(title: StringConstants.signIn.localized()),
            LogInBlocContainer(),
          ],
        ),
      ),
    );
  }
}

/// BLoC Container for Log-In Screen
///
/// Handles BLoC state listening and navigation
class LogInBlocContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogInBloc, LogInBaseState>(
      listener: (BuildContext context, LogInBaseState state) {
        if (state is FetchLogInState) {
          if (state.status == LogInStatus.fail) {
            ShowMessage.errorNotification(
              state.error ?? StringConstants.somethingWentWrong.localized(),
              context,
            );
          } else if (state.status == LogInStatus.success) {
            final logInModel = state.logInModel;
            if (logInModel != null) {
              ShowMessage.successNotification(
                state.successMsg ??
                    logInModel.message ??
                    StringConstants.success.localized(),
                context,
              );
              if (logInModel.isSuccess) {
                _updateSharedPreferences(logInModel);
                // Navigate to home screen after successful log-in
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
      builder: (BuildContext context, LogInBaseState state) {
        return LogInForm(isLoading: state is LogInLoadingState);
      },
    );
  }

  /// Updates shared preferences with log-in data
  Future<void> _updateSharedPreferences(LogInModel logInModel) async {
    appStoragePref.setCitizenLoggedIn(true);

    if (logInModel.data != null) {
      appStoragePref.setCitizenName(""); // Name not available in response
      appStoragePref.setCitizenEmail(logInModel.data!.email ?? "");
      appStoragePref.setCitizenPhone(logInModel.data!.phone ?? "");

      if (logInModel.data!.id != null) {
        try {
          appStoragePref.setCitizenId(int.parse(logInModel.data!.id!));
        } catch (e) {
          // Handle parsing error
        }
      }
    }

    // Store token in Bagisto's format: "${tokenType} ${token}"
    if (logInModel.token != null && logInModel.tokenType != null) {
      appStoragePref.setCitizenToken(
        "${logInModel.tokenType} ${logInModel.token}",
      );
    }
  }
}
