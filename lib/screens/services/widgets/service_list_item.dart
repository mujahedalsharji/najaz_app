/*
 * Najaz Mobile App
 * Service List Item Widget
 * 
 * This file contains the service list item widget for services screen.
 */

import 'package:flutter/material.dart';

import '../../../models/service_models/service_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_navigation.dart';
import '../../../utils/constants/route_constants.dart';
import '../../../utils/app_text_styles.dart';
import '../../../widgets/image_view.dart';

/// Service List Item Widget
///
/// A list item widget for displaying a service
class ServiceListItem extends StatelessWidget {
  /// Service model
  final ServiceModel service;

  const ServiceListItem({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
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
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ImageView(
                  url: service.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              // Service details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Service name
                    Text(
                      service.name ?? '',
                      style: AppTextStyles.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Service description
                    if (service.description != null &&
                        service.description!.isNotEmpty)
                      Text(
                        service.description!,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 8),
                    // Category badge
                    if (service.categoryName != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor.withValues(
                            alpha: 0.3,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          service.categoryName!,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: 10,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
