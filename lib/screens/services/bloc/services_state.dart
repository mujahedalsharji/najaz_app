/*
 * Najaz Mobile App
 * Services State
 * 
 * This file contains states for services screen BLoC.
 * Follows Bagisto's pattern, tailored for Najaz.
 */

import 'package:equatable/equatable.dart';

import '../../../models/service_models/services_page_model.dart';
import '../../../models/service_models/service_model.dart';
import '../../../models/service_models/service_categories_model.dart';

/// Base state for services screen
abstract class ServicesBaseState extends Equatable {
  const ServicesBaseState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class InitialServicesState extends ServicesBaseState {
  const InitialServicesState();
}

/// Loading state
class LoadingServicesState extends ServicesBaseState {
  const LoadingServicesState();
}

/// Success state with services page data
class FetchServicesPageState extends ServicesBaseState {
  /// Services page data
  final ServicesPageModel? servicesPageData;

  /// Categories list (from servicesPage query)
  final List<CategoryModel>? categories;

  /// Service categories list (from serviceCategories query)
  final List<ServiceCategoryModel>? serviceCategories;

  /// Services list
  final List<ServiceModel>? services;

  /// Current page number
  final int currentPage;

  /// Whether there are more pages
  final bool hasMorePages;

  /// Selected category ID (null means all categories)
  final int? selectedCategoryId;

  /// Current search query
  final String? searchQuery;

  /// Unread notifications count
  final int? unreadNotificationsCount;

  const FetchServicesPageState({
    this.servicesPageData,
    this.categories,
    this.serviceCategories,
    this.services,
    this.currentPage = 1,
    this.hasMorePages = false,
    this.selectedCategoryId,
    this.searchQuery,
    this.unreadNotificationsCount,
  });

  /// Creates a copy with updated values
  FetchServicesPageState copyWith({
    ServicesPageModel? servicesPageData,
    List<CategoryModel>? categories,
    List<ServiceCategoryModel>? serviceCategories,
    List<ServiceModel>? services,
    int? currentPage,
    bool? hasMorePages,
    int? selectedCategoryId,
    String? searchQuery,
    int? unreadNotificationsCount,
  }) {
    return FetchServicesPageState(
      servicesPageData: servicesPageData ?? this.servicesPageData,
      categories: categories ?? this.categories,
      serviceCategories: serviceCategories ?? this.serviceCategories,
      services: services ?? this.services,
      currentPage: currentPage ?? this.currentPage,
      hasMorePages: hasMorePages ?? this.hasMorePages,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      searchQuery: searchQuery ?? this.searchQuery,
      unreadNotificationsCount:
          unreadNotificationsCount ?? this.unreadNotificationsCount,
    );
  }

  @override
  List<Object?> get props => [
        servicesPageData,
        categories,
        serviceCategories,
        services,
        currentPage,
        hasMorePages,
        selectedCategoryId,
        searchQuery,
        unreadNotificationsCount,
      ];
}

/// Error state
class ErrorServicesState extends ServicesBaseState {
  /// Error message
  final String message;

  const ErrorServicesState({required this.message});

  @override
  List<Object?> get props => [message];
}

