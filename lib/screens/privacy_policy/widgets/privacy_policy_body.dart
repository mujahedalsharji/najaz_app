/*
 * Najaz Mobile App
 * Privacy Policy Body Widget
 *
 * This file contains the privacy policy content widget.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/common_widgets.dart';
import '../../sign_up/bloc/sign_up_bloc.dart';
import '../../sign_up/bloc/sign_up_event.dart';
import '../../sign_up/bloc/sign_up_state.dart';

/// Privacy Policy Body Widget
///
/// Displays the privacy policy content and handles sign-up submission
class PrivacyPolicyBody extends StatefulWidget {
  final Map<String, dynamic>? signUpData;

  const PrivacyPolicyBody({super.key, this.signUpData});

  @override
  State<PrivacyPolicyBody> createState() => _PrivacyPolicyBodyState();
}

class _PrivacyPolicyBodyState extends State<PrivacyPolicyBody> {
  bool _isLoading = false;
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    final isLoading =
        _isLoading || (BlocProvider.of<SignUpBloc>(context).state is SignUpLoadingState);

    return BlocListener<SignUpBloc, SignUpBaseState>(
      listener: (context, state) {
        if (state is SignUpLoadingState) {
          setState(() {
            _isLoading = true;
          });
        } else if (state is FetchSignUpState) {
          setState(() {
            _isLoading = false;
          });
        }
      },
      child: IgnorePointer(
        ignoring: isLoading,
        child: Opacity(
          opacity: isLoading ? 0.6 : 1.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spacingLarge,
              vertical: AppSpacing.spacingMedium,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.spacingLarge),

                // Last Updated Date
                Text(
                  StringConstants.lastUpdated.localized(),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.spacingMedium),

                // Privacy Policy Content
                Text(
                  StringConstants.privacyPolicyContent.localized(),
                  style: AppTextStyles.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.spacingLarge),

                // Section: Information We Collect
                _buildSection(
                  title: StringConstants.informationWeCollect.localized(),
                  content: StringConstants.informationWeCollectContent.localized(),
                ),
                const SizedBox(height: AppSpacing.spacingLarge),

                // Section: How We Use Your Information
                _buildSection(
                  title: StringConstants.howWeUseYourInformation.localized(),
                  content:
                      StringConstants.howWeUseYourInformationContent.localized(),
                ),
                const SizedBox(height: AppSpacing.spacingLarge),

                // Section: Information Sharing
                _buildSection(
                  title: StringConstants.informationSharing.localized(),
                  content: StringConstants.informationSharingContent.localized(),
                ),
                const SizedBox(height: AppSpacing.spacingLarge),

                // Section: Data Security
                _buildSection(
                  title: StringConstants.dataSecurity.localized(),
                  content: StringConstants.dataSecurityContent.localized(),
                ),
                const SizedBox(height: AppSpacing.spacingLarge),

                // Section: Your Rights
                _buildSection(
                  title: StringConstants.yourRights.localized(),
                  content: StringConstants.yourRightsContent.localized(),
                ),
                const SizedBox(height: AppSpacing.spacingLarge),

                // Section: Contact Us
                _buildSection(
                  title: StringConstants.contactUs.localized(),
                  content: StringConstants.contactUsContent.localized(),
                ),

                // Agreement Checkbox (only show if signUpData is provided)
                if (widget.signUpData != null) ...[
                  const SizedBox(height: AppSpacing.spacingLarge * 2),
                  _buildAgreementCheckbox(),
                  const SizedBox(height: AppSpacing.spacingLarge),

                  // Submit Button
                  _buildSubmitButton(),
                  const SizedBox(height: AppSpacing.spacingLarge),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds agreement checkbox
  Widget _buildAgreementCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: _agreed,
          onChanged: (bool? value) {
            setState(() {
              _agreed = value ?? false;
            });
          },
          activeColor: AppColors.primaryColor,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _agreed = !_agreed;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: AppSpacing.spacingNormal),
              child: Text(
                '${StringConstants.iAgree.localized()} ${StringConstants.privacyPolicy.localized()}',
                style: AppTextStyles.bodyMedium,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds submit button
  Widget _buildSubmitButton() {
    return CommonWidgets().appButton(
      context,
      StringConstants.signUp.localized(),
      textColor: AppColors.white,
      _onSubmit,
    );
  }

  /// Handles form submission
  void _onSubmit() {
    if (_isLoading) return;

    if (!_agreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(StringConstants.pleaseAcceptAgreement.localized()),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    if (widget.signUpData != null) {
      final bloc = context.read<SignUpBloc>();

      bloc.add(
        FetchSignUpEvent(
          firstName: widget.signUpData!['firstName'] as String?,
          middleName: widget.signUpData!['middleName'] as String?,
          lastName: widget.signUpData!['lastName'] as String?,
          gender: widget.signUpData!['gender'] as String?,
          phone: widget.signUpData!['phone'] as String?,
          nationalId: widget.signUpData!['nationalId'] as String?,
          dateOfBirth: widget.signUpData!['dateOfBirth'] as String?,
          citizenTypeId: widget.signUpData!['citizenTypeId'] as int?,
          password: widget.signUpData!['password'] as String?,
          passwordConfirmation: widget.signUpData!['passwordConfirmation'] as String?,
          agreement: true,
        ),
      );
    }
  }

  /// Builds a section with title and content
  Widget _buildSection({
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: AppSpacing.spacingNormal),
        Text(
          content,
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}

