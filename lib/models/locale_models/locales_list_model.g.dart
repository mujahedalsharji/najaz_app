// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locales_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalesListModel _$LocalesListModelFromJson(Map<String, dynamic> json) =>
    LocalesListModel(
      locales: (json['locales'] as List<dynamic>?)
          ?.map((e) => LocaleItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool?,
      status: json['status'] as bool?,
      message: json['message'] as String?,
      graphqlErrors: json['graphqlErrors'] as String?,
    );

Map<String, dynamic> _$LocalesListModelToJson(LocalesListModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'graphqlErrors': instance.graphqlErrors,
      'locales': instance.locales,
    };

LocaleItemModel _$LocaleItemModelFromJson(Map<String, dynamic> json) =>
    LocaleItemModel(
      id: LocaleItemModel._idFromJson(json['id']),
      code: json['code'] as String?,
      name: json['name'] as String?,
      direction: json['direction'] as String?,
      logoUrl: json['logoUrl'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$LocaleItemModelToJson(LocaleItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'direction': instance.direction,
      'logoUrl': instance.logoUrl,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
