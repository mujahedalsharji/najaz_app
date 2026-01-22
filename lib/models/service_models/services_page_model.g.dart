// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesPageModel _$ServicesPageModelFromJson(Map<String, dynamic> json) =>
    ServicesPageModel(
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      services: json['services'] == null
          ? null
          : ServiceListModel.fromJson(json['services'] as Map<String, dynamic>),
      success: json['success'] as bool?,
      status: json['status'] as bool?,
      message: json['message'] as String?,
      graphqlErrors: json['graphqlErrors'] as String?,
    );

Map<String, dynamic> _$ServicesPageModelToJson(ServicesPageModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'graphqlErrors': instance.graphqlErrors,
      'categories': instance.categories,
      'services': instance.services,
    };

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: CategoryModel._idFromJson(json['id']),
      name: json['name'] as String?,
      description: json['description'] as String?,
      slug: json['slug'] as String?,
      status: json['status'] as bool?,
      position: (json['position'] as num?)?.toInt(),
      parentId: CategoryModel._idFromJson(json['parentId']),
      logoUrl: json['logoUrl'] as String?,
      bannerUrl: json['bannerUrl'] as String?,
      url: json['url'] as String?,
      servicesList: (json['services'] as List<dynamic>?)
          ?.map((e) => CategoryService.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'slug': instance.slug,
      'status': instance.status,
      'position': instance.position,
      'parentId': instance.parentId,
      'logoUrl': instance.logoUrl,
      'bannerUrl': instance.bannerUrl,
      'url': instance.url,
      'services': instance.servicesList,
    };

CategoryService _$CategoryServiceFromJson(Map<String, dynamic> json) =>
    CategoryService(
      id: CategoryService._idFromJson(json['id']),
      name: json['name'] as String?,
      baseImage: json['baseImage'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$CategoryServiceToJson(CategoryService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'baseImage': instance.baseImage,
      'image': instance.image,
    };

ServiceListModel _$ServiceListModelFromJson(Map<String, dynamic> json) =>
    ServiceListModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginatorInfo: json['paginatorInfo'] == null
          ? null
          : PaginatorInfoModel.fromJson(
              json['paginatorInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceListModelToJson(ServiceListModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'paginatorInfo': instance.paginatorInfo,
    };

PaginatorInfoModel _$PaginatorInfoModelFromJson(Map<String, dynamic> json) =>
    PaginatorInfoModel(
      count: (json['count'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
      currentPage: (json['currentPage'] as num?)?.toInt(),
      lastPage: (json['lastPage'] as num?)?.toInt(),
      hasMorePages: json['hasMorePages'] as bool?,
    );

Map<String, dynamic> _$PaginatorInfoModelToJson(PaginatorInfoModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'total': instance.total,
      'currentPage': instance.currentPage,
      'lastPage': instance.lastPage,
      'hasMorePages': instance.hasMorePages,
    };
