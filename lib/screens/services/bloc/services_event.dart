/*
 * Najaz Mobile App
 * Services Event
 * 
 * This file contains events for services screen BLoC.
 * Follows Bagisto's pattern, tailored for Najaz.
 */

import 'package:equatable/equatable.dart';

/// Base event for services screen
abstract class ServicesBaseEvent extends Equatable {
  const ServicesBaseEvent();

  @override
  List<Object?> get props => [];
}

/// Event to fetch services page data
class FetchServicesPageEvent extends ServicesBaseEvent {
  /// Search query string
  final String? search;

  /// Category ID to filter by
  final int? categoryId;

  /// Page number for pagination
  final int page;

  /// Limit per page
  final int limit;

  const FetchServicesPageEvent({
    this.search,
    this.categoryId,
    this.page = 1,
    this.limit = 10,
  });

  @override
  List<Object?> get props => [search, categoryId, page, limit];
}

/// Event to refresh services data
class RefreshServicesDataEvent extends ServicesBaseEvent {
  /// Search query string
  final String? search;

  /// Category ID to filter by
  final int? categoryId;

  /// Page number for pagination
  final int page;

  /// Limit per page
  final int limit;

  const RefreshServicesDataEvent({
    this.search,
    this.categoryId,
    this.page = 1,
    this.limit = 10,
  });

  @override
  List<Object?> get props => [search, categoryId, page, limit];
}

/// Event to load more services (pagination)
class LoadMoreServicesEvent extends ServicesBaseEvent {
  /// Search query string
  final String? search;

  /// Category ID to filter by
  final int? categoryId;

  /// Current page number
  final int currentPage;

  /// Limit per page
  final int limit;

  const LoadMoreServicesEvent({
    this.search,
    this.categoryId,
    this.currentPage = 1,
    this.limit = 10,
  });

  @override
  List<Object?> get props => [search, categoryId, currentPage, limit];
}

/// Event to filter services by category
class FilterByCategoryEvent extends ServicesBaseEvent {
  /// Category ID to filter by (null to show all)
  final int? categoryId;

  const FilterByCategoryEvent({this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}

/// Event to search services
class SearchServicesEvent extends ServicesBaseEvent {
  /// Search query string
  final String search;

  const SearchServicesEvent({required this.search});

  @override
  List<Object?> get props => [search];
}

/// Event to fetch service categories
class FetchServiceCategoriesEvent extends ServicesBaseEvent {
  /// Page number for pagination
  final int page;

  /// Limit per page
  final int limit;

  /// Parent category ID (to fetch child categories)
  final int? parentId;

  const FetchServiceCategoriesEvent({
    this.page = 1,
    this.limit = 2,
    this.parentId,
  });

  @override
  List<Object?> get props => [page, limit, parentId];
}

