/*
 * Najaz Mobile App
 * History App Bar
 */

import 'package:flutter/material.dart';

import '../../../utils/app_text_styles.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/custom_search_bar.dart';
import '../../../widgets/common_app_bar.dart';

class HistoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int? unreadNotificationsCount;

  const HistoryAppBar({super.key, this.unreadNotificationsCount});

  @override
  Size get preferredSize {
    final appBarHeight = AppBar().preferredSize.height;
    return Size.fromHeight(appBarHeight + 56);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonAppBar(
          StringConstants.history.localized(),
          centerTitle: true,
          showNotifications: true,
          unreadNotificationsCount: unreadNotificationsCount,
          //  backgroundColor: AppColors.secondaryColor,
          elevation: 0,
          titleStyle: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          // color: AppColors.secondaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: CustomSearchBar(context: context),
        ),
      ],
    );
  }
}
