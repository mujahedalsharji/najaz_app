/*
 * Najaz Mobile App
 * Category Item Widget
 * 
 * This file contains the category item widget for the home screen.
 * Displays categories in a horizontal scrollable list.
 * Follows Bagisto's category widget pattern, tailored for Najaz.
 */

import 'package:flutter/material.dart';

import '../../../models/service_models/category_model.dart';
import '../../../screens/main_tabs/main_tabs_screen.dart';
import '../../../utils/app_navigation.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/constants/route_constants.dart';
import '../../../widgets/image_view.dart';

/// Category Item Widget
/// 
/// Displays a single category item in the horizontal category list
/// with circular icon and category name
class CategoryItem extends StatelessWidget {
  /// Category model to display
  final CategoryModel category;

  const CategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to services list filtered by category
        // TODO: Implement when services list screen is ready
        // For now, navigate to services screen with category filter
        final tabs = MainTabsScope.of(context);
        if (tabs != null) {
          tabs.onTabSelected(1);
        } else {
          AppNavigation.navigateTo(
            context,
            RouteConstants.services,
            arguments: {
              'categoryId': category.id,
              'categoryName': category.name,
            },
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: AppSpacing.spacingWide),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.spacingNormal,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: AppSpacing.spacingWide * 5,
              width: AppSpacing.spacingWide * 5,
              child: ClipOval(
                child: ImageView(
                  url: category.imageUrl ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.spacingLarge),
            SizedBox(
              width: AppSpacing.spacingWide * 5,
              child: Text(
                category.name ?? '',
                style: AppTextStyles.labelLarge,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

