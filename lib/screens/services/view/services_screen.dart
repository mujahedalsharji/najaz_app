/*
 * Najaz Mobile App
 * Services Screen View
 * 
 * This file contains the services screen UI with GraphQL query integration.
 * Uses BLoC pattern for state management.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 

import '../../../utils/app_colors.dart';
import '../../../utils/app_text_styles.dart';
import '../../../utils/application_localization.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/shimmer_widget.dart';
import '../../../widgets/show_message.dart';
import '../bloc/services_bloc.dart';
import '../bloc/services_event.dart';
import '../bloc/services_repository.dart';
import '../bloc/services_state.dart';
import '../widgets/services_body.dart';

/// Services Screen
///
/// Displays services screen with:
/// - App bar with centered title and notification icon
/// - Search bar
/// - Categories header
/// - Category filter
/// - Services grid
/// - Bottom navigation bar
class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  /// Builder method for BLoC provider setup
  static Widget builder(BuildContext context) {
    return BlocProvider<ServicesBloc>(
      create:
          (context) =>
              ServicesBloc(repository: ServicesRepositoryImp())
                ..add(const FetchServicesPageEvent()),
      child: const ServicesScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesBloc, ServicesBaseState>(
      builder: (context, state) {
        int? unreadCount;
        if (state is FetchServicesPageState) {
          unreadCount = state.unreadNotificationsCount;
        }

        return Scaffold(
          backgroundColor: AppColors.backgroundLight, // #FCFBF8 from SVG
          appBar: CommonAppBar(
            StringConstants.services.localized(),
            centerTitle: true,
            showNotifications: true,
            unreadNotificationsCount: unreadCount,
           // backgroundColor: AppColors.secondaryColor,
            elevation: 0,
            titleStyle: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          body: ServicesBlocContainer(),
        );
      },
    );
  }
}

/// BLoC Container for Services Screen
///
/// Handles BLoC state listening and UI rendering
class ServicesBlocContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesBloc, ServicesBaseState>(
      listener: (BuildContext context, ServicesBaseState state) {
        if (state is ErrorServicesState) {
          ShowMessage.errorNotification(state.message, context);
        }
      },
      builder: (BuildContext context, ServicesBaseState state) {
        if (state is LoadingServicesState) {
          return const Center(
            child: ShimmerContainer(
              width: 60,
              height: 60,
              borderRadius: 30,
            ),
          );
        }

        if (state is FetchServicesPageState) {
          return ServicesBody(
            categories: state.categories,
            serviceCategories: state.serviceCategories,
            services: state.services,
            selectedCategoryId: state.selectedCategoryId,
            searchQuery: state.searchQuery,
            hasMorePages: state.hasMorePages,
            onRefresh: () {
              context.read<ServicesBloc>().add(
                RefreshServicesDataEvent(
                  categoryId: state.selectedCategoryId,
                  search: state.searchQuery,
                ),
              );
            },
            onLoadMore: () {
              if (state.hasMorePages) {
                context.read<ServicesBloc>().add(
                  LoadMoreServicesEvent(
                    categoryId: state.selectedCategoryId,
                    search: state.searchQuery,
                    currentPage: state.currentPage,
                  ),
                );
              }
            },
            onCategorySelected: (categoryId) {
              context.read<ServicesBloc>().add(
                FilterByCategoryEvent(categoryId: categoryId),
              );
            },
            onSearch: (searchQuery) {
              context.read<ServicesBloc>().add(
                SearchServicesEvent(search: searchQuery),
              );
            },
          );
        }

        if (state is ErrorServicesState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<ServicesBloc>().add(
                      const FetchServicesPageEvent(),
                    );
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        // Initial state - show empty
        return const Center(child: Text('No services available'));
      },
    );
  }
}
