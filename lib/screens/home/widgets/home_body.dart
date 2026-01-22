/*
 * Najaz Mobile App
 * Home Body Widget
 * 
 * This file contains the main body widget for the home screen.
 * Layout matches Home Page.svg design exactly.
 */

import 'package:flutter/material.dart';
import 'package:najaz_app/screens/home/widgets/service_card.dart';
import 'package:najaz_app/screens/main_tabs/main_tabs_screen.dart';

import '../../../models/home_models/home_page_model.dart';
import '../../../models/service_models/service_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_navigation.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/assets_constants.dart';
import '../../../utils/constants/route_constants.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/shimmer_widget.dart';
import '../../history/widgets/history_status_overlay.dart';
import 'home_app_bar.dart';
import 'home_app_bar_shimmer.dart';
import 'service_request_card.dart';

/// Home Body Widget
///
/// Main content widget for the home screen
/// Layout matches SVG design: Search bar, Current Requests, Services cards, Bottom nav
class HomeBody extends StatelessWidget {
  /// Home page data model
  final HomePageModel? homePageData;

  /// Service requests list
  final List<ServiceRequestModel>? serviceRequests;

  /// Services list for home page
  final List<ServiceHomeModel>? services;

  /// Whether data is loading
  final bool isLoading;

  /// On refresh callback
  final VoidCallback? onRefresh;

  const HomeBody({
    Key? key,
    this.homePageData,
    this.serviceRequests,
    this.services,
    this.isLoading = false,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Column(
          children: [
            if (isLoading) const HomeAppBarShimmer() else HomeAppBar(),
            // Main scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Current Requests Section (الطلبات الحالية) - replaces Categories
                    // Always show section title, even if no requests
                    if (!isLoading &&
                        homePageData?.citizen?.identityVerificationStatus !=
                        null) ...[
                      _buildVerificationAlert(
                        context,
                        homePageData!.citizen!.identityVerificationStatus!,
                      ),
                      const SizedBox(height: 20),
                    ],
                    if (isLoading)
                      _buildCurrentRequestsShimmer(context)
                    else
                      _buildCurrentRequestsSection(context),
                    const SizedBox(height: 24),

                    // Services Cards Section (y=460 in SVG, height=284)
                    if (isLoading)
                      _buildServicesShimmer(context, screenWidth)
                    else if (services != null && services!.isNotEmpty)
                      servicesSection(context, screenWidth)
                    else
                      // Show placeholder services if no data
                      _buildServicesSectionPlaceholder(context, screenWidth),

                    // Bottom spacing for bottom nav
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),

        // Bottom nav handled by MainTabsScreen
      ],
    );
  }

  /// Builds services section (matches SVG: y=460, two cards side by side, scrollable)
  Widget servicesSection(BuildContext context, double screenWidth) {
    // SVG shows two service cards side by side, scrollable horizontally
    // Each card: width=226, height=284, rx=16
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title with View All button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                StringConstants.services.localized(),
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                  fontSize: 18,
                ),
              ),
              // View All button (left) with icon
              GestureDetector(
                onTap: () {
                  final tabs = MainTabsScope.of(context);
                  if (tabs != null) {
                    tabs.onTabSelected(1);
                  } else {
                    AppNavigation.navigateTo(context, RouteConstants.services);
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      StringConstants.viewAll.localized(),
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),

              // Section title (right)
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 260,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: services!.length,
            itemBuilder: (context, index) {
              // Convert ServiceHomeModel to ServiceModel for ServiceCard
              final service = services![index];
              final serviceModel = ServiceModel(
                id: service.id,
                name: service.name,
                description: null,
                baseImage: service.baseImage,
                category: null,
              );

              return Container(
                width: 226,
                margin: EdgeInsets.only(
                  right: index < services!.length - 1 ? 16 : 0,
                  left: index < services!.length - 1 ? 16 : 0,
                ),
                child: ServiceCard(service: serviceModel),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Builds Current Requests section (الطلبات الحالية)
  /// Matches SVG design: horizontal scrollable list of request cards
  Widget _buildCurrentRequestsSection(BuildContext context) {
    final hasRequests = serviceRequests != null && serviceRequests!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title with View All button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Section title (left)
              Text(
                StringConstants.currentRequests.localized(),
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                  fontSize: 18,
                ),
              ),
              // View All button (right) with arrow icon
              GestureDetector(
                onTap: () {
                  final tabs = MainTabsScope.of(context);
                  if (tabs != null) {
                    tabs.onTabSelected(2);
                  } else {
                    AppNavigation.navigateTo(context, RouteConstants.history);
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      StringConstants.viewAll.localized(),
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        // Horizontal scrollable list of request cards or empty state
        if (hasRequests)
          SizedBox(
            height: 92, // Card height matches SVG
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: serviceRequests!.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsetsDirectional.only(
                    end: index < serviceRequests!.length - 1 ? 8 : 0,
                  ),
                  width:
                      MediaQuery.of(context).size.width *
                      0.65, // ~85% of screen width per card
                  child: ServiceRequestCard(
                    request: serviceRequests![index],
                    onTap:
                        () => _showStatusOverlay(
                          context,
                          serviceRequests![index].status,
                        ),
                  ),
                );
              },
            ),
          )
        else
          // Empty state for requests
          Container(
            height: 92,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFF0E9DB), width: 1),
            ),
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                StringConstants.noCurrentRequests.localized(),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Builds verification alert banner if account is not verified
  Widget _buildVerificationAlert(BuildContext context, String verificationStatus) {
    final normalizedStatus = verificationStatus.toLowerCase();

    if (normalizedStatus == 'verified' || normalizedStatus == 'true') {
      return const SizedBox.shrink();
    }

    const alertColor = AppColors.warning;

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: alertColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: alertColor.withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: alertColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              color: alertColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringConstants.notVerified.localized(),
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  StringConstants.verifyAccountMessage.localized(),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () {
              AppNavigation.navigateTo(
                context,
                RouteConstants.accountVerification,
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: alertColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
            child: Text(
              StringConstants.verifyNow.localized(),
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds placeholder services section when no data
  Widget _buildServicesSectionPlaceholder(
    BuildContext context,
    double screenWidth,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title (static - always visible)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Section title (static)
              Text(
                StringConstants.services.localized(),
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                  fontSize: 18,
                ),
              ),
              // View All button (static)
              GestureDetector(
                onTap: () {
                  final tabs = MainTabsScope.of(context);
                  if (tabs != null) {
                    tabs.onTabSelected(1);
                  } else {
                    AppNavigation.navigateTo(context, RouteConstants.services);
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.filter_list,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      StringConstants.viewAll.localized(),
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 284,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildServiceCardPlaceholder(context),
              const SizedBox(width: 16),
              _buildServiceCardPlaceholder(context),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds a placeholder service card
  Widget _buildServiceCardPlaceholder(BuildContext context) {
    return Container(
      width: 226,
      height: 284,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0E9DB), width: 1),
      ),
      child: const Center(
        child: Icon(Icons.image_outlined, size: 48, color: Colors.grey),
      ),
    );
  }

  /// Builds shimmer for current requests section
  /// Only shows shimmer for data that comes from API, keeps section title visible
  Widget _buildCurrentRequestsShimmer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title (static - always visible)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Section title (static)
              Text(
                StringConstants.currentRequests.localized(),
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                  fontSize: 18,
                ),
              ),
              // View All button (static)
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      StringConstants.viewAll.localized(),
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Request cards shimmer (data from API)
        SizedBox(
          height: 92,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsetsDirectional.only(
                  end: index < 2 ? 8 : 0,
                ),
                child: ShimmerServiceRequestCard(
                  width: MediaQuery.of(context).size.width * 0.65,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Builds shimmer for services section
  /// Only shows shimmer for data that comes from API, keeps section title visible
  Widget _buildServicesShimmer(BuildContext context, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title (static - always visible)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Section title (static)
              Text(
                StringConstants.services.localized(),
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                  fontSize: 18,
                ),
              ),
              // View All button (static)
              GestureDetector(
                onTap: () {
                  final tabs = MainTabsScope.of(context);
                  if (tabs != null) {
                    tabs.onTabSelected(1);
                  } else {
                    AppNavigation.navigateTo(context, RouteConstants.services);
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.filter_list,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      StringConstants.viewAll.localized(),
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Service cards shimmer (data from API)
        SizedBox(
          height: 260,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                  right: index < 2 ? 16 : 0,
                  left: index < 2 ? 16 : 0,
                ),
                child: const ShimmerServiceCard(),
              );
            },
          ),
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

  /// Builds bottom navigation bar (matches SVG: y=784, width=354, height=60, rx=30)
}
