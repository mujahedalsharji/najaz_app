// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceListModel _$ServiceListModelFromJson(Map<String, dynamic> json) =>
    ServiceListModel(
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
      hasMore: json['hasMore'] as bool?,
      success: json['success'] as bool?,
      status: json['status'] as bool?,
      message: json['message'] as String?,
      graphqlErrors: json['graphqlErrors'] as String?,
    );

Map<String, dynamic> _$ServiceListModelToJson(ServiceListModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'graphqlErrors': instance.graphqlErrors,
      'services': instance.services,
      'totalCount': instance.totalCount,
      'hasMore': instance.hasMore,
    };
