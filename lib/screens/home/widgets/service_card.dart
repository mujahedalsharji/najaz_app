/*
 * Najaz Mobile App
 * Service Card Widget
 * 
 * This file contains the service card widget for displaying services
 * on the home screen. Follows Bagisto's product card pattern, tailored for Najaz.
 */

import 'package:flutter/material.dart';

import '../../../models/service_models/service_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_navigation.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/constants/route_constants.dart';
import '../../../widgets/image_view.dart';

/// Service Card Widget
///
/// Displays a service card with image, name, description, and optional category badge
/// Navigates to service details on tap
class ServiceCard extends StatelessWidget {
  /// Service model to display
  final ServiceModel service;

  /// Whether to show category badge
  final bool showCategoryBadge;

  /// Card width (optional, for grid layouts)
  final double? width;

  const ServiceCard({
    Key? key,
    required this.service,
    this.showCategoryBadge = true,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to service details screen
        // TODO: Implement when service details screen is ready
        AppNavigation.navigateTo(
          context,
          RouteConstants.serviceDetails,
          arguments: {
            'serviceId': service.id,
            'serviceName': service.name,
            'serviceDescription': service.description,
            'serviceImage': service.baseImage ?? service.image,
          },
        );
      },
      child: Container(
        width: width ?? double.infinity, // Default width from SVG or fill available space
        height: 260, // Total height from SVG
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16), // rx=16 from SVG
          border: Border.all(color: const Color(0xFFF0E9DB), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Service image (flexible to fit available space)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0), // Small margin around image
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12), // Slightly rounded corners
                  child: Container(
                    width: double.infinity,
                    color: Colors.grey[200],
                    child:
                        (service.imageUrl != null && service.imageUrl!.isNotEmpty)
                            ? ImageView(
                              url: service.imageUrl ?? '',
                              width: double.infinity,
                              height: 0, // Will expand to fill
                              fit: BoxFit.cover,
                            )
                            : Center(
                              child: Icon(
                                Icons.image_outlined,
                                size: 48,
                                color: Colors.grey[400],
                              ),
                            ),
                  ),
                ),
              ),
            ),
            // Service info section (below image) - always visible
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Service name (must be below image)
                  Center(
                    child: Text(
                      service.name ?? '',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // Category badge (optional)
                  if (showCategoryBadge && service.categoryName != null) ...[
                    const SizedBox(height: 6),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          service.categoryName ?? '',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
