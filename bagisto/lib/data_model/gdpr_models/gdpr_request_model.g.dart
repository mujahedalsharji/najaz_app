// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gdpr_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GdprRequestModel _$GdprRequestModelFromJson(Map<String, dynamic> json) =>
    GdprRequestModel(
      typename: json['__typename'] as String?,
      paginatorInfo: json['paginatorInfo'] == null
          ? null
          : PaginatorInfo.fromJson(
              json['paginatorInfo'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as bool?,
      responseStatus: json['responseStatus'] as bool?,
    );

Map<String, dynamic> _$GdprRequestModelToJson(GdprRequestModel instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'paginatorInfo': instance.paginatorInfo,
      'data': instance.data,
      'status': instance.status,
      'responseStatus': instance.responseStatus,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      typename: json['__typename'] as String?,
      id: json['id'] as String?,
      customerId: json['customerId'] as String?,
      email: json['email'] as String?,
      status: json['status'] as String?,
      type: json['type'] as String?,
      message: json['message'] as String?,
      revokedAt: json['revokedAt'],
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      '__typename': instance.typename,
      'id': instance.id,
      'customerId': instance.customerId,
      'email': instance.email,
      'status': instance.status,
      'type': instance.type,
      'message': instance.message,
      'revokedAt': instance.revokedAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

PaginatorInfo _$PaginatorInfoFromJson(Map<String, dynamic> json) =>
    PaginatorInfo(
      typename: json['__typename'] as String?,
      count: (json['count'] as num?)?.toInt(),
      currentPage: (json['currentPage'] as num?)?.toInt(),
      lastPage: (json['lastPage'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginatorInfoToJson(PaginatorInfo instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'count': instance.count,
      'currentPage': instance.currentPage,
      'lastPage': instance.lastPage,
      'total': instance.total,
    };
