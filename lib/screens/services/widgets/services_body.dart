/*
 * Najaz Mobile App
 * Services Body Widget
 * 
 * This file contains the main body widget for the services screen.
 */

import 'package:flutter/material.dart';

import '../../../models/service_models/service_model.dart';
import '../../../models/service_models/services_page_model.dart';
import '../../../models/service_models/service_categories_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/shimmer_widget.dart';
import '../../../utils/custom_search_bar.dart';
import '../../home/widgets/service_card.dart';
import 'category_filter_chip.dart';

/// Services Body Widget
///
/// Main content widget for the services screen
class ServicesBody extends StatefulWidget {
  /// Categories list (from servicesPage query)
  final List<CategoryModel>? categories;

  /// Service categories list (from serviceCategories query)
  final List<ServiceCategoryModel>? serviceCategories;

  /// Services list
  final List<ServiceModel>? services;

  /// Selected category ID (null means all)
  final int? selectedCategoryId;

  /// Current search query
  final String? searchQuery;

  /// Whether there are more pages to load
  final bool hasMorePages;

  /// On refresh callback
  final VoidCallback? onRefresh;

  /// On load more callback
  final VoidCallback? onLoadMore;

  /// On category selected callback
  final ValueChanged<int?>? onCategorySelected;

  /// On search callback
  final ValueChanged<String>? onSearch;

  const ServicesBody({
    super.key,
    this.categories,
    this.serviceCategories,
    this.services,
    this.selectedCategoryId,
    this.searchQuery,
    this.hasMorePages = false,
    this.onRefresh,
    this.onLoadMore,
    this.onCategorySelected,
    this.onSearch,
  });

  @override
  State<ServicesBody> createState() => _ServicesBodyState();
}

class _ServicesBodyState extends State<ServicesBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _previousTabCount = 0;

  @override
  void initState() {
    super.initState();
    // Tab count: 1 (All) + serviceCategories.length
    final tabCount = 1 + (widget.serviceCategories?.length ?? 0);
    _previousTabCount = tabCount;
    _tabController = TabController(length: tabCount, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void didUpdateWidget(ServicesBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update tab controller if categories changed
    final tabCount = 1 + (widget.serviceCategories?.length ?? 0);
    if (_previousTabCount != tabCount && mounted) {
      _previousTabCount = tabCount;
      _tabController.removeListener(_handleTabChange);
      _tabController.dispose();
      _tabController = TabController(length: tabCount, vsync: this);
      _tabController.addListener(_handleTabChange);
    }
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      setState(() {
        // Update UI when tab changes - this will rebuild the tab indicator
        // No need to call onCategorySelected for any tab since:
        // - "All" tab shows services from widget.services (already available)
        // - Category tabs show services from category.services (already available)
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = widget.serviceCategories ?? [];
    final tabCount = 1 + categories.length;

    if (tabCount <= 1) {
      // No categories, show regular view
      return RefreshIndicator(
        onRefresh: () async {
          widget.onRefresh?.call();
        },
        child: _buildServicesGrid(),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        widget.onRefresh?.call();
      },
      child: Column(
        children: [
          // Search bar below app bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: CustomSearchBar(context: context),
          ),

          // Categories header with tabs
          _buildCategoriesHeader(context),

          // Tab content
          Expanded(
            child: _tabController.length == tabCount
                ? TabBarView(
                    key: ValueKey(tabCount), // Key to force rebuild when tab count changes
                    controller: _tabController,
                    children: List.generate(tabCount, (index) {
                      if (index == 0) {
                        // "All" tab - show all services
                        return _buildServicesGrid();
                      } else {
                        // Category tab - show services for this category
                        final categoryIndex = index - 1;
                        final category = categories[categoryIndex];
                        return _buildCategoryServicesGrid(category);
                      }
                    }),
                  )
                : const SizedBox(), // Show empty while controller is being updated
          ),
        ],
      ),
    );
  }

  /// Builds services grid for all services
  Widget _buildServicesGrid() {
    return CustomScrollView(
      slivers: [
        // Category filter chips
        if (widget.categories != null && widget.categories!.isNotEmpty)
          SliverToBoxAdapter(child: _buildCategoryFilter(context)),

        // Padding between categories header and services grid
        const SliverToBoxAdapter(child: SizedBox(height: 16)),

        // Services grid
        if (widget.services != null && widget.services!.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.87,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                // Load more when near the end
                if (index == widget.services!.length - 2 &&
                    widget.hasMorePages) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    widget.onLoadMore?.call();
                  });
                }

                return SizedBox(
                  width: double.infinity,
                  child: ServiceCard(
                    service: widget.services![index],
                    showCategoryBadge: false,
                  ),
                );
              }, childCount: widget.services!.length),
            ),
          )
        else
          // Empty state
          SliverFillRemaining(
            child: Center(
              child: Text(
                StringConstants.noServicesFound.localized(),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),

        // Loading indicator at bottom for pagination
        if (widget.hasMorePages)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: ShimmerContainer(
                  width: 40,
                  height: 40,
                  borderRadius: 20,
                ),
              ),
            ),
          ),

        // Bottom spacing for bottom nav
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
      ],
    );
  }

  /// Builds services grid for a specific category
  Widget _buildCategoryServicesGrid(ServiceCategoryModel category) {
    final categoryServices = category.services ?? [];

    return CustomScrollView(
      slivers: [
        // Padding
        const SliverToBoxAdapter(child: SizedBox(height: 16)),

        // Services grid
        if (categoryServices.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.87,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                // Convert CategoryServiceModel to ServiceModel for ServiceCard
                final categoryService = categoryServices[index];
                final serviceModel = ServiceModel(
                  id: categoryService.id,
                  name: categoryService.name,
                  baseImage: categoryService.baseImage,
                );

                return SizedBox(
                  width: double.infinity,
                  child: ServiceCard(
                    service: serviceModel,
                    showCategoryBadge: false,
                  ),
                );
              }, childCount: categoryServices.length),
            ),
          )
        else
          // Empty state
          SliverFillRemaining(
            child: Center(
              child: Text(
                StringConstants.noServicesFound.localized(),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),

        // Bottom spacing for bottom nav
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
      ],
    );
  }

  /// Builds categories header with switching tabs using TabController
  Widget _buildCategoriesHeader(BuildContext context) {
    final categories = widget.serviceCategories ?? [];
    final tabCount = 1 + categories.length;

    if (tabCount <= 1) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        // Custom TabBar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(tabCount, (index) {
              String tabText;
              if (index == 0) {
                tabText = StringConstants.all.localized();
              } else {
                final category = categories[index - 1];
                tabText = category.name ?? '';
              }

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (index > 0) const SizedBox(width: 24),
                  GestureDetector(
                    onTap: () {
                      _tabController.animateTo(index);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          tabText,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: _tabController.index == index
                                ? AppColors.brandAccent
                                : AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Colored underline for active tab
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: 2,
                          width: _tabController.index == index ? 80 : 0,
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
        // Colored line separator
        Container(
          height: 1,
          color: AppColors.primaryColor.withValues(alpha: 0.2),
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
      ],
    );
  }

  /// Builds category filter chips
  Widget _buildCategoryFilter(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (widget.categories?.length ?? 0) + 1, // +1 for "All" option
        itemBuilder: (context, index) {
          if (index == 0) {
            // "All" option
            return CategoryFilterChip(
              label: StringConstants.all.localized(),
              isSelected: widget.selectedCategoryId == null,
              onSelected: () => widget.onCategorySelected?.call(null),
            );
          }

          final category = widget.categories![index - 1];
          final categoryId = int.tryParse(category.id ?? '');
          return CategoryFilterChip(
            label: category.name ?? '',
            isSelected: widget.selectedCategoryId == categoryId,
            onSelected: () => widget.onCategorySelected?.call(categoryId),
          );
        },
      ),
    );
  }
}
