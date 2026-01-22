/*
 * Najaz Mobile App
 * Current Locale Model
 * 
 * This file contains the data model for current locale GraphQL query response.
 */

import 'package:json_annotation/json_annotation.dart';

import '../base_models/graphql_base_model.dart';

part 'current_locale_model.g.dart';

/// Current Locale Model
/// 
/// Contains the current locale information from GraphQL query
@JsonSerializable()
class CurrentLocaleModel extends GraphQLBaseModel {
  /// Locale data
  @JsonKey(name: 'currentLocale')
  final LocaleDataModel? currentLocale;

  CurrentLocaleModel({
    this.currentLocale,
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

  /// Creates a CurrentLocaleModel instance from JSON
  factory CurrentLocaleModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentLocaleModelFromJson(json);

  /// Converts CurrentLocaleModel instance to JSON
  @override
  Map<String, dynamic> toJson() => _$CurrentLocaleModelToJson(this);
}

/// Locale Data Model
/// 
/// Represents locale information
@JsonSerializable()
class LocaleDataModel {
  /// Locale ID
  @JsonKey(fromJson: _idFromJson)
  final String? id;

  /// Helper to convert ID from int or String to String
  static String? _idFromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) return json;
    if (json is int) return json.toString();
    return json.toString();
  }

  /// Locale code (e.g., 'ar', 'en')
  final String? code;

  /// Locale name
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

  LocaleDataModel({
    this.id,
    this.code,
    this.name,
    this.direction,
    this.logoUrl,
    this.createdAt,
    this.updatedAt,
  });

  /// Creates a LocaleDataModel instance from JSON
  factory LocaleDataModel.fromJson(Map<String, dynamic> json) =>
      _$LocaleDataModelFromJson(json);

  /// Converts LocaleDataModel instance to JSON
  Map<String, dynamic> toJson() => _$LocaleDataModelToJson(this);
}

