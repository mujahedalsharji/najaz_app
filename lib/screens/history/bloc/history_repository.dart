/*
 * Najaz Mobile App
 * History Repository
 */

import 'package:flutter/foundation.dart';

import '../../../models/history_models/my_service_requests_model.dart';
import '../../../services/api_client.dart';
import '../../../services/graphql_queries/my_service_requests_query.dart';
import '../../../services/graphql_queries/unread_notifications_count_query.dart';

abstract class HistoryRepository {
  Future<MyServiceRequestsModel?> fetchMyServiceRequests({String? status});
  Future<int?> fetchUnreadNotificationsCount();
}

class HistoryRepositoryImp implements HistoryRepository {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<MyServiceRequestsModel?> fetchMyServiceRequests({
    String? status,
  }) async {
    MyServiceRequestsModel? responseModel;
    try {
      final normalizedStatus = _toServiceRequestStatus(status);
      final variables = <String, dynamic>{
        if (normalizedStatus != null) 'status': normalizedStatus,
      };
      responseModel = await _apiClient.query<MyServiceRequestsModel>(
        document: MyServiceRequestsQuery.myServiceRequests,
        variables: variables,
        operationName: 'myServiceRequests',
        parser: (json) => MyServiceRequestsModel.fromJson(json),
      );
    } catch (error, stacktrace) {
      debugPrint("Error in HistoryRepository.fetchMyServiceRequests --> $error");
      debugPrint("StackTrace --> $stacktrace");
    }
    return responseModel;
  }

  String? _toServiceRequestStatus(String? status) {
    if (status == null || status.trim().isEmpty) return null;
    switch (status) {
      case 'canceled':
        return 'CANCELLED';
      case 'needs_revision':
        return 'NEEDS_REVISION';
      case 'in_progress':
        return 'IN_PROGRESS';
      default:
        return status.toUpperCase();
    }
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
        "Error in HistoryRepository.fetchUnreadNotificationsCount --> $error",
      );
      debugPrint("StackTrace --> $stacktrace");
    }
    return unreadCount;
  }
}

