/*
 * Najaz Mobile App
 * Home State
 * 
 * This file contains BLoC states for the home screen.
 * Follows Bagisto's HomePageState pattern, tailored for Najaz.
 */

import 'package:equatable/equatable.dart';

import '../../../models/home_models/home_page_model.dart';

/// Base state class for home BLoC
abstract class HomeBaseState extends Equatable {
  const HomeBaseState();
  
  @override
  List<Object?> get props => [];
}

/// Home status enum
enum HomeStatus { success, fail }

/// Initial state
class InitialHomeState extends HomeBaseState {
  const InitialHomeState();
}

/// Loading state
class HomeLoadingState extends HomeBaseState {
  const HomeLoadingState();
}

/// Fetch home page state
class FetchHomePageState extends HomeBaseState {
  /// Status of the operation
  final HomeStatus? status;

  /// Error message (if any)
  final String? error;

  /// Success message (if any)
  final String? successMsg;

  /// Home page model
  final HomePageModel? homePageModel;

  /// Citizen full name (convenience accessor)
  String? get citizenName => homePageModel?.citizen?.fullName;

  /// Identity verification status (convenience accessor)
  String? get identityVerificationStatus => homePageModel?.citizen?.identityVerificationStatus;

  /// Unread notifications count (convenience accessor)
  int? get unreadNotificationsCount => homePageModel?.unreadNotificationsCount;

  /// Service requests list (convenience accessor)
  List<ServiceRequestModel>? get serviceRequests => homePageModel?.serviceRequests?.data;

  /// Services list (convenience accessor)
  List<ServiceHomeModel>? get services => homePageModel?.services?.data;

  const FetchHomePageState.success({
    this.homePageModel,
    this.successMsg,
  }) : status = HomeStatus.success,
       error = null;

  const FetchHomePageState.fail({
    this.error,
  }) : status = HomeStatus.fail,
       successMsg = null,
       homePageModel = null;

  @override
  List<Object?> get props => [status, error, successMsg, homePageModel];
}

