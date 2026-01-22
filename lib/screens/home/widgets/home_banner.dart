/*
 * Najaz Mobile App
 * Home Banner Widget
 * 
 * This file contains the banner/slider widget for the home screen.
 * Displays banners in a carousel format.
 * Follows Bagisto's carousel slider pattern, tailored for Najaz.
 */

import 'package:flutter/material.dart';

import '../../../models/home_models/home_data_model.dart';
import '../../../utils/app_navigation.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/image_view.dart';

/// Home Banner Widget
/// 
/// Displays banners/sliders in a carousel format
/// Navigates to link URL on tap if provided
class HomeBanner extends StatelessWidget {
  /// List of banners to display
  final List<BannerModel>? banners;

  /// Banner height
  final double height;

  const HomeBanner({
    Key? key,
    this.banners,
    this.height = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (banners == null || banners!.isEmpty) {
      return const SizedBox.shrink();
    }

    // Simple banner display (carousel can be added later if needed)
    // For now, display first banner or use PageView for multiple banners
    if (banners!.length == 1) {
      return _buildSingleBanner(context, banners!.first);
    }

    // Multiple banners - use PageView
    return SizedBox(
      height: height,
      child: PageView.builder(
        itemCount: banners!.length,
        itemBuilder: (context, index) {
          return _buildSingleBanner(context, banners![index]);
        },
      ),
    );
  }

  Widget _buildSingleBanner(BuildContext context, BannerModel banner) {
    return GestureDetector(
      onTap: () {
        if (banner.link != null && banner.link!.isNotEmpty) {
          // Navigate to banner link
          // TODO: Implement navigation based on link type (URL, route, etc.)
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.spacingNormal,
          vertical: AppSpacing.spacingNormal,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: ImageView(
            url: banner.imageUrl ?? '',
            width: double.infinity,
            height: height,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

