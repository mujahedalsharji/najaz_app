/*
 * Najaz Mobile App
 * Service Categories Model
 * 
 * This file contains the data model for service categories GraphQL query response.
 */

import 'package:json_annotation/json_annotation.dart';

import '../base_models/graphql_base_model.dart';
import 'services_page_model.dart';
part 'service_categories_model.g.dart';

/// Service Categories Model
/// 
/// Contains paginated list of categories with their services
@JsonSerializable()
class ServiceCategoriesModel extends GraphQLBaseModel {
  /// Categories data list
  @JsonKey(name: 'data')
  final List<ServiceCategoryModel>? data;

  /// Pagination information
  @JsonKey(name: 'paginatorInfo')
  final PaginatorInfoModel? paginatorInfo;

  ServiceCategoriesModel({
    this.data,
    this.paginatorInfo,
    bool? success,
    bool? status,
    String? message,
    String? graphqlErrors,
  }) : super(
          success: success,
          status: status,
          message: message,
          graphqlErrors: graphqlErrors,
        );

  /// Creates a ServiceCategoriesModel instance from JSON
  factory ServiceCategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceCategoriesModelFromJson(json);

  /// Converts ServiceCategoriesModel instance to JSON
  @override
  Map<String, dynamic> toJson() => _$ServiceCategoriesModelToJson(this);
}

/// Service Category Model
/// 
/// Represents a service category with its services
@JsonSerializable()
class ServiceCategoryModel {
  /// Category ID
  @JsonKey(fromJson: _idFromJson)
  final String? id;

  /// Helper to convert ID from int or String to String
  static String? _idFromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) return json;
    if (json is int) return json.toString();
    return json.toString();
  }

  /// Category name
  final String? name;

  /// Category slug
  final String? slug;

  /// Category status
  final bool? status;

  /// Category position
  final int? position;

  /// Parent category ID
  @JsonKey(name: 'parentId', fromJson: _idFromJson)
  final String? parentId;

  /// Category logo URL
  @JsonKey(name: 'logoUrl')
  final String? logoUrl;

  /// Category banner URL
  @JsonKey(name: 'bannerUrl')
  final String? bannerUrl;

  /// Category URL
  final String? url;

  /// Services list in this category
  @JsonKey(name: 'services')
  final List<CategoryServiceModel>? services;

  ServiceCategoryModel({
    this.id,
    this.name,
    this.slug,
    this.status,
    this.position,
    this.parentId,
    this.logoUrl,
    this.bannerUrl,
    this.url,
    this.services,
  });

  /// Creates a ServiceCategoryModel instance from JSON
  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceCategoryModelFromJson(json);

  /// Converts ServiceCategoryModel instance to JSON
  Map<String, dynamic> toJson() => _$ServiceCategoryModelToJson(this);
}

/// Category Service Model
/// 
/// Represents a service within a category
@JsonSerializable()
class CategoryServiceModel {
  /// Service ID
  @JsonKey(fromJson: _idFromJson)
  final String? id;

  /// Helper to convert ID from int or String to String
  static String? _idFromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) return json;
    if (json is int) return json.toString();
    return json.toString();
  }

  /// Service name
  final String? name;

  /// Service base image URL
  @JsonKey(name: 'baseImage')
  final String? baseImage;

  CategoryServiceModel({
    this.id,
    this.name,
    this.baseImage,
  });

  /// Creates a CategoryServiceModel instance from JSON
  factory CategoryServiceModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryServiceModelFromJson(json);

  /// Converts CategoryServiceModel instance to JSON
  Map<String, dynamic> toJson() => _$CategoryServiceModelToJson(this);
}


