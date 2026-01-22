/*
 * Najaz Mobile App
 * History Events
 */

import 'package:equatable/equatable.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object?> get props => [];
}

class FetchHistoryEvent extends HistoryEvent {
  final String? status;

  const FetchHistoryEvent({this.status});

  @override
  List<Object?> get props => [status];
}

class RefreshHistoryEvent extends HistoryEvent {
  const RefreshHistoryEvent();
}

