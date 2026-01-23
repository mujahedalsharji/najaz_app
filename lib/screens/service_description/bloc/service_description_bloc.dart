/*
 * Najaz Mobile App
 * Service Description BLoC
 */

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/service_models/service_form_model.dart';
import 'service_description_event.dart';
import 'service_description_repository.dart';
import 'service_description_state.dart';

class ServiceDescriptionBloc
    extends Bloc<ServiceDescriptionEvent, ServiceDescriptionState> {
  final ServiceDescriptionRepository repository;

  ServiceDescriptionBloc({required this.repository})
      : super(const ServiceDescriptionInitial()) {
    on<FetchServiceDescriptionEvent>(_mapFetchServiceDescriptionEventToState);
  }

  Future<void> _mapFetchServiceDescriptionEventToState(
    FetchServiceDescriptionEvent event,
    Emitter<ServiceDescriptionState> emit,
  ) async {
    emit(const ServiceDescriptionLoading());

    try {
      if (event.serviceId == null || event.serviceId!.trim().isEmpty) {
        emit(
          const ServiceDescriptionError(
            message: 'Missing service id',
          ),
        );
        return;
      }

      final futures = await Future.wait([
        repository.fetchServiceForm(serviceId: event.serviceId!.trim()),
        repository.fetchUnreadNotificationsCount(),
      ]);

      final serviceForm = futures[0] as ServiceFormModel?;
      final unreadCount = futures[1] as int?;

      emit(
        ServiceDescriptionLoaded(
          serviceForm: serviceForm?.id != null ? serviceForm : null,
          unreadNotificationsCount: unreadCount,
        ),
      );
    } catch (error, stacktrace) {
      debugPrint(
        "Error in ServiceDescriptionBloc.fetch --> $error",
      );
      debugPrint("StackTrace --> $stacktrace");
      emit(ServiceDescriptionError(message: error.toString()));
    }
  }
}

