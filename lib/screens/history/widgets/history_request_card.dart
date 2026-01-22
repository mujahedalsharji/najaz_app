/*
 * Najaz Mobile App
 * History Request Card
 */

import 'package:flutter/material.dart';

import '../../../models/history_models/my_service_requests_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/string_constants.dart';

class HistoryRequestCard extends StatelessWidget {
  final MyServiceRequestModel request;
  final VoidCallback? onTap;

  const HistoryRequestCard({
    super.key,
    required this.request,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 95,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF0E9DB), width: 1),
        ),
        padding: const EdgeInsets.all(6),
        child: Row(
          children: [
            Container(
              width: 45,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.description_outlined,
                color: AppColors.primaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _serviceTitle(),
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${StringConstants.requestNumber.localized()} : ${request.incrementId ?? request.id ?? ''}',
                          style: AppTextStyles.captionSmall.copyWith(
                            color: AppColors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (_formatDate(request.createdAt).isNotEmpty)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              _formatDate(request.createdAt),
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

  String _serviceTitle() {
    final serviceName = request.service?.name;
    if (serviceName != null && serviceName.trim().isNotEmpty) {
      return serviceName;
    }
    return StringConstants.serviceDetails.localized();
  }

  Widget _buildStatusBadge(BuildContext context) {
    if (request.status == null || request.status!.isEmpty) {
      return const SizedBox.shrink();
    }

    Color textColor;
    final normalizedStatus = request.status!.toLowerCase();
    final statusText = _localizedStatus(request.status!);

    switch (normalizedStatus) {
      case 'pending':
      case 'waiting':
        textColor = AppColors.warning;
        break;
      case 'confirmed':
      case 'approved':
      case 'accepted':
        textColor = AppColors.success;
        break;
      case 'completed':
      case 'done':
      case 'finished':
        textColor = AppColors.success;
        break;
      case 'cancelled':
      case 'canceled':
      case 'rejected':
      case 'declined':
        textColor = AppColors.error;
        break;
      case 'in_progress':
      case 'processing':
        textColor = const Color(0xFF2563EB);
        break;
      default:
        textColor = AppColors.black;
    }

    return Container(
      padding: const EdgeInsets.only(left: 8, top: 6),
      decoration: BoxDecoration(
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

  String _formatDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '';
    }
    final trimmed = value.trim();
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

