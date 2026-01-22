/*
 * Najaz Mobile App
 * Verification Step Indicator
 * 
 * This widget displays the current step in the verification process.
 * Similar to Bagisto's checkout step indicator pattern.
 */

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/string_constants.dart';

/// Verification Step Indicator Widget
///
/// Displays a visual step indicator showing progress through verification steps
class VerificationStepIndicator extends StatelessWidget {
  /// Current step (1-4)
  final int currentStep;

  const VerificationStepIndicator({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    final steps = _getSteps(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spacingLarge,
        vertical: AppSpacing.spacingMedium,
      ),
      child: Column(
        children: [
          // Step icons row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;

              final isActive = currentStep == index + 1;
              final isCompleted = currentStep > index + 1;

              final circleColor = isActive || isCompleted
                  ? AppColors.primaryColor
                  : AppColors.border;

              return Expanded(
                child: Row(
                  children: [
                    // Step circle
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: circleColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: isCompleted
                            ? const Icon(
                                Icons.check,
                                color: AppColors.white,
                                size: 20,
                              )
                            : Text(
                                '${index + 1}',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    // Connecting line (not after last step)
                    if (index < steps.length - 1)
                      Expanded(
                        child: Container(
                          height: 2,
                          margin: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.spacingSmall,
                          ),
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? AppColors.primaryColor
                                : AppColors.border,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.spacingMedium),
          // Step titles row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;

              final isActive = currentStep == index + 1;

              return Expanded(
                child: Text(
                  step['title'] ?? '',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isActive
                        ? AppColors.primaryColor
                        : AppColors.textSecondary,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// Get step configuration
  List<Map<String, String>> _getSteps(BuildContext context) {
    return [
      {
        'title': StringConstants.personalInfo.localized(),
        'icon': FontAwesomeIcons.user.toString(),
      },
      {
        'title': StringConstants.idCard.localized(),
        'icon': FontAwesomeIcons.idCard.toString(),
      },
      {
        'title': StringConstants.videoVerification.localized(),
        'icon': FontAwesomeIcons.video.toString(),
      },
      {
        'title': StringConstants.confirmation.localized(),
        'icon': FontAwesomeIcons.checkCircle.toString(),
      },
    ];
  }
}

