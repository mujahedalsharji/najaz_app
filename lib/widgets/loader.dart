/*
 * Najaz Mobile App
 * Loader Widget
 * 
 * This file contains a reusable loading indicator widget.
 * Follows Bagisto's Loader pattern, tailored for Najaz.
 */

import 'package:flutter/material.dart';
import '../utils/app_text_styles.dart';
import '../utils/app_spacing.dart';
import 'shimmer_widget.dart';

/// Loader Widget
/// 
/// A reusable loading indicator with optional message.
/// Displays a circular progress indicator centered on screen.
class Loader extends StatelessWidget {
  /// Optional loading message to display
  final String? loadingMessage;

  /// Optional color for the progress indicator
  final Color? color;

  const Loader({
    Key? key,
    this.loadingMessage,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (loadingMessage != null && loadingMessage!.isNotEmpty) ...[
            Text(
              loadingMessage!,
              textAlign: TextAlign.center,
              style: AppTextStyles.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.spacingWide),
          ],
          ShimmerContainer(
            width: 48,
            height: 48,
            borderRadius: 24,
          ),
        ],
      ),
    );
  }
}

