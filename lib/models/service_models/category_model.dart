/*
 * Najaz Mobile App
 * Category Model
 * 
 * This file contains the data model for service categories.
 * Follows Bagisto's category model pattern, tailored for Najaz.
 */

import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

/// Category Model
/// 
/// Represents a service category with nested subcategories support
@JsonSerializable()
class CategoryModel {
  /// Category ID
  final String? id;

  /// Category name
  final String? name;

  /// Category slug (for URL/routing)
  final String? slug;

  /// Category description
  final String? description;

  /// Category image/icon URL
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;

  /// Category banner URL
  @JsonKey(name: 'bannerUrl')
  final String? bannerUrl;

  /// Subcategories (children)
  final List<CategoryModel>? children;

  CategoryModel({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.imageUrl,
    this.bannerUrl,
    this.children,
  });

  /// Creates a CategoryModel instance from JSON
  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  /// Converts CategoryModel instance to JSON
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

