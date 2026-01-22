/*
 * Najaz Mobile App
 * Home Event
 * 
 * This file contains BLoC events for the home screen.
 * Follows Bagisto's HomePageEvent pattern, tailored for Najaz.
 */

import 'package:equatable/equatable.dart';

/// Base event class for home BLoC
abstract class HomeBaseEvent extends Equatable {
  const HomeBaseEvent();
  
  @override
  List<Object?> get props => [];
}

/// Event to fetch home page data (citizen, requests, services)
class FetchHomePageEvent extends HomeBaseEvent {
  /// Page number for service requests (default: 1)
  final int? requestsPage;
  
  /// Limit for service requests (default: 10)
  final int? requestsLimit;
  
  /// Page number for services (default: 1)
  final int? servicesPage;
  
  /// Limit for services (default: 10)
  final int? servicesLimit;

  const FetchHomePageEvent({
    this.requestsPage = 1,
    this.requestsLimit = 10,
    this.servicesPage = 1,
    this.servicesLimit = 10,
  });

  @override
  List<Object?> get props => [requestsPage, requestsLimit, servicesPage, servicesLimit];
}

/// Event to refresh all home data
class RefreshHomeDataEvent extends HomeBaseEvent {
  const RefreshHomeDataEvent();
}

/// Event to search services
class SearchServicesEvent extends HomeBaseEvent {
  /// Search query string
  final String query;

  const SearchServicesEvent({required this.query});

  @override
  List<Object?> get props => [query];
}

