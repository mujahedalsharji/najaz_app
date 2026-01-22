import 'package:flutter/material.dart';
import 'package:najaz_app/utils/application_localization.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_navigation.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/constants/route_constants.dart';
import '../../../utils/constants/string_constants.dart';

class sign_up_NavigateLoginText extends StatelessWidget {
  const sign_up_NavigateLoginText({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: GestureDetector(
        onTap: () {
          AppNavigation.navigateTo(context, RouteConstants.signIn);
        },
        child: RichText(
          text: TextSpan(
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.black),
            children: <TextSpan>[
              TextSpan(text: StringConstants.alreadyHaveAccount.localized()),
              TextSpan(
                text: ' ${StringConstants.signIn.localized()}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
