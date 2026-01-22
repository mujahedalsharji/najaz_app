/*
 * Najaz Mobile App
 * Service Model
 * 
 * This file contains the data model for services.
 * Tailored for Najaz service-based platform.
 */

import 'package:json_annotation/json_annotation.dart';

part 'service_model.g.dart';

/// Service Model
/// 
/// Represents a service offered on the Najaz platform
@JsonSerializable()
class ServiceModel {
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

  /// Service description
  final String? description;

  /// Service base image URL (from GraphQL: baseImage)
  @JsonKey(name: 'baseImage')
  final String? baseImage;

  /// Service image URL (from GraphQL: image)
  @JsonKey(name: 'image')
  final String? image;

  /// Service status
  final bool? status;

  /// Category information (nested object from GraphQL)
  final ServiceCategory? category;

  ServiceModel({
    this.id,
    this.name,
    this.description,
    this.baseImage,
    this.image,
    this.status,
    this.category,
  });

  /// Creates a ServiceModel instance from JSON
  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);

  /// Converts ServiceModel instance to JSON
  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);

  /// Service image URL (for backward compatibility, prefers image over baseImage)
  String? get imageUrl => image ?? baseImage;

  /// Category ID (extracted from nested category object)
  String? get categoryId => category?.id;

  /// Category name (extracted from nested category object)
  String? get categoryName => category?.name;
}

/// Service Category Model
/// 
/// Represents category information within a service
@JsonSerializable()
class ServiceCategory {
  /// Category ID
  @JsonKey(fromJson: _categoryIdFromJson)
  final String? id;

  /// Helper to convert Category ID from int or String to String
  static String? _categoryIdFromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) return json;
    if (json is int) return json.toString();
    return json.toString();
  }

  /// Category name
  final String? name;

  ServiceCategory({
    this.id,
    this.name,
  });

  /// Creates a ServiceCategory instance from JSON
  factory ServiceCategory.fromJson(Map<String, dynamic> json) =>
      _$ServiceCategoryFromJson(json);

  /// Converts ServiceCategory instance to JSON
  Map<String, dynamic> toJson() => _$ServiceCategoryToJson(this);
}

