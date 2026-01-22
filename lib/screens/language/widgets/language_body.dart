/*
 * Najaz Mobile App
 * Language Selection Body Widget
 * 
 * This file contains the body widget for language selection screen.
 * Similar to Bagisto's Language screen, tailored for Najaz.
 */

import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../models/locale_models/locales_list_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_global_data.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/route_constants.dart';
import '../../../utils/shared_preferences/shared_preference_helper.dart';

/// Language Body Widget
///
/// Displays list of available languages with radio buttons
class LanguageBody extends StatefulWidget {
  const LanguageBody({super.key});

  @override
  State<LanguageBody> createState() => _LanguageBodyState();
}

class _LanguageBodyState extends State<LanguageBody> {
  String selectedCode = '';
  List<LocaleItemModel>? languages;

  @override
  void initState() {
    super.initState();
    // Get languages from GlobalData or use fallback
    languages = GlobalData.languageData?.locales;
    _getCode();
  }

  @override
  Widget build(BuildContext context) {
    // If no languages from API, use fallback from supported locales
    final displayLanguages = languages ?? _getFallbackLanguages();

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: displayLanguages.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            final selectedLocale = displayLanguages[index];
            final localeCode = selectedLocale.code ?? '';
            final localeName = selectedLocale.name ?? '';

            // Update GlobalData
            GlobalData.locale = localeCode;

            // Save to SharedPreferences
            appStoragePref.setCitizenLanguage(localeCode);
            appStoragePref.setLanguageName(localeName);

            // Update selected code in UI
            setState(() {
              selectedCode = localeCode;
            });

            // Restart app to apply language change
            if (mounted) {
              RestartWidget.restartApp(context);
              // Navigate to welcome screen (similar to Bagisto's splash screen navigation)
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteConstants.welcome,
                (route) => false,
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.spacingLarge),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Radio button icon
                selectedCode == displayLanguages[index].code
                    ? Icon(
                        Icons.radio_button_checked,
                        size: 20,
                        color: AppColors.primaryColor,
                      )
                    : Icon(
                        Icons.radio_button_off,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                const SizedBox(width: 14),
                // Language name
                Expanded(
                  child: Text(
                    displayLanguages[index].name ?? '',
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Gets the currently selected language code
  void _getCode() {
    var selectedCode1 = appStoragePref.getCitizenLanguage();
    setState(() {
      if (selectedCode1.isEmpty) {
        // If no stored language, use first available language or default
        selectedCode =
            languages?.first.code ??
            AppConstants.supportedLocales.first.languageCode;
      } else {
        selectedCode = selectedCode1;
      }
    });
  }

  /// Fallback languages from supported locales if API data is not available
  List<LocaleItemModel> _getFallbackLanguages() {
    return AppConstants.supportedLocales.map((locale) {
      // Map locale codes to names
      String name;
      switch (locale.languageCode) {
        case 'ar':
          name = 'العربية';
          break;
        case 'en':
          name = 'English';
          break;
        default:
          name = locale.languageCode;
      }

      return LocaleItemModel(
        id: locale.languageCode,
        code: locale.languageCode,
        name: name,
      );
    }).toList();
  }
}

