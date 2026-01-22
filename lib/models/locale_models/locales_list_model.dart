/*
 * Najaz Mobile App
 * Locales List Model
 * 
 * This file contains the data model for available locales list from GraphQL query.
 * Similar to CurrencyLanguageList in Bagisto, but tailored for Najaz.
 */

import 'package:json_annotation/json_annotation.dart';

import '../base_models/graphql_base_model.dart';

part 'locales_list_model.g.dart';

/// Locales List Model
/// 
/// Contains the list of available locales from GraphQL query
@JsonSerializable()
class LocalesListModel extends GraphQLBaseModel {
  /// List of available locales
  final List<LocaleItemModel>? locales;

  LocalesListModel({
    this.locales,
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

  /// Creates a LocalesListModel instance from JSON
  factory LocalesListModel.fromJson(Map<String, dynamic> json) =>
      _$LocalesListModelFromJson(json);

  /// Converts LocalesListModel instance to JSON
  @override
  Map<String, dynamic> toJson() => _$LocalesListModelToJson(this);
}

/// Locale Item Model
/// 
/// Represents a single locale option
@JsonSerializable()
class LocaleItemModel {
  /// Locale ID
  @JsonKey(fromJson: _idFromJson)
  final String? id;

  /// Locale code (e.g., 'ar', 'en')
  final String? code;

  /// Locale name (e.g., 'العربية', 'English')
  final String? name;

  /// Text direction ('rtl' or 'ltr')
  final String? direction;

  /// Logo URL
  @JsonKey(name: 'logoUrl')
  final String? logoUrl;

  /// Created at timestamp
  @JsonKey(name: 'createdAt')
  final String? createdAt;

  /// Updated at timestamp
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  LocaleItemModel({
    this.id,
    this.code,
    this.name,
    this.direction,
    this.logoUrl,
    this.createdAt,
    this.updatedAt,
  });

  /// Helper to convert ID from int or String to String
  static String? _idFromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) return json;
    if (json is int) return json.toString();
    return json.toString();
  }

  /// Creates a LocaleItemModel instance from JSON
  factory LocaleItemModel.fromJson(Map<String, dynamic> json) =>
      _$LocaleItemModelFromJson(json);

  /// Converts LocaleItemModel instance to JSON
  Map<String, dynamic> toJson() => _$LocaleItemModelToJson(this);
}

