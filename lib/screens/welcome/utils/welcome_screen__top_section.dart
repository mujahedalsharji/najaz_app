import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/assets_constants.dart';
import '../../../utils/constants/string_constants.dart';
import '../bloc/welcome_state.dart';

class WelcomeScreen_TopSection extends StatelessWidget {
  const WelcomeScreen_TopSection({
    super.key,
    required this.context,
    required this.state,
  });

  final BuildContext context;
  final WelcomeState state;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      // color: AppColors.scaffoldBackgroundSplash,
      width: double.infinity,
      height: screenHeight * 0.70, // Top section takes ~65% of screen
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(AssetConstants.vector),
          // Welcome text overlay at bottom of top section
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.14,
                //  right: MediaQuery.of(context).size.width * 0.14,
                // ~10% of screen width
                top: screenHeight * 0.02, // ~3% of screen height
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: StringConstants.welcomeToNajazPlatform.localized(),
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: 28,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          // Logo and app name in center
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.1, // ~10% of screen height
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.1), // ~10% of screen height
                  // Circular logo
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.width * 0.45,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        AssetConstants.logo,
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.4,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.015,
                  ), // ~1% of screen height
                  // App name "نجاز" (Najaz) - localized
                  Text(
                    StringConstants.appName.localized(),
                    style: AppTextStyles.headlineLarge.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
