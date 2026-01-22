import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najaz_app/utils/application_localization.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_navigation.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/constants/assets_constants.dart';
import '../../../utils/constants/route_constants.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/custom_search_bar.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeBaseState>(
      builder: (context, state) {
        String? citizenName;
        String? verificationStatus;
        int? unreadCount;

        if (state is FetchHomePageState) {
          citizenName = state.citizenName;
          verificationStatus = state.identityVerificationStatus;
          unreadCount = state.unreadNotificationsCount;
        }

        // Calculate app bar height: top row (48px) + citizen name (24px) + search bar (40px) + padding (16px) + curved bottom (30px)
        final appBarHeight =
            citizenName != null && citizenName.isNotEmpty ? 158.0 : 134.0;

        return PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: ClipPath(
            // clipper: _AppBarCurvedClipper(),
            child: Stack(
              children: [
                Image.asset(AssetConstants.homeAppBarVector),
                Container(
                  decoration: const BoxDecoration(
                    // color:
                    //     AppColors.secondaryColor, // #DFCA9F - beige from Vector.svg
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top row: Welcome (left), Verification Status (center), Notification (right)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Welcome text (left)
                              Text(
                                StringConstants.welcome.localized(),
                                style: AppTextStyles.bodySmall.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textPrimary,
                                ),
                              ),

                              // Verification status (center)
                              Expanded(
                                child: Center(
                                  child: _buildVerificationStatus(
                                    context,
                                    verificationStatus,
                                  ),
                                ),
                              ),

                              // Notification icon (right)
                              _buildNotificationIcon(context, unreadCount),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // Citizen name
                          if (citizenName != null &&
                              citizenName.isNotEmpty) ...[
                            Text(
                              citizenName,
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],

                          // Search bar
                          CustomSearchBar(context: context),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds verification status text
  Widget _buildVerificationStatus(BuildContext context, String? status) {
    if (status == null) return const SizedBox.shrink();

    final normalizedStatus = status.toLowerCase();
    if (normalizedStatus == 'verified' || normalizedStatus == 'true') {
      return const SizedBox.shrink();
    }

    String statusText;
    Color textColor;

    switch (normalizedStatus) {
      case 'verified':
        statusText = StringConstants.verifiedStatus.localized();
        textColor = AppColors.success;
        break;
      case 'pending':
        statusText = StringConstants.pendingVerification.localized();
        textColor = AppColors.warning;
        break;
      case 'rejected':
      case 'failed':
        statusText = StringConstants.verificationFailed.localized();
        textColor = AppColors.error;
        break;
      default:
        statusText = StringConstants.notVerified.localized();
        textColor = AppColors.error;
    }

    return Text(
      statusText,
      style: AppTextStyles.bodySmall.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
  }

  /// Builds notification icon with badge
  Widget _buildNotificationIcon(BuildContext context, int? unreadCount) {
    return GestureDetector(
      onTap: () {
        AppNavigation.navigateTo(context, RouteConstants.notifications);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            Icons.notifications_outlined,
            size: 20,
            color: AppColors.textPrimary,
          ),
          if (unreadCount != null && unreadCount > 0)
            Positioned(
              right: -4,
              top: -4,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFB300),
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                child: Text(
                  unreadCount > 99 ? '99+' : '$unreadCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    // Default height - will be calculated dynamically in build method
    return const Size.fromHeight(158.0);
  }
}
