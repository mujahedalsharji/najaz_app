/*
 * Najaz Mobile App
 * Step 4: Confirmation
 * 
 * This widget displays the confirmation screen for verification Step 4.
 */

import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/string_constants.dart';
import '../bloc/account_verification_state.dart';

/// Step 4: Confirmation and Review
class Step4Confirmation extends StatelessWidget {
  final VerificationStepState state;

  const Step4Confirmation({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.spacingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          Text(
            StringConstants.confirmation.localized(),
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.spacingMedium),
          // Description
          Text(
            StringConstants.confirmationDescription.localized(),
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.spacingLarge),
          // Review Section
          Container(
            padding: const EdgeInsets.all(AppSpacing.spacingLarge),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSpacing.spacingNormal),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Personal Information Review
                _buildReviewSection(
                  title: StringConstants.personalInfo.localized(),
                  items: [
                    if (state.fullName != null)
                      _ReviewItem(
                        label: StringConstants.fullName.localized(),
                        value: state.fullName!,
                      ),
                    if (state.dateOfBirth != null)
                      _ReviewItem(
                        label: StringConstants.dateOfBirthLabel.localized(),
                        value: state.dateOfBirth!,
                      ),
                    if (state.nationalId != null)
                      _ReviewItem(
                        label: StringConstants.nationalIdLabel.localized(),
                        value: state.nationalId!,
                      ),
                  ],
                ),
                const Divider(height: 32),
                // ID Card Review
                _buildReviewSection(
                  title: StringConstants.idCard.localized(),
                  items: [
                    _ReviewItem(
                      label: StringConstants.idCardFront.localized(),
                      value: state.frontImage != null
                          ? StringConstants.uploaded.localized()
                          : StringConstants.notUploaded.localized(),
                      hasError: state.frontImage == null,
                    ),
                    _ReviewItem(
                      label: StringConstants.idCardBack.localized(),
                      value: state.backImage != null
                          ? StringConstants.uploaded.localized()
                          : StringConstants.notUploaded.localized(),
                      hasError: state.backImage == null,
                    ),
                  ],
                ),
                const Divider(height: 32),
                // Video Verification Review
                _buildReviewSection(
                  title: StringConstants.videoVerification.localized(),
                  items: [
                    _ReviewItem(
                      label: StringConstants.videoStatus.localized(),
                      value: state.videoPath != null
                          ? StringConstants.recorded.localized()
                          : StringConstants.notRecorded.localized(),
                      hasError: state.videoPath == null,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.spacingLarge),
          // Confirmation checkbox
          Row(
            children: [
              Checkbox(
                value: true, // Always checked when reaching this step
                onChanged: null, // Disabled
                activeColor: AppColors.primaryColor,
              ),
              Expanded(
                child: Text(
                  StringConstants.confirmVerificationInfo.localized(),
                  style: AppTextStyles.bodyMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.spacingWide),
        ],
      ),
    );
  }

  /// Build review section
  Widget _buildReviewSection({
    required String title,
    required List<_ReviewItem> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: AppSpacing.spacingMedium),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.spacingMedium),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      item.label,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.spacingMedium),
                  Expanded(
                    child: Text(
                      item.value,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: item.hasError
                            ? AppColors.error
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

/// Review item model
class _ReviewItem {
  final String label;
  final String value;
  final bool hasError;

  _ReviewItem({
    required this.label,
    required this.value,
    this.hasError = false,
  });
}

