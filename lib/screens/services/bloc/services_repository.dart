/*
 * Najaz Mobile App
 * Services Repository
 * 
 * This file contains the repository for services screen API calls.
 * Follows Bagisto's pattern, tailored for Najaz.
 */

import 'package:flutter/foundation.dart';

import '../../../models/service_models/services_page_model.dart';
import '../../../models/service_models/service_categories_model.dart';
import '../../../services/api_client.dart';
import '../../../services/graphql_queries/services_page_query.dart';
import '../../../services/graphql_queries/service_categories_query.dart';
import '../../../services/graphql_queries/unread_notifications_count_query.dart';

/// Repository interface for services operations
abstract class ServicesRepository {
  /// Fetches services page data (categories and services)
  Future<ServicesPageModel?> fetchServicesPage({
    String? search,
    int? categoryId,
    int? page,
    int? limit,
  });

  /// Fetches service categories with their services
  Future<ServiceCategoriesModel?> fetchServiceCategories({
    int? page,
    int? limit,
    int? parentId,
  });

  /// Fetches unread notifications count
  Future<int?> fetchUnreadNotificationsCount();
}

/// Implementation of ServicesRepository
class ServicesRepositoryImp implements ServicesRepository {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<ServicesPageModel?> fetchServicesPage({
    String? search,
    int? categoryId,
    int? page,
    int? limit,
  }) async {
    ServicesPageModel? servicesPageResponseModel;
    try {
      final variables = <String, dynamic>{
        if (search != null && search.isNotEmpty) 'search': search,
        if (categoryId != null) 'categoryId': categoryId,
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
      };

      servicesPageResponseModel = await _apiClient.query<ServicesPageModel>(
        document: ServicesPageQuery.servicesPage,
        variables: variables,
        operationName: 'servicesPage',
        parser: (json) => ServicesPageModel.fromJson(json),
      );
    } catch (error, stacktrace) {
      debugPrint("Error in ServicesRepository.fetchServicesPage --> $error");
      debugPrint("StackTrace --> $stacktrace");
    }
    return servicesPageResponseModel;
  }

  @override
  Future<ServiceCategoriesModel?> fetchServiceCategories({
    int? page,
    int? limit,
    int? parentId,
  }) async {
    ServiceCategoriesModel? serviceCategoriesResponseModel;
    try {
      final variables = <String, dynamic>{
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (parentId != null) 'parentId': parentId,
      };

      serviceCategoriesResponseModel = await _apiClient.query<ServiceCategoriesModel>(
        document: ServiceCategoriesQuery.serviceCategories,
        variables: variables,
        operationName: 'serviceCategories',
        parser: (json) => ServiceCategoriesModel.fromJson(json),
      );
    } catch (error, stacktrace) {
      debugPrint("Error in ServicesRepository.fetchServiceCategories --> $error");
      debugPrint("StackTrace --> $stacktrace");
    }
    return serviceCategoriesResponseModel;
  }

  @override
  Future<int?> fetchUnreadNotificationsCount() async {
    int? unreadCount;
    try {
      unreadCount = await _apiClient.query<int?>(
        document: UnreadNotificationsCountQuery.unreadNotificationsCount,
        parser:
            (json) =>
                (json['unreadNotificationsCount'] as num?)?.toInt(),
      );
    } catch (error, stacktrace) {
      debugPrint(
        "Error in ServicesRepository.fetchUnreadNotificationsCount --> $error",
      );
      debugPrint("StackTrace --> $stacktrace");
    }
    return unreadCount;
  }
}

