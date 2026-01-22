/*
 * Najaz Mobile App
 * History Body
 */

import 'package:flutter/material.dart';

import '../../../models/history_models/my_service_requests_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/assets_constants.dart';
import '../../../utils/constants/route_constants.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/app_navigation.dart';
import '../../../widgets/empty_state.dart';
import 'history_request_card.dart';
import 'history_status_overlay.dart';

class HistoryBody extends StatelessWidget {
  final List<MyServiceRequestModel>? requests;
  final VoidCallback onRefresh;
  final String? selectedStatus;
  final ValueChanged<String?> onStatusSelected;
  final bool isLoading;

  const HistoryBody({
    super.key,
    required this.requests,
    required this.onRefresh,
    required this.selectedStatus,
    required this.onStatusSelected,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final hasRequests = requests != null && requests!.isNotEmpty;

    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildStatusHeader(context)),
          SliverToBoxAdapter(
            child:
                isLoading
                    ? const LinearProgressIndicator(minHeight: 2)
                    : const SizedBox(height: 2),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          if (hasRequests)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList.separated(
                itemCount: requests!.length,
                separatorBuilder:
                    (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final request = requests![index];
                  return HistoryRequestCard(
                    request: request,
                    onTap: () => _showStatusOverlay(context, request.status),
                  );
                },
              ),
            )
          else
            SliverFillRemaining(
              child: EmptyState(
                assetPath: AssetConstants.emptyBookings,
                message: '',
                width: 160,
                height: 160,
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
    );
  }

  Widget _buildStatusHeader(BuildContext context) {
    final tabs = [
      _StatusTab(label: StringConstants.all.localized(), status: null),
      _StatusTab(label: 'تحتاج مراجعة', status: 'needs_revision'),
      _StatusTab(
        label: StringConstants.cancelled.localized(),
        status: 'canceled',
      ),
      _StatusTab(label: 'مرفوض', status: 'rejected'),
      _StatusTab(
        label: StringConstants.completed.localized(),
        status: 'completed',
      ),
      _StatusTab(label: 'تحت التنفيذ', status: 'in_progress'),
      _StatusTab(label: StringConstants.pending.localized(), status: 'pending'),
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(tabs.length, (index) {
                final tab = tabs[index];
                final isActive = tab.status == selectedStatus;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (index > 0) const SizedBox(width: 24),
                    GestureDetector(
                      onTap: () => onStatusSelected(tab.status),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            tab.label,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color:
                                  isActive
                                      ? AppColors.brandAccent
                                      : AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: 2,
                            width: isActive ? 80 : 0,
                            decoration: BoxDecoration(
                              color: AppColors.brandAccent,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
        Container(
          height: 1,
          color: AppColors.primaryColor.withValues(alpha: 0.2),
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
      ],
    );
  }

  void _showStatusOverlay(BuildContext context, String? status) {
    if (status == null || status.trim().isEmpty) {
      return;
    }

    final normalized = status.trim().toLowerCase();
    String? assetPath;
    bool showSecondaryButton = false;
    String? primaryRoute;
    String? secondaryRoute;

    switch (normalized) {
      case 'pending':
      case 'waiting':
        assetPath = AssetConstants.waitingOverlay;
        showSecondaryButton = false;
        primaryRoute = RouteConstants.requestDetails;
        break;
      case 'needs_revision':
        assetPath = AssetConstants.modifyingOverlay;
        showSecondaryButton = true;
        primaryRoute = RouteConstants.requestEdit;
        secondaryRoute = RouteConstants.requestDetails;
        break;
      case 'rejected':
        assetPath = AssetConstants.rejectOverlay;
        showSecondaryButton = true;
        primaryRoute = RouteConstants.requestRejection;
        secondaryRoute = RouteConstants.requestDetails;
        break;
      case 'completed':
        assetPath = AssetConstants.successOverlay;
        showSecondaryButton = true;
        primaryRoute = RouteConstants.requestDocument;
        secondaryRoute = RouteConstants.requestDetails;
        break;
      case 'in_progress':
      case 'processing':
        assetPath = AssetConstants.processingOverlay;
        showSecondaryButton = false;
        primaryRoute = RouteConstants.requestDetails;
        break;
      case 'canceled':
      case 'cancelled':
        assetPath = null;
        break;
      default:
        assetPath = null;
    }

    if (assetPath == null || primaryRoute == null) {
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.35),
      builder:
          (_) => HistoryStatusOverlay(
            assetPath: assetPath!,
            showSecondaryButton: showSecondaryButton,
            onClose: () => Navigator.of(context).pop(),
            onPrimary: () {
              Navigator.of(context).pop();
              AppNavigation.navigateTo(context, primaryRoute!);
            },
            onSecondary:
                secondaryRoute == null
                    ? null
                    : () {
                      Navigator.of(context).pop();
                      AppNavigation.navigateTo(context, secondaryRoute!);
                    },
          ),
    );
  }
}

class _StatusTab {
  final String label;
  final String? status;

  const _StatusTab({required this.label, required this.status});
}
