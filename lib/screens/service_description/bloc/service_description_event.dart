/*
 * Najaz Mobile App
 * Service Description Events
 */

import 'package:equatable/equatable.dart';

abstract class ServiceDescriptionEvent extends Equatable {
  const ServiceDescriptionEvent();

  @override
  List<Object?> get props => [];
}

class FetchServiceDescriptionEvent extends ServiceDescriptionEvent {
  final String? serviceId;

  const FetchServiceDescriptionEvent({this.serviceId});

  @override
  List<Object?> get props => [serviceId];
}

