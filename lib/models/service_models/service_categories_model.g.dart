// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_categories_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceCategoriesModel _$ServiceCategoriesModelFromJson(
        Map<String, dynamic> json) =>
    ServiceCategoriesModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ServiceCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginatorInfo: json['paginatorInfo'] == null
          ? null
          : PaginatorInfoModel.fromJson(
              json['paginatorInfo'] as Map<String, dynamic>),
      success: json['success'] as bool?,
      status: json['status'] as bool?,
      message: json['message'] as String?,
      graphqlErrors: json['graphqlErrors'] as String?,
    );

Map<String, dynamic> _$ServiceCategoriesModelToJson(
        ServiceCategoriesModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'graphqlErrors': instance.graphqlErrors,
      'data': instance.data,
      'paginatorInfo': instance.paginatorInfo,
    };

ServiceCategoryModel _$ServiceCategoryModelFromJson(
        Map<String, dynamic> json) =>
    ServiceCategoryModel(
      id: ServiceCategoryModel._idFromJson(json['id']),
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      status: json['status'] as bool?,
      position: (json['position'] as num?)?.toInt(),
      parentId: ServiceCategoryModel._idFromJson(json['parentId']),
      logoUrl: json['logoUrl'] as String?,
      bannerUrl: json['bannerUrl'] as String?,
      url: json['url'] as String?,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => CategoryServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServiceCategoryModelToJson(
        ServiceCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'status': instance.status,
      'position': instance.position,
      'parentId': instance.parentId,
      'logoUrl': instance.logoUrl,
      'bannerUrl': instance.bannerUrl,
      'url': instance.url,
      'services': instance.services,
    };

CategoryServiceModel _$CategoryServiceModelFromJson(
        Map<String, dynamic> json) =>
    CategoryServiceModel(
      id: CategoryServiceModel._idFromJson(json['id']),
      name: json['name'] as String?,
      baseImage: json['baseImage'] as String?,
    );

Map<String, dynamic> _$CategoryServiceModelToJson(
        CategoryServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'baseImage': instance.baseImage,
    };
