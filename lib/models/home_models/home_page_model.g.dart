// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomePageModel _$HomePageModelFromJson(Map<String, dynamic> json) =>
    HomePageModel(
      citizen: json['citizen'] == null
          ? null
          : CitizenHomeData.fromJson(json['citizen'] as Map<String, dynamic>),
      unreadNotificationsCount:
          (json['unreadNotificationsCount'] as num?)?.toInt(),
      serviceRequests: json['serviceRequests'] == null
          ? null
          : ServiceRequestListModel.fromJson(
              json['serviceRequests'] as Map<String, dynamic>),
      services: json['services'] == null
          ? null
          : ServiceHomeListModel.fromJson(
              json['services'] as Map<String, dynamic>),
      success: json['success'] as bool?,
      status: json['status'] as bool?,
      message: json['message'] as String?,
      graphqlErrors: json['graphqlErrors'] as String?,
    );

Map<String, dynamic> _$HomePageModelToJson(HomePageModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'graphqlErrors': instance.graphqlErrors,
      'citizen': instance.citizen,
      'unreadNotificationsCount': instance.unreadNotificationsCount,
      'serviceRequests': instance.serviceRequests,
      'services': instance.services,
    };

CitizenHomeData _$CitizenHomeDataFromJson(Map<String, dynamic> json) =>
    CitizenHomeData(
      id: CitizenHomeData._idFromJson(json['id']),
      firstName: json['firstName'] as String?,
      middleName: json['middleName'] as String?,
      lastName: json['lastName'] as String?,
      identityVerificationStatus: const IdentityVerificationStatusConverter()
          .fromJson(json['identityVerificationStatus']),
    );

Map<String, dynamic> _$CitizenHomeDataToJson(CitizenHomeData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'identityVerificationStatus': const IdentityVerificationStatusConverter()
          .toJson(instance.identityVerificationStatus),
    };

ServiceRequestModel _$ServiceRequestModelFromJson(Map<String, dynamic> json) =>
    ServiceRequestModel(
      id: ServiceRequestModel._idFromJson(json['id']),
      incrementId: json['incrementId'] as String?,
      status: json['status'] as String?,
      service: json['service'] == null
          ? null
          : ServiceRequestService.fromJson(
              json['service'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ServiceRequestModelToJson(
        ServiceRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'incrementId': instance.incrementId,
      'status': instance.status,
      'service': instance.service,
      'createdAt': instance.createdAt,
    };

ServiceRequestService _$ServiceRequestServiceFromJson(
        Map<String, dynamic> json) =>
    ServiceRequestService(
      id: ServiceRequestService._serviceRequestServiceIdFromJson(json['id']),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ServiceRequestServiceToJson(
        ServiceRequestService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

ServiceRequestListModel _$ServiceRequestListModelFromJson(
        Map<String, dynamic> json) =>
    ServiceRequestListModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ServiceRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginatorInfo: json['paginatorInfo'] == null
          ? null
          : PaginatorInfo.fromJson(
              json['paginatorInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceRequestListModelToJson(
        ServiceRequestListModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'paginatorInfo': instance.paginatorInfo,
    };

ServiceHomeModel _$ServiceHomeModelFromJson(Map<String, dynamic> json) =>
    ServiceHomeModel(
      id: ServiceHomeModel._serviceIdFromJson(json['id']),
      name: json['name'] as String?,
      baseImage: json['baseImage'] as String?,
    );

Map<String, dynamic> _$ServiceHomeModelToJson(ServiceHomeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'baseImage': instance.baseImage,
    };

ServiceHomeListModel _$ServiceHomeListModelFromJson(
        Map<String, dynamic> json) =>
    ServiceHomeListModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ServiceHomeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginatorInfo: json['paginatorInfo'] == null
          ? null
          : PaginatorInfo.fromJson(
              json['paginatorInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceHomeListModelToJson(
        ServiceHomeListModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'paginatorInfo': instance.paginatorInfo,
    };

PaginatorInfo _$PaginatorInfoFromJson(Map<String, dynamic> json) =>
    PaginatorInfo(
      total: (json['total'] as num?)?.toInt(),
      currentPage: (json['currentPage'] as num?)?.toInt(),
      lastPage: (json['lastPage'] as num?)?.toInt(),
      hasMorePages: json['hasMorePages'] as bool?,
    );

Map<String, dynamic> _$PaginatorInfoToJson(PaginatorInfo instance) =>
    <String, dynamic>{
      'total': instance.total,
      'currentPage': instance.currentPage,
      'lastPage': instance.lastPage,
      'hasMorePages': instance.hasMorePages,
    };
