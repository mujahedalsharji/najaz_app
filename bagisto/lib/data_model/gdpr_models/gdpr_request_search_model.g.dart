// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gdpr_request_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GdprSearchModal _$GdprSearchModalFromJson(Map<String, dynamic> json) =>
    GdprSearchModal(
      typename: json['__typename'] as String?,
      id: json['id'] as String?,
      customerId: json['customerId'] as String?,
      email: json['email'] as String?,
      status: json['status'] as String?,
      type: json['type'] as String?,
      message: json['message'] as String?,
      revokedAt: json['revokedAt'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      responseStatus: json['responseStatus'] as bool?,
    );

Map<String, dynamic> _$GdprSearchModalToJson(GdprSearchModal instance) =>
    <String, dynamic>{
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
      'responseStatus': instance.responseStatus,
    };
