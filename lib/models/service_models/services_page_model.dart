/*
 * Najaz Mobile App
 * Services Page Model
 * 
 * This file contains the data model for services page GraphQL query response.
 */

import 'package:json_annotation/json_annotation.dart';

import '../base_models/graphql_base_model.dart';
import 'service_model.dart';
part 'services_page_model.g.dart';

/// Services Page Model
/// 
/// Contains all data needed for the services page from GraphQL query
@JsonSerializable()
class ServicesPageModel extends GraphQLBaseModel {
  /// Categories list
  @JsonKey(name: 'categories')
  final List<CategoryModel>? categories;

  /// Services list with pagination
  @JsonKey(name: 'services')
  final ServiceListModel? services;

  ServicesPageModel({
    this.categories,
    this.services,
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

  /// Creates a ServicesPageModel instance from JSON
  factory ServicesPageModel.fromJson(Map<String, dynamic> json) =>
      _$ServicesPageModelFromJson(json);

  /// Converts ServicesPageModel instance to JSON
  @override
  Map<String, dynamic> toJson() => _$ServicesPageModelToJson(this);
}

/// Category Model
/// 
/// Represents a service category
@JsonSerializable()
class CategoryModel {
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

  /// Category description
  final String? description;

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

  /// Services list in this category (nested from GraphQL)
  @JsonKey(name: 'services')
  final List<CategoryService>? servicesList;

  CategoryModel({
    this.id,
    this.name,
    this.description,
    this.slug,
    this.status,
    this.position,
    this.parentId,
    this.logoUrl,
    this.bannerUrl,
    this.url,
    this.servicesList,
  });

  /// Creates a CategoryModel instance from JSON
  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  /// Converts CategoryModel instance to JSON
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

/// Category Service Model
/// 
/// Represents a service within a category (simplified)
@JsonSerializable()
class CategoryService {
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

  /// Service image URL
  @JsonKey(name: 'image')
  final String? image;

  CategoryService({
    this.id,
    this.name,
    this.baseImage,
    this.image,
  });

  /// Creates a CategoryService instance from JSON
  factory CategoryService.fromJson(Map<String, dynamic> json) =>
      _$CategoryServiceFromJson(json);

  /// Converts CategoryService instance to JSON
  Map<String, dynamic> toJson() => _$CategoryServiceToJson(this);
}

/// Service List Model
/// 
/// Contains paginated list of services
@JsonSerializable()
class ServiceListModel {
  /// Services data list
  @JsonKey(name: 'data')
  final List<ServiceModel>? data;

  /// Pagination information
  @JsonKey(name: 'paginatorInfo')
  final PaginatorInfoModel? paginatorInfo;

  ServiceListModel({
    this.data,
    this.paginatorInfo,
  });

  /// Creates a ServiceListModel instance from JSON
  factory ServiceListModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceListModelFromJson(json);

  /// Converts ServiceListModel instance to JSON
  Map<String, dynamic> toJson() => _$ServiceListModelToJson(this);
}

/// Paginator Info Model
/// 
/// Contains pagination information
@JsonSerializable()
class PaginatorInfoModel {
  /// Count of items in current page
  final int? count;

  /// Total number of items
  final int? total;

  /// Current page number
  @JsonKey(name: 'currentPage')
  final int? currentPage;

  /// Last page number
  @JsonKey(name: 'lastPage')
  final int? lastPage;

  /// Whether there are more pages
  @JsonKey(name: 'hasMorePages')
  final bool? hasMorePages;

  PaginatorInfoModel({
    this.count,
    this.total,
    this.currentPage,
    this.lastPage,
    this.hasMorePages,
  });

  /// Creates a PaginatorInfoModel instance from JSON
  factory PaginatorInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PaginatorInfoModelFromJson(json);

  /// Converts PaginatorInfoModel instance to JSON
  Map<String, dynamic> toJson() => _$PaginatorInfoModelToJson(this);
}
