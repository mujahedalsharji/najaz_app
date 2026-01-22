// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_service_requests_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyServiceRequestsModel _$MyServiceRequestsModelFromJson(
        Map<String, dynamic> json) =>
    MyServiceRequestsModel(
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => MyServiceRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginatorInfo: json['paginatorInfo'] == null
          ? null
          : PaginatorInfo.fromJson(
              json['paginatorInfo'] as Map<String, dynamic>),
      success: json['success'] as bool?,
      status: json['status'] as bool?,
      message: json['message'] as String?,
      graphqlErrors: json['graphqlErrors'] as String?,
    );

Map<String, dynamic> _$MyServiceRequestsModelToJson(
        MyServiceRequestsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'graphqlErrors': instance.graphqlErrors,
      'data': instance.data,
      'paginatorInfo': instance.paginatorInfo,
    };

MyServiceRequestModel _$MyServiceRequestModelFromJson(
        Map<String, dynamic> json) =>
    MyServiceRequestModel(
      id: MyServiceRequestModel._idFromJson(json['id']),
      incrementId: json['incrementId'] as String?,
      serviceId: MyServiceRequestModel._idFromJson(json['serviceId']),
      citizenId: MyServiceRequestModel._idFromJson(json['citizenId']),
      status: json['status'] as String?,
      formData: json['formData'],
      notes: json['notes'] as String?,
      completedAt: json['completedAt'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      service: json['service'] == null
          ? null
          : MyServiceRequestService.fromJson(
              json['service'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyServiceRequestModelToJson(
        MyServiceRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'incrementId': instance.incrementId,
      'serviceId': instance.serviceId,
      'citizenId': instance.citizenId,
      'status': instance.status,
      'formData': instance.formData,
      'notes': instance.notes,
      'completedAt': instance.completedAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'service': instance.service,
    };

MyServiceRequestService _$MyServiceRequestServiceFromJson(
        Map<String, dynamic> json) =>
    MyServiceRequestService(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$MyServiceRequestServiceToJson(
        MyServiceRequestService instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
