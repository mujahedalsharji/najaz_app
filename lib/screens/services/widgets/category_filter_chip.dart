/*
 * Najaz Mobile App
 * Category Filter Chip Widget
 * 
 * This file contains the category filter chip widget for services screen.
 */

import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';

/// Category Filter Chip Widget
///
/// A chip widget for filtering services by category
class CategoryFilterChip extends StatelessWidget {
  /// Category label
  final String label;

  /// Whether this chip is selected
  final bool isSelected;

  /// Callback when chip is selected
  final VoidCallback? onSelected;

  const CategoryFilterChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: isSelected ? Colors.white : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        onSelected: (_) => onSelected?.call(),
        backgroundColor: Colors.white,
        selectedColor: AppColors.primaryColor,
        checkmarkColor: Colors.white,
        side: BorderSide(
          color: isSelected
              ? AppColors.primaryColor
              : AppColors.textSecondary.withValues(alpha: 0.3),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}

