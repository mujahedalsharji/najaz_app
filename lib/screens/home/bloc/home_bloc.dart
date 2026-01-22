/*
 * Najaz Mobile App
 * Home BLoC
 * 
 * This file contains the BLoC for home screen business logic.
 * Follows Bagisto's HomePageBloc pattern, tailored for Najaz.
 */

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/home_models/home_page_model.dart';
import 'home_event.dart';
import 'home_repository.dart';
import 'home_state.dart';

/// BLoC for home screen
class HomeBloc extends Bloc<HomeBaseEvent, HomeBaseState> {
  /// Repository for home operations
  final HomeRepository repository;

  HomeBloc({required this.repository}) : super(const InitialHomeState()) {
    on<FetchHomePageEvent>(_mapFetchHomePageEventToState);
    on<RefreshHomeDataEvent>(_mapRefreshHomeDataEventToState);
    on<SearchServicesEvent>(_mapSearchServicesEventToState);
  }

  /// Handles FetchHomePageEvent
  Future<void> _mapFetchHomePageEventToState(
    FetchHomePageEvent event,
    Emitter<HomeBaseState> emit,
  ) async {
    emit(const HomeLoadingState());

    try {
      final homePageModel = await repository.fetchHomePage(
        requestsPage: event.requestsPage,
        requestsLimit: event.requestsLimit,
        servicesPage: event.servicesPage,
        servicesLimit: event.servicesLimit,
      );

      if (homePageModel != null && homePageModel.isSuccess == true) {
        emit(
          FetchHomePageState.success(
            homePageModel: homePageModel,
            successMsg: homePageModel.message,
          ),
        );
      } else {
        emit(
          const FetchHomePageState.fail(
            error: 'Failed to fetch home page data',
          ),
        );
      }
    } catch (e) {
      emit(
        FetchHomePageState.fail(
          error: e.toString(),
        ),
      );
    }
  }

  /// Handles RefreshHomeDataEvent
  Future<void> _mapRefreshHomeDataEventToState(
    RefreshHomeDataEvent event,
    Emitter<HomeBaseState> emit,
  ) async {
    // Refresh all data by fetching home page again
    add(const FetchHomePageEvent());
  }

  /// Handles SearchServicesEvent
  Future<void> _mapSearchServicesEventToState(
    SearchServicesEvent event,
    Emitter<HomeBaseState> emit,
  ) async {
    // Navigate to search screen with query
    // This can be handled in the UI layer
    // For now, just keep the current state
  }
}

