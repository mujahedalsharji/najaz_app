/*
 * Najaz Mobile App
 * Home App Bar Shimmer Widget
 * 
 * This file contains the shimmer loading widget for home app bar.
 * Shows shimmer for API data (citizen name, verification status, notifications).
 */

import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/assets_constants.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/custom_search_bar.dart';
import '../../../widgets/shimmer_widget.dart';

/// Home App Bar Shimmer Widget
///
/// Shows shimmer loading for home app bar while API data is loading
class HomeAppBarShimmer extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(158.0),
      child: ClipPath(
        child: Stack(
          children: [
            Image.asset(AssetConstants.homeAppBarVector),
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top row: Welcome (static), Verification Status (shimmer), Notification (shimmer)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Welcome text (static - always visible)
                        Text(
                          StringConstants.welcome.localized(),
                          style: AppTextStyles.bodySmall.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),

                        // Verification status shimmer (data from API)
                        const Expanded(
                          child: Center(
                            child: ShimmerTextLine(
                              width: 100,
                              height: 12,
                            ),
                          ),
                        ),

                        // Notification icon shimmer (data from API)
                        ShimmerWidget(
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Citizen name shimmer (data from API)
                    const ShimmerTextLine(
                      width: 150,
                      height: 14,
                    ),
                    const SizedBox(height: 16),

                    // Search bar (static - always visible)
                    CustomSearchBar(context: context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(158.0);
}

