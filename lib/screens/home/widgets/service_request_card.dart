/*
 * Najaz Mobile App
 * Service Request Card Widget
 * 
 * This file contains the service request card widget for Current Requests section.
 * Matches the design from الطلبات الحالية.svg
 */

import 'package:flutter/material.dart';

import '../../../models/home_models/home_page_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/string_constants.dart';

/// Service Request Card Widget
///
/// Displays a service request card with:
/// - Request name (service name)
/// - Status badge
/// - Increment ID
/// Matches SVG design: white card, #F0E9DB border, rx=16, height=92
class ServiceRequestCard extends StatelessWidget {
  /// Service request model to display
  final ServiceRequestModel request;
  final VoidCallback? onTap;

  const ServiceRequestCard({
    Key? key,
    required this.request,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 95, // Matches SVG design
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16), // rx=16 from SVG
          border: Border.all(color: const Color(0xFFF0E9DB), width: 1),
        ),
        padding: const EdgeInsets.all(6),
        child: Row(
          children: [
            // Service icon/placeholder
            Container(
              width: 45,
              height: 48,
              decoration: BoxDecoration(
                //  color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.description_outlined,
                color: AppColors.primaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            // Request info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Service name and status (same row)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          request.service?.name ??
                              StringConstants.serviceDetails.localized(),
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildStatusBadge(context),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Increment ID and Created At (second row)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'رقم الطلب : ${request.incrementId ?? request.id ?? ''}',
                          style: AppTextStyles.captionSmall.copyWith(
                            color: AppColors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (_formatCreatedAt(request.createdAt).isNotEmpty)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              _formatCreatedAt(request.createdAt),
                              style: AppTextStyles.captionSmall.copyWith(
                                color: AppColors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds status badge widget
  Widget _buildStatusBadge(BuildContext context) {
    if (request.status == null || request.status!.isEmpty) {
      return const SizedBox.shrink();
    }

    // Determine badge color and text based on status
    // Color badgeColor;
    Color textColor;
    final normalizedStatus = request.status!.toLowerCase();
    final statusText = _localizedStatus(request.status!);

    switch (normalizedStatus) {
      case 'pending':
      case 'waiting':
        //  badgeColor = AppColors.warning.withOpacity(0.2);
        textColor = AppColors.warning;
        break;
      case 'confirmed':
      case 'approved':
      case 'accepted':
        //    badgeColor = AppColors.success.withOpacity(0.2);
        textColor = AppColors.success;
        break;
      case 'completed':
      case 'done':
      case 'finished':
        //   badgeColor = AppColors.success.withOpacity(0.2);
        textColor = AppColors.success;
        break;
      case 'cancelled':
      case 'canceled':
      case 'rejected':
      case 'declined':
        //    badgeColor = AppColors.error.withOpacity(0.2);
        textColor = AppColors.error;
        break;
      case 'in_progress':
      case 'processing':
        //    badgeColor = const Color(0xFF2563EB).withOpacity(0.2); // Blue from SVG
        textColor = const Color(0xFF2563EB);
        break;
      default:
        //    badgeColor = AppColors.textSecondary.withOpacity(0.2);
        textColor = AppColors.black;
    }

    return Container(
      padding: const EdgeInsets.only(left: 8, top: 6),
      decoration: BoxDecoration(
        //    color: badgeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        statusText,
        style: AppTextStyles.captionMedium.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  String _formatCreatedAt(String? createdAt) {
    if (createdAt == null || createdAt.trim().isEmpty) {
      return '';
    }
    final trimmed = createdAt.trim();
    if (trimmed.length >= 10) {
      return trimmed.substring(0, 10);
    }
    return trimmed;
  }

  String _localizedStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
      case 'waiting':
        return StringConstants.pending.localized();
      case 'confirmed':
      case 'approved':
      case 'accepted':
        return StringConstants.confirmed.localized();
      case 'completed':
      case 'done':
      case 'finished':
        return StringConstants.completed.localized();
      case 'cancelled':
      case 'canceled':
      case 'rejected':
      case 'declined':
        return StringConstants.cancelled.localized();
      case 'in_progress':
      case 'processing':
        return StringConstants.processing.localized();
      default:
        return status;
    }
  }
}
