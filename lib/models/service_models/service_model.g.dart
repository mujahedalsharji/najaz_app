// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) => ServiceModel(
      id: ServiceModel._idFromJson(json['id']),
      name: json['name'] as String?,
      description: json['description'] as String?,
      baseImage: json['baseImage'] as String?,
      image: json['image'] as String?,
      status: json['status'] as bool?,
      category: json['category'] == null
          ? null
          : ServiceCategory.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'baseImage': instance.baseImage,
      'image': instance.image,
      'status': instance.status,
      'category': instance.category,
    };

ServiceCategory _$ServiceCategoryFromJson(Map<String, dynamic> json) =>
    ServiceCategory(
      id: ServiceCategory._categoryIdFromJson(json['id']),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ServiceCategoryToJson(ServiceCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
