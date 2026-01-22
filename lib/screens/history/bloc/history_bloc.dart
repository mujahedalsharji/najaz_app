/*
 * Najaz Mobile App
 * History BLoC
 */

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/history_models/my_service_requests_model.dart';
import 'history_event.dart';
import 'history_repository.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository repository;

  HistoryBloc({required this.repository}) : super(const HistoryInitial()) {
    on<FetchHistoryEvent>(_onFetchHistory);
    on<RefreshHistoryEvent>(_onRefreshHistory);
  }

  Future<void> _onFetchHistory(
    FetchHistoryEvent event,
    Emitter<HistoryState> emit,
  ) async {
    final currentState = state;
    if (currentState is HistoryLoaded) {
      emit(currentState.copyWith(isLoading: true, selectedStatus: event.status));
    } else {
      emit(const HistoryLoading());
    }

    try {
      final results = await Future.wait([
        repository.fetchMyServiceRequests(status: event.status),
        repository.fetchUnreadNotificationsCount(),
      ]);

      final requestsModel = results[0] as MyServiceRequestsModel?;
      final unreadCount = results[1] as int?;

      if (requestsModel != null && requestsModel.isSuccess) {
        final hasMorePages =
            requestsModel.paginatorInfo?.hasMorePages ?? false;
        emit(HistoryLoaded(
          requests: requestsModel.data,
          hasMorePages: hasMorePages,
          unreadNotificationsCount: unreadCount,
          selectedStatus: event.status,
          isLoading: false,
        ));
      } else {
        emit(HistoryError(
          message: requestsModel?.message ??
              requestsModel?.graphqlErrors ??
              'Failed to fetch requests',
        ));
      }
    } catch (error) {
      emit(HistoryError(message: error.toString()));
    }
  }

  Future<void> _onRefreshHistory(
    RefreshHistoryEvent event,
    Emitter<HistoryState> emit,
  ) async {
    final currentState = state;
    int? existingUnreadCount;
    String? selectedStatus;
    if (currentState is HistoryLoaded) {
      existingUnreadCount = currentState.unreadNotificationsCount;
      selectedStatus = currentState.selectedStatus;
      emit(currentState.copyWith(isLoading: true));
    }

    try {
      final requestsModel = await repository.fetchMyServiceRequests(
        status: selectedStatus,
      );
      final unreadCount = await repository.fetchUnreadNotificationsCount();

      if (requestsModel != null && requestsModel.isSuccess) {
        emit(HistoryLoaded(
          requests: requestsModel.data,
          hasMorePages: requestsModel.paginatorInfo?.hasMorePages ?? false,
          unreadNotificationsCount: unreadCount ?? existingUnreadCount,
          selectedStatus: selectedStatus,
          isLoading: false,
        ));
      } else {
        emit(HistoryError(
          message: requestsModel?.message ??
              requestsModel?.graphqlErrors ??
              'Failed to refresh requests',
        ));
      }
    } catch (error) {
      emit(HistoryError(message: error.toString()));
    }
  }
}

