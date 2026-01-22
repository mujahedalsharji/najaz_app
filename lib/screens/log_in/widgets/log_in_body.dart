import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:najaz_app/utils/application_localization.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_navigation.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/constants/route_constants.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/validators/form_validator_helper.dart';
import '../../../widgets/common_widgets.dart';
import '../bloc/log_in_bloc.dart';
import '../bloc/log_in_event.dart';

class LogInForm extends StatefulWidget {
  final bool isLoading;

  const LogInForm({super.key, this.isLoading = false});

  @override
  State<LogInForm> createState() => LogInFormState();
}

class LogInFormState extends State<LogInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrNationalIdController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _showPassword = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailOrNationalIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = widget.isLoading;
    final bagistoLabelStyle = AppTextStyles.bodyMedium.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    );
    final bagistoInputStyle = AppTextStyles.bodyLarge.copyWith(fontSize: 14);
    final bagistoHintStyle = AppTextStyles.bodyMedium.copyWith(
      fontSize: 14,
      color: AppColors.textSecondary,
    );
    final bagistoErrorStyle = AppTextStyles.bodySmall.copyWith(
      fontSize: 10,
      color: AppColors.error,
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.spacingLarge,
          vertical: AppSpacing.spacingMedium,
        ),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: IgnorePointer(
            ignoring: isLoading,
            child: Opacity(
              opacity: isLoading ? 0.6 : 1.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacing.spacingSmall),

                  // Email/National ID Field
                  CommonWidgets().getTextField(
                    context,
                    _emailOrNationalIdController,
                    prefixIcon: Icon(FontAwesomeIcons.idCard, size: 20),
                    StringConstants.emailOrNationalIdLabel.localized(),
                    label: StringConstants.emailOrNationalIdLabel.localized(),
                    isRequired: true,
                    labelTextStyle: bagistoLabelStyle,
                    inputTextStyle: bagistoInputStyle,
                    hintTextStyle: bagistoHintStyle,
                    errorTextStyle: bagistoErrorStyle,
                    validator:
                        (value) =>
                            FormValidatorHelper.validateEmailOrNationalId(
                              value,
                            ),
                  ),
                  const SizedBox(height: AppSpacing.spacingLarge),

                  // Password Field
                  CommonWidgets().getTextField(
                    context,
                    _passwordController,
                    prefixIcon: Icon(Icons.lock_outline, size: 25),
                    StringConstants.passwordLabel.localized(),
                    label: StringConstants.passwordLabel.localized(),
                    isRequired: true,
                    obscureText: !_showPassword,
                    labelTextStyle: bagistoLabelStyle,
                    inputTextStyle: bagistoInputStyle,
                    hintTextStyle: bagistoHintStyle,
                    errorTextStyle: bagistoErrorStyle,
                    validator:
                        (value) => FormValidatorHelper.validatePassword(value),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacingLarge),

                  // Forgot Password Link
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: GestureDetector(
                      onTap: () {
                        if (!isLoading) {
                          AppNavigation.navigateTo(
                            context,
                            RouteConstants.forgotPassword,
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.spacingNormal,
                        ),
                        child: Text(
                          StringConstants.forgotPassword.localized(),
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacingLarge * 4),

                  // Sign-In Button
                  _signInButton(),
                  const SizedBox(height: AppSpacing.spacingLarge),

                  // Don't have account? Sign Up text
                  _signUpText(),
                  const SizedBox(height: AppSpacing.spacingLarge),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds sign-in button
  Widget _signInButton() {
    return CommonWidgets().appButton(
      context,
      StringConstants.signIn.localized(),
      textColor: AppColors.white,
      _onLoginIn,
    );
  }

  /// Builds "Don't have an account? Sign Up" text
  Widget _signUpText() {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (!widget.isLoading) {
            AppNavigation.navigateTo(context, RouteConstants.signUp);
          }
        },
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            children: <TextSpan>[
              TextSpan(text: StringConstants.dontHaveAccount.localized()),
              TextSpan(
                text: ' ${StringConstants.signUp.localized()}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Handles sign-in form submission
  void _onLoginIn() {
    if (_formKey.currentState!.validate()) {
      final bloc = context.read<LogInBloc>();

      bloc.add(
        FetchLogInEvent(
          emailOrNationalId: _emailOrNationalIdController.text.trim(),
          password: _passwordController.text.trim(),
          remember: _rememberMe,
        ),
      );
    }
  }
}
