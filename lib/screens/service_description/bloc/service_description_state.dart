/*
 * Najaz Mobile App
 * Service Description States
 */

import 'package:equatable/equatable.dart';

import '../../../models/service_models/service_form_model.dart';

abstract class ServiceDescriptionState extends Equatable {
  const ServiceDescriptionState();

  @override
  List<Object?> get props => [];
}

class ServiceDescriptionInitial extends ServiceDescriptionState {
  const ServiceDescriptionInitial();
}

class ServiceDescriptionLoading extends ServiceDescriptionState {
  const ServiceDescriptionLoading();
}

class ServiceDescriptionLoaded extends ServiceDescriptionState {
  final ServiceFormModel? serviceForm;
  final int? unreadNotificationsCount;

  const ServiceDescriptionLoaded({
    this.serviceForm,
    this.unreadNotificationsCount,
  });

  @override
  List<Object?> get props => [serviceForm, unreadNotificationsCount];
}

class ServiceDescriptionError extends ServiceDescriptionState {
  final String message;

  const ServiceDescriptionError({required this.message});

  @override
  List<Object?> get props => [message];
}

