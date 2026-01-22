/*
 * Najaz Mobile App
 * History State
 */

import 'package:equatable/equatable.dart';

import '../../../models/history_models/my_service_requests_model.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object?> get props => [];
}

class HistoryInitial extends HistoryState {
  const HistoryInitial();
}

class HistoryLoading extends HistoryState {
  const HistoryLoading();
}

class HistoryLoaded extends HistoryState {
  final List<MyServiceRequestModel>? requests;
  final bool hasMorePages;
  final int? unreadNotificationsCount;
  final String? selectedStatus;
  final bool? isLoading;

  const HistoryLoaded({
    this.requests,
    this.hasMorePages = false,
    this.unreadNotificationsCount,
    this.selectedStatus,
    this.isLoading,
  });

  HistoryLoaded copyWith({
    List<MyServiceRequestModel>? requests,
    bool? hasMorePages,
    int? unreadNotificationsCount,
    String? selectedStatus,
    bool? isLoading,
  }) {
    return HistoryLoaded(
      requests: requests ?? this.requests,
      hasMorePages: hasMorePages ?? this.hasMorePages,
      unreadNotificationsCount:
          unreadNotificationsCount ?? this.unreadNotificationsCount,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        requests,
        hasMorePages,
        unreadNotificationsCount,
        selectedStatus,
        isLoading,
      ];

  bool get isLoadingValue => isLoading ?? false;
}

class HistoryError extends HistoryState {
  final String message;

  const HistoryError({required this.message});

  @override
  List<Object?> get props => [message];
}

