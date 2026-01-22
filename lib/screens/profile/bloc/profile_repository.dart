/*
 * Najaz Mobile App
 * Profile Repository
 */

import 'package:flutter/foundation.dart';

import '../../../models/profile_models/my_profile_model.dart';
import '../../../services/api_client.dart';
import '../../../services/graphql_queries/my_profile_query.dart';
import '../../../services/graphql_queries/unread_notifications_count_query.dart';

abstract class ProfileRepository {
  Future<MyProfileModel?> fetchMyProfile();
  Future<int?> fetchUnreadNotificationsCount();
}

class ProfileRepositoryImp implements ProfileRepository {
  final ApiClient _apiClient = ApiClient();

  @override
  Future<MyProfileModel?> fetchMyProfile() async {
    MyProfileModel? profile;
    try {
      profile = await _apiClient.query<MyProfileModel>(
        document: MyProfileQuery.myProfile,
        operationName: 'myProfile',
        parser: (json) => MyProfileModel.fromJson(json),
      );
    } catch (error, stacktrace) {
      debugPrint("Error in ProfileRepository.fetchMyProfile --> $error");
      debugPrint("StackTrace --> $stacktrace");
    }
    return profile;
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
        "Error in ProfileRepository.fetchUnreadNotificationsCount --> $error",
      );
      debugPrint("StackTrace --> $stacktrace");
    }
    return unreadCount;
  }
}

