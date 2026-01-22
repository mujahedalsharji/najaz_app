/*
 * Najaz Mobile App
 * Home Repository
 * 
 * This file contains the repository for home screen API calls.
 * Follows Bagisto's HomePageRepository pattern, tailored for Najaz.
 */

import 'package:flutter/foundation.dart';

import '../../../models/home_models/home_page_model.dart';
import '../../../services/api_client.dart';
import '../../../services/graphql_queries/home_page_query.dart';

/// Repository interface for home operations
abstract class HomeRepository {
  /// Fetches home page data (citizen, requests, services)
  Future<HomePageModel?> fetchHomePage({
    int? requestsPage,
    int? requestsLimit,
    int? servicesPage,
    int? servicesLimit,
  });
}

/// Implementation of HomeRepository
class HomeRepositoryImp implements HomeRepository {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<HomePageModel?> fetchHomePage({
    int? requestsPage,
    int? requestsLimit,
    int? servicesPage,
    int? servicesLimit,
  }) async {
    HomePageModel? homePageResponseModel;
    try {
      final variables = {
        if (requestsPage != null) 'requestsPage': requestsPage,
        if (requestsLimit != null) 'requestsLimit': requestsLimit,
        if (servicesPage != null) 'servicesPage': servicesPage,
        if (servicesLimit != null) 'servicesLimit': servicesLimit,
      };

      homePageResponseModel = await _apiClient.query<HomePageModel>(
        document: HomePageQuery.homePage,
        variables: variables,
        operationName: 'homePage',
        parser: (json) => HomePageModel.fromJson(json),
      );
    } catch (error, stacktrace) {
      debugPrint("Error in HomeRepository.fetchHomePage --> $error");
      debugPrint("StackTrace --> $stacktrace");
    }
    return homePageResponseModel;
  }
}

