import 'package:flutter/material.dart';
import 'package:najaz_app/utils/application_localization.dart';

import 'app_navigation.dart';
import 'app_text_styles.dart';
import 'constants/route_constants.dart';
import 'constants/string_constants.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.context,
    this.width,
  });

  final BuildContext context;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigation.navigateTo(context, RouteConstants.search);
      },
      child: SizedBox(
        width: width, // null = full width, otherwise fixed width
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFF0E9DB), width: 1),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Icon(Icons.search, color: Colors.grey[600], size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  StringConstants.searchServiceHint.localized(),
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}
