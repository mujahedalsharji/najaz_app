/*
 * Najaz Mobile App
 * Home Data Model
 * 
 * This file contains the data model for home screen data.
 * Follows Bagisto's theme customization pattern, tailored for Najaz.
 */

import 'package:json_annotation/json_annotation.dart';

import '../base_models/graphql_base_model.dart';
import '../service_models/category_model.dart';

part 'home_data_model.g.dart';

/// Banner Model
/// 
/// Represents a banner/slider image on the home screen
@JsonSerializable()
class BannerModel {
  /// Banner ID
  final String? id;

  /// Banner image URL
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;

  /// Banner title
  final String? title;

  /// Banner link/navigation URL
  final String? link;

  BannerModel({
    this.id,
    this.imageUrl,
    this.title,
    this.link,
  });

  /// Creates a BannerModel instance from JSON
  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  /// Converts BannerModel instance to JSON
  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}

/// Home Data Model
/// 
/// Contains all data needed for the home screen
@JsonSerializable()
class HomeDataModel extends GraphQLBaseModel {
  /// List of banners/sliders
  final List<BannerModel>? banners;

  /// List of service categories
  final List<CategoryModel>? categories;

  HomeDataModel({
    this.banners,
    this.categories,
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

  /// Creates a HomeDataModel instance from JSON
  factory HomeDataModel.fromJson(Map<String, dynamic> json) =>
      _$HomeDataModelFromJson(json);

  /// Converts HomeDataModel instance to JSON
  @override
  Map<String, dynamic> toJson() => _$HomeDataModelToJson(this);
}

