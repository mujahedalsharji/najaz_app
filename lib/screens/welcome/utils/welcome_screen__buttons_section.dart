import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/string_constants.dart';
import '../bloc/welcome_bloc.dart';
import '../bloc/welcome_event.dart';
import '../bloc/welcome_state.dart';

class WelcomeScreen_ButtonsSection extends StatelessWidget {
  const WelcomeScreen_ButtonsSection({
    super.key,
    required this.context,
    required this.state,
  });

  final BuildContext context;
  final WelcomeState state;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(
        top: screenHeight * 0.1, // ~6% of screen height
        left: 16,
        right: 16,
      ),
      child: Row(
        children: [
          // Create Account button (filled) - left button
          Expanded(
            child: ElevatedButton(
              onPressed:
                  () => context.read<WelcomeBloc>().add(
                    const SignUpButtonPressedEvent(),
                  ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    AppColors.primaryColor, // Dark brown background
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.015,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Text(
                StringConstants.createAccount.localized(), // "إنشاء حساب"
                style: AppTextStyles.buttonPrimary.copyWith(
                  color: AppColors.textOnPrimary, // White text
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width * 0.04,
          ), // ~4% of screen width
          // Sign In button (outlined) - Left button
          Expanded(
            child: OutlinedButton(
              onPressed:
                  () => context.read<WelcomeBloc>().add(
                    const SignInButtonPressedEvent(),
                  ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primaryColor, width: 3.0),
                backgroundColor: AppColors.backgroundLight, // Cream background
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.015,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              child: Text(
                StringConstants.signIn.localized(), // "تسجيل الدخول"
                style: AppTextStyles.buttonSecondary.copyWith(
                  color: AppColors.primaryColor, // Dark brown text
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
