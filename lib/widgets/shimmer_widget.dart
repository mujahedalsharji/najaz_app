/*
 * Najaz Mobile App
 * Shimmer Widget
 * 
 * This file contains reusable shimmer loading widgets.
 * Provides skeleton loading placeholders for various UI elements.
 */

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/app_colors.dart';
import '../utils/app_radii.dart';
import '../utils/app_spacing.dart';

/// Base Shimmer Widget
///
/// Wraps a child widget with shimmer effect
class ShimmerWidget extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerWidget({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? AppColors.shimmerBase,
      highlightColor: highlightColor ?? AppColors.shimmerHighlight,
      period: const Duration(milliseconds: 1200),
      child: child,
    );
  }
}

/// Shimmer Container
///
/// Creates a shimmer effect container with specified dimensions
class ShimmerContainer extends StatelessWidget {
  final double width;
  final double height;
  final double? borderRadius;
  final EdgeInsets? margin;

  const ShimmerContainer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppRadii.card,
          ),
        ),
      ),
    );
  }
}

/// Shimmer Service Card
///
/// Creates a shimmer placeholder for service card
class ShimmerServiceCard extends StatelessWidget {
  final double? width;

  const ShimmerServiceCard({
    super.key,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = width ?? 226.0;

    return ShimmerWidget(
      child: Container(
        width: cardWidth,
        height: 284,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadii.card),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.spacingNormal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image placeholder
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  color: AppColors.shimmerBase,
                  borderRadius: BorderRadius.circular(AppRadii.input),
                ),
              ),
              const SizedBox(height: AppSpacing.spacingNormal),

              // Title placeholder
              Container(
                width: double.infinity,
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.shimmerBase,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: AppSpacing.spacingSmall),

              // Description placeholder
              Container(
                width: double.infinity * 0.8,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.shimmerBase,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shimmer Service Request Card
///
/// Creates a shimmer placeholder for service request card
class ShimmerServiceRequestCard extends StatelessWidget {
  final double? width;

  const ShimmerServiceRequestCard({
    super.key,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = width ?? MediaQuery.of(context).size.width * 0.65;

    return ShimmerWidget(
      child: Container(
        width: cardWidth,
        height: 92,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadii.card),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(AppSpacing.spacingNormal),
        child: Row(
          children: [
            // Icon placeholder
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.shimmerBase,
                borderRadius: BorderRadius.circular(AppRadii.input),
              ),
            ),
            const SizedBox(width: AppSpacing.spacingNormal),

            // Content placeholder
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title placeholder
                  Container(
                    width: double.infinity,
                    height: 14,
                    decoration: BoxDecoration(
                      color: AppColors.shimmerBase,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacingSmall),

                  // Subtitle placeholder
                  Container(
                    width: double.infinity * 0.6,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.shimmerBase,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shimmer Text Line
///
/// Creates a shimmer placeholder for text line
class ShimmerTextLine extends StatelessWidget {
  final double width;
  final double height;
  final double? borderRadius;

  const ShimmerTextLine({
    super.key,
    required this.width,
    this.height = 16,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(
            borderRadius ?? 4,
          ),
        ),
      ),
    );
  }
}

