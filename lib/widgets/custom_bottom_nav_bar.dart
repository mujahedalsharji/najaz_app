import 'package:flutter/material.dart';
import 'package:najaz_app/utils/application_localization.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/constants/string_constants.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  @override
  Widget build(BuildContext context) {
    return bottomNavigationBar(context);
  }

  Widget bottomNavigationBar(BuildContext context) {
    return Container(
      height: 65,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: const Color(0xFFF0E9DB), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: bottomNavItem(
              context,
              icon: Icons.home_outlined,
              label: StringConstants.home.localized(),
              isActive: currentIndex == 0,
              onTap: () => onItemSelected(0),
            ),
          ),
          Expanded(
            child: bottomNavItem(
              context,
              icon: Icons.search_sharp,
              label: StringConstants.services.localized(),
              isActive: currentIndex == 1,
              onTap: () => onItemSelected(1),
            ),
          ),
          Expanded(
            child: bottomNavItem(
              context,
              icon: Icons.access_time_sharp,
              label: StringConstants.history.localized(),
              isActive: currentIndex == 2,
              onTap: () => onItemSelected(2),
            ),
          ),
          Expanded(
            child: bottomNavItem(
              context,
              icon: Icons.account_circle_outlined,
              label: StringConstants.profile.localized(),
              isActive: currentIndex == 3,
              onTap: () => onItemSelected(3),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a bottom navigation item
  Widget bottomNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.secondaryColor : AppColors.black,
            size: 28,
          ),
          //  const SizedBox(height: 2),
          Flexible(
            child: Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                fontSize: 12,
                color: isActive ? AppColors.secondaryColor : AppColors.black,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
