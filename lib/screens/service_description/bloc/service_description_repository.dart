/*
 * Najaz Mobile App
 * Service Description Repository
 */

import 'package:flutter/foundation.dart';

import '../../../models/service_models/service_form_model.dart';
import '../../../services/api_client.dart';
import '../../../services/graphql_queries/service_form_query.dart';
import '../../../services/graphql_queries/unread_notifications_count_query.dart';

abstract class ServiceDescriptionRepository {
  Future<ServiceFormModel?> fetchServiceForm({required String serviceId});
  Future<int?> fetchUnreadNotificationsCount();
}

class ServiceDescriptionRepositoryImp implements ServiceDescriptionRepository {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<ServiceFormModel?> fetchServiceForm({
    required String serviceId,
  }) async {
    ServiceFormModel? model;
    try {
      model = await _apiClient.query<ServiceFormModel>(
        document: ServiceFormQuery.getServiceForm,
        variables: {'id': serviceId},
        parser:
            (json) => ServiceFormModel.fromJson(
              (json['citizenService'] as Map<String, dynamic>?) ?? {},
            ),
      );
    } catch (error, stacktrace) {
      debugPrint(
        "Error in ServiceDescriptionRepository.fetchServiceForm --> $error",
      );
      debugPrint("StackTrace --> $stacktrace");
    }
    return model;
  }

  @override
  Future<int?> fetchUnreadNotificationsCount() async {
    int? unreadCount;
    try {
      unreadCount = await _apiClient.query<int?>(
        document: UnreadNotificationsCountQuery.unreadNotificationsCount,
        parser: (json) => (json['unreadNotificationsCount'] as num?)?.toInt(),
      );
    } catch (error, stacktrace) {
      debugPrint(
        "Error in ServiceDescriptionRepository.fetchUnreadNotificationsCount "
        "--> $error",
      );
      debugPrint("StackTrace --> $stacktrace");
    }
    return unreadCount;
  }
}

