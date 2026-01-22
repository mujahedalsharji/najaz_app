// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_locale_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentLocaleModel _$CurrentLocaleModelFromJson(Map<String, dynamic> json) =>
    CurrentLocaleModel(
      currentLocale: json['currentLocale'] == null
          ? null
          : LocaleDataModel.fromJson(
              json['currentLocale'] as Map<String, dynamic>),
      success: json['success'] as bool?,
      status: json['status'] as bool?,
      message: json['message'] as String?,
      graphqlErrors: json['graphqlErrors'] as String?,
    );

Map<String, dynamic> _$CurrentLocaleModelToJson(CurrentLocaleModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'graphqlErrors': instance.graphqlErrors,
      'currentLocale': instance.currentLocale,
    };

LocaleDataModel _$LocaleDataModelFromJson(Map<String, dynamic> json) =>
    LocaleDataModel(
      id: LocaleDataModel._idFromJson(json['id']),
      code: json['code'] as String?,
      name: json['name'] as String?,
      direction: json['direction'] as String?,
      logoUrl: json['logoUrl'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$LocaleDataModelToJson(LocaleDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'direction': instance.direction,
      'logoUrl': instance.logoUrl,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
