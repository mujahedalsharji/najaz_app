/*
 * Najaz Mobile App
 * Language Selection Screen
 * 
 * This file contains the language selection screen view.
 * Similar to Bagisto's Language screen, tailored for Najaz.
 */

import 'package:flutter/material.dart';

import '../../../utils/application_localization.dart';
import '../../../utils/constants/string_constants.dart';
import '../widgets/language_body.dart';

/// Language Screen
///
/// Main screen for language selection
class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  /// Builder method for route generation
  static Widget builder(BuildContext context, Object? arguments) {
    return const LanguageScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringConstants.language.localized(),
        ),
        centerTitle: false,
      ),
      body: const LanguageBody(),
    );
  }
}

