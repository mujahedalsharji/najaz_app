/*
 * Najaz Mobile App
 * Account Verification Screen View
 *
 * This file contains the account verification screen UI with BLoC pattern.
 * Multi-step form for identity verification.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/route_constants.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/shimmer_widget.dart';
import '../../../widgets/show_message.dart';
import '../bloc/account_verification_bloc.dart';
import '../bloc/account_verification_event.dart';
import '../bloc/account_verification_repository.dart';
import '../bloc/account_verification_state.dart';
import '../widgets/step1_personal_info.dart';
import '../widgets/step2_id_card_upload.dart';
import '../widgets/step3_video_verification.dart';
import '../widgets/step4_confirmation.dart';
import '../widgets/verification_success_screen.dart';
import '../widgets/verification_step_indicator.dart';

/// Account Verification Screen
///
/// Multi-step screen for identity verification:
/// - Step 1: Personal Information
/// - Step 2: ID Card Upload
/// - Step 3: Video Verification
/// - Step 4: Confirmation
class AccountVerificationScreen extends StatelessWidget {
  const AccountVerificationScreen({super.key});

  /// Builder method for BLoC provider setup
  static Widget builder(BuildContext context) {
    return BlocProvider<AccountVerificationBloc>(
      create: (context) => AccountVerificationBloc(
        repository: AccountVerificationRepositoryImp(),
      )..add(const VerificationInitialEvent()),
      child: const AccountVerificationScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => _handleBackNavigation(context),
        ),
        title: Text(
          StringConstants.accountVerification.localized(),
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AccountVerificationBloc, AccountVerificationBaseState>(
        listener: (context, state) {
          if (state is VerificationErrorState) {
            ShowMessage.errorNotification(state.error, context);
          } else if (state is VerificationSuccessState) {
            // Navigate to success screen
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => VerificationSuccessScreen(
                  message: state.message,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is VerificationLoadingState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ShimmerContainer(
                    width: 60,
                    height: 60,
                    borderRadius: 30,
                  ),
                  const SizedBox(height: AppSpacing.spacingLarge),
                  Text(
                    StringConstants.uploadingFiles.localized(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacingSmall),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.spacingLarge,
                    ),
                    child: Text(
                      StringConstants.pleaseWaitProcessing.localized(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textTertiary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is VerificationSuccessState) {
            // Show success screen
            return VerificationSuccessScreen(message: state.message);
          }

          if (state is VerificationStatusLoadedState) {
            // Show existing verification status
            return _buildVerificationStatusView(context, state);
          }

          if (state is VerificationStepState) {
            return _buildStepContent(context, state);
          }

          // Default: show initial state
          return const Center(
            child: ShimmerContainer(
              width: 60,
              height: 60,
              borderRadius: 30,
            ),
          );
        },
      ),
    );
  }

  /// Build step content based on current step
  Widget _buildStepContent(
    BuildContext context,
    VerificationStepState state,
  ) {
    return Column(
      children: [
        // Step indicator
        VerificationStepIndicator(currentStep: state.currentStep),
        const Divider(height: 1),
        // Step content
        Expanded(
          child: SingleChildScrollView(
            child: _getStepWidget(context, state),
          ),
        ),
        // Navigation buttons
        _buildNavigationButtons(context, state),
      ],
    );
  }

  /// Get widget for current step
  Widget _getStepWidget(
    BuildContext context,
    VerificationStepState state,
  ) {
    switch (state.currentStep) {
      case 1:
        return Step1PersonalInfo(state: state);
      case 2:
        return Step2IdCardUpload(state: state);
      case 3:
        return Step3VideoVerification(state: state);
      case 4:
        return Step4Confirmation(state: state);
      default:
        return Step1PersonalInfo(state: state);
    }
  }

  /// Build navigation buttons (Previous/Next)
  Widget _buildNavigationButtons(
    BuildContext context,
    VerificationStepState state,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Previous button
          if (state.currentStep > 1)
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  context.read<AccountVerificationBloc>().add(
                        NavigateToStepEvent(
                          step: state.currentStep - 1,
                        ),
                      );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primaryColor),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  StringConstants.back.localized(),
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          if (state.currentStep > 1) const SizedBox(width: 16),
          // Next/Submit button
          Expanded(
            child: ElevatedButton(
              onPressed: state.isStepValid || state.currentStep == 4
                  ? () => _handleNextButton(context, state)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                disabledBackgroundColor: AppColors.border,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                state.currentStep == 4
                    ? StringConstants.submit.localized()
                    : StringConstants.next.localized(),
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Handle next button press
  void _handleNextButton(
    BuildContext context,
    VerificationStepState state,
  ) {
    // Save progress before navigating
    context.read<AccountVerificationBloc>().add(
          const SaveVerificationProgressEvent(),
        );

    if (state.currentStep == 4) {
      // Submit verification
      context.read<AccountVerificationBloc>().add(
            const SubmitVerificationEvent(),
          );
    } else {
      // Navigate to next step
      context.read<AccountVerificationBloc>().add(
            NavigateToStepEvent(step: state.currentStep + 1),
          );
    }
  }

  /// Build verification status view when existing verification is found
  Widget _buildVerificationStatusView(
    BuildContext context,
    VerificationStatusLoadedState state,
  ) {
    final verificationData =
        state.verificationData?['verification'] as Map<String, dynamic>?;
    final status = verificationData?['status'] as String? ?? '';
    final notes = verificationData?['notes'] as String?;
    final createdAt = verificationData?['createdAt'] as String?;
    final reviewedAt = verificationData?['reviewedAt'] as String?;

    // Determine status color and text
    Color statusColor;
    String statusText;

    switch (status.toLowerCase()) {
      case 'pending':
      case 'waiting':
        statusColor = AppColors.warning;
        statusText = StringConstants.verificationUnderReview.localized();
        break;
      case 'approved':
      case 'verified':
      case 'accepted':
        statusColor = AppColors.success;
        statusText = StringConstants.verificationApproved.localized();
        break;
      case 'rejected':
      case 'declined':
        statusColor = AppColors.error;
        statusText = StringConstants.verificationRejected.localized();
        break;
      default:
        statusColor = AppColors.textSecondary;
        statusText = status.isNotEmpty
            ? status
            : StringConstants.verificationStatusUndefined.localized();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.spacingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.spacingLarge),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      StringConstants.verificationStatusTitle.localized(),
                      style: AppTextStyles.titleLarge.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        statusText,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                if (createdAt != null || reviewedAt != null) ...[
                  const SizedBox(height: AppSpacing.spacingMedium),
                  Divider(height: 1, color: AppColors.border),
                  const SizedBox(height: AppSpacing.spacingMedium),
                ],
                if (createdAt != null) ...[
                  _buildInfoRow(
                    label: StringConstants.requestDate.localized(),
                    value: createdAt.length >= 10
                        ? createdAt.substring(0, 10)
                        : createdAt,
                  ),
                ],
                if (reviewedAt != null) ...[
                  const SizedBox(height: AppSpacing.spacingSmall),
                  _buildInfoRow(
                    label: StringConstants.reviewDate.localized(),
                    value: reviewedAt.length >= 10
                        ? reviewedAt.substring(0, 10)
                        : reviewedAt,
                  ),
                ],
                if (notes != null && notes.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.spacingMedium),
                  Divider(height: 1, color: AppColors.border),
                  const SizedBox(height: AppSpacing.spacingMedium),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.spacingMedium),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLight,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.border.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.note_outlined,
                              size: 18,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: AppSpacing.spacingSmall),
                            Text(
                              StringConstants.notesLabel.localized(),
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.spacingSmall),
                        Text(
                          notes,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textPrimary,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.spacingLarge),
          // Message based on status
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.spacingLarge),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: statusColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  status.toLowerCase() == 'approved' ||
                          status.toLowerCase() == 'verified'
                      ? Icons.check_circle_outline
                      : status.toLowerCase() == 'rejected' ||
                              status.toLowerCase() == 'declined'
                          ? Icons.cancel_outlined
                          : Icons.info_outline,
                  color: statusColor,
                  size: 24,
                ),
                const SizedBox(width: AppSpacing.spacingMedium),
                Expanded(
                  child: Text(
                    status.toLowerCase() == 'approved' ||
                            status.toLowerCase() == 'verified'
                        ? StringConstants.verificationApprovedMessage.localized()
                        : status.toLowerCase() == 'rejected' ||
                                status.toLowerCase() == 'declined'
                            ? StringConstants.verificationRejectedMessage
                                .localized()
                            : StringConstants.verificationPendingMessage
                                .localized(),
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Edit button (show only for pending or rejected status)
          if (status.toLowerCase() == 'pending' ||
              status.toLowerCase() == 'waiting' ||
              status.toLowerCase() == 'rejected' ||
              status.toLowerCase() == 'declined') ...[
            const SizedBox(height: AppSpacing.spacingLarge),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to edit mode - load verification data into form
                  final verificationId = verificationData?['id'] as String?;
                  if (verificationId != null) {
                    // Dispatch event to start edit mode
                    context.read<AccountVerificationBloc>().add(
                          StartEditVerificationEvent(
                            verificationId: verificationId,
                            currentData: verificationData,
                          ),
                        );
                  }
                },
                icon: const Icon(Icons.edit, color: AppColors.white),
                label: Text(
                  StringConstants.editRequest.localized(),
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Build info row with label and value
  Widget _buildInfoRow({
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.spacingMedium),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  /// Handle back navigation
  void _handleBackNavigation(BuildContext context) {
    final bloc = context.read<AccountVerificationBloc>();
    final state = bloc.state;

    if (state is VerificationStepState && state.currentStep > 1) {
      // Navigate to previous step
      bloc.add(NavigateToStepEvent(step: state.currentStep - 1));
    } else {
      // Exit verification screen
      Navigator.of(context).pop();
    }
  }
}

