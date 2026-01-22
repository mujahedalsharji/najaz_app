/*
 * Najaz Mobile App
 * Services BLoC
 * 
 * This file contains the BLoC for services screen business logic.
 * Follows Bagisto's pattern, tailored for Najaz.
 */

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/service_models/services_page_model.dart';
import '../../../models/service_models/service_model.dart';
import '../../../models/service_models/service_categories_model.dart';
import 'services_event.dart';
import 'services_repository.dart';
import 'services_state.dart';

/// BLoC for services screen
class ServicesBloc extends Bloc<ServicesBaseEvent, ServicesBaseState> {
  /// Repository for services operations
  final ServicesRepository repository;

  ServicesBloc({required this.repository})
      : super(const InitialServicesState()) {
    on<FetchServicesPageEvent>(_mapFetchServicesPageEventToState);
    on<RefreshServicesDataEvent>(_mapRefreshServicesDataEventToState);
    on<LoadMoreServicesEvent>(_mapLoadMoreServicesEventToState);
    on<FilterByCategoryEvent>(_mapFilterByCategoryEventToState);
    on<SearchServicesEvent>(_mapSearchServicesEventToState);
    on<FetchServiceCategoriesEvent>(_mapFetchServiceCategoriesEventToState);
  }

  /// Handles FetchServicesPageEvent
  Future<void> _mapFetchServicesPageEventToState(
    FetchServicesPageEvent event,
    Emitter<ServicesBaseState> emit,
  ) async {
    emit(const LoadingServicesState());

    try {
      // Fetch both services page data and service categories
      final futures = await Future.wait([
        repository.fetchServicesPage(
          search: event.search,
          categoryId: event.categoryId,
          page: event.page,
          limit: event.limit,
        ),
        repository.fetchServiceCategories(
          page: 1,
          limit: 2,
          parentId: 1, // Fetch categories with parentId = 1
        ),
        repository.fetchUnreadNotificationsCount(),
      ]);

      final servicesPageData = futures[0] as ServicesPageModel?;
      final serviceCategoriesData = futures[1] as ServiceCategoriesModel?;
      final unreadCount = futures[2] as int?;

      if (servicesPageData != null &&
          servicesPageData.success == true &&
          servicesPageData.status == true) {
        final total = servicesPageData.services?.paginatorInfo?.total ?? 0;
        final currentPage = event.page ?? 1;
        final limit = event.limit ?? 10;
        final hasMorePages = (currentPage * limit) < total;
        
        emit(FetchServicesPageState(
          servicesPageData: servicesPageData,
          categories: servicesPageData.categories,
          serviceCategories: serviceCategoriesData?.data,
          services: servicesPageData.services?.data,
          currentPage: currentPage,
          hasMorePages: hasMorePages,
          selectedCategoryId: event.categoryId,
          searchQuery: event.search,
          unreadNotificationsCount: unreadCount,
        ));
      } else {
        emit(ErrorServicesState(
          message: servicesPageData?.message ??
              servicesPageData?.graphqlErrors ??
              'Failed to fetch services',
        ));
      }
    } catch (error) {
      emit(ErrorServicesState(message: error.toString()));
    }
  }

  /// Handles FetchServiceCategoriesEvent
  Future<void> _mapFetchServiceCategoriesEventToState(
    FetchServiceCategoriesEvent event,
    Emitter<ServicesBaseState> emit,
  ) async {
    final currentState = state;
    if (currentState is! FetchServicesPageState) {
      emit(const LoadingServicesState());
    }

    try {
      final serviceCategoriesData = await repository.fetchServiceCategories(
        page: event.page,
        limit: event.limit,
        parentId: event.parentId,
      );

      if (serviceCategoriesData != null &&
          serviceCategoriesData.success == true &&
          serviceCategoriesData.status == true) {
        if (currentState is FetchServicesPageState) {
          emit(currentState.copyWith(
            serviceCategories: serviceCategoriesData.data,
          ));
        } else {
          emit(FetchServicesPageState(
            serviceCategories: serviceCategoriesData.data,
          ));
        }
      } else {
        if (currentState is! FetchServicesPageState) {
          emit(ErrorServicesState(
            message: serviceCategoriesData?.message ??
                serviceCategoriesData?.graphqlErrors ??
                'Failed to fetch categories',
          ));
        }
      }
    } catch (error) {
      if (currentState is! FetchServicesPageState) {
        emit(ErrorServicesState(message: error.toString()));
      }
    }
  }

  /// Handles RefreshServicesDataEvent
  Future<void> _mapRefreshServicesDataEventToState(
    RefreshServicesDataEvent event,
    Emitter<ServicesBaseState> emit,
  ) async {
    // Keep current state while refreshing
    final currentState = state;
    int? existingUnreadCount;
    if (currentState is FetchServicesPageState) {
      existingUnreadCount = currentState.unreadNotificationsCount;
      emit(currentState.copyWith());
    }

    try {
      final servicesPageData = await repository.fetchServicesPage(
        search: event.search,
        categoryId: event.categoryId,
        page: event.page,
        limit: event.limit,
      );
      final unreadCount = await repository.fetchUnreadNotificationsCount();

      if (servicesPageData != null &&
          servicesPageData.success == true &&
          servicesPageData.status == true) {
        final total = servicesPageData.services?.paginatorInfo?.total ?? 0;
        final currentPage = event.page ?? 1;
        final limit = event.limit ?? 10;
        final hasMorePages = (currentPage * limit) < total;
        
        emit(FetchServicesPageState(
          servicesPageData: servicesPageData,
          categories: servicesPageData.categories,
          services: servicesPageData.services?.data,
          currentPage: currentPage,
          hasMorePages: hasMorePages,
          selectedCategoryId: event.categoryId,
          searchQuery: event.search,
          unreadNotificationsCount: unreadCount ?? existingUnreadCount,
        ));
      } else {
        emit(ErrorServicesState(
          message: servicesPageData?.message ??
              servicesPageData?.graphqlErrors ??
              'Failed to refresh services',
        ));
      }
    } catch (error) {
      emit(ErrorServicesState(message: error.toString()));
    }
  }

  /// Handles LoadMoreServicesEvent
  Future<void> _mapLoadMoreServicesEventToState(
    LoadMoreServicesEvent event,
    Emitter<ServicesBaseState> emit,
  ) async {
    final currentState = state;
    if (currentState is! FetchServicesPageState) return;

    // Don't load more if no more pages
    if (!currentState.hasMorePages) return;

    try {
      final nextPage = event.currentPage + 1;
      final servicesPageData = await repository.fetchServicesPage(
        search: event.search,
        categoryId: event.categoryId,
        page: nextPage,
        limit: event.limit,
      );

      if (servicesPageData != null &&
          servicesPageData.success == true &&
          servicesPageData.status == true) {
        // Append new services to existing list
        final existingServices = currentState.services ?? [];
        final newServices = servicesPageData.services?.data ?? [];
        final allServices = [...existingServices, ...newServices];
        
        final total = servicesPageData.services?.paginatorInfo?.total ?? 0;
        final limit = event.limit ?? 10;
        final hasMorePages = (nextPage * limit) < total;

        emit(currentState.copyWith(
          services: allServices,
          currentPage: nextPage,
          hasMorePages: hasMorePages,
        ));
      }
    } catch (error) {
      // On error, just keep current state (don't emit error to avoid disrupting UI)
      debugPrint('Error loading more services: $error');
    }
  }

  /// Handles FilterByCategoryEvent
  Future<void> _mapFilterByCategoryEventToState(
    FilterByCategoryEvent event,
    Emitter<ServicesBaseState> emit,
  ) async {
    emit(const LoadingServicesState());

    try {
      final servicesPageData = await repository.fetchServicesPage(
        categoryId: event.categoryId,
        page: 1,
        limit: 10,
      );
      final unreadCount = await repository.fetchUnreadNotificationsCount();

      if (servicesPageData != null &&
          servicesPageData.success == true &&
          servicesPageData.status == true) {
        final total = servicesPageData.services?.paginatorInfo?.total ?? 0;
        final limit = 10;
        final hasMorePages = limit < total;
        
        emit(FetchServicesPageState(
          servicesPageData: servicesPageData,
          categories: servicesPageData.categories,
          services: servicesPageData.services?.data,
          currentPage: 1,
          hasMorePages: hasMorePages,
          selectedCategoryId: event.categoryId,
          unreadNotificationsCount: unreadCount,
        ));
      } else {
        emit(ErrorServicesState(
          message: servicesPageData?.message ??
              servicesPageData?.graphqlErrors ??
              'Failed to filter services',
        ));
      }
    } catch (error) {
      emit(ErrorServicesState(message: error.toString()));
    }
  }

  /// Handles SearchServicesEvent
  Future<void> _mapSearchServicesEventToState(
    SearchServicesEvent event,
    Emitter<ServicesBaseState> emit,
  ) async {
    emit(const LoadingServicesState());

    try {
      final servicesPageData = await repository.fetchServicesPage(
        search: event.search,
        page: 1,
        limit: 10,
      );
      final unreadCount = await repository.fetchUnreadNotificationsCount();

      if (servicesPageData != null &&
          servicesPageData.success == true &&
          servicesPageData.status == true) {
        final total = servicesPageData.services?.paginatorInfo?.total ?? 0;
        final limit = 10;
        final hasMorePages = limit < total;
        
        emit(FetchServicesPageState(
          servicesPageData: servicesPageData,
          categories: servicesPageData.categories,
          services: servicesPageData.services?.data,
          currentPage: 1,
          hasMorePages: hasMorePages,
          searchQuery: event.search,
          unreadNotificationsCount: unreadCount,
        ));
      } else {
        emit(ErrorServicesState(
          message: servicesPageData?.message ??
              servicesPageData?.graphqlErrors ??
              'Failed to search services',
        ));
      }
    } catch (error) {
      emit(ErrorServicesState(message: error.toString()));
    }
  }
}

