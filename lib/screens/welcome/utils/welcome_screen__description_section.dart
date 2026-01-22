import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/string_constants.dart';
import '../bloc/welcome_state.dart';

class WelcomeScreen_DescriptionSection extends StatelessWidget {
  const WelcomeScreen_DescriptionSection({
    super.key,
    required this.context,
    required this.state,
  });

  final BuildContext context;
  final WelcomeState state;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.5,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.020),
      child: Text(
        StringConstants.welcomeDescription.localized(),
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textPrimary,
          //  height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
