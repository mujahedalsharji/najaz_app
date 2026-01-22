/*
 * Najaz Mobile App
 * GraphQL Base Error Model
 * 
 * This file contains the base error model for GraphQL error responses.
 */

import 'package:json_annotation/json_annotation.dart';

part 'graphql_base_error_model.g.dart';

/// Base Error Model for GraphQL error responses
/// 
/// Represents error responses from GraphQL API.
/// Used when parsing error responses or handling exceptions.
@JsonSerializable()
class GraphQLBaseErrorModel {
  /// Success status (usually false or null for errors)
  final String? success;

  /// Response status (false for errors)
  final bool? responseStatus;

  /// Error message
  final String? message;

  /// GraphQL error message
  @JsonKey(name: 'graphqlErrors')
  final String? graphqlErrors;

  GraphQLBaseErrorModel({
    this.success,
    this.responseStatus,
    this.message,
    this.graphqlErrors,
  });

  /// Creates a GraphQLBaseErrorModel instance from JSON
  factory GraphQLBaseErrorModel.fromJson(Map<String, dynamic> json) =>
      _$GraphQLBaseErrorModelFromJson(json);

  /// Converts GraphQLBaseErrorModel instance to JSON
  Map<String, dynamic> toJson() => _$GraphQLBaseErrorModelToJson(this);

  /// Checks if this is an error response
  bool get isError => responseStatus == false || success == 'false';

  /// Gets the error message
  String? get errorMessage => graphqlErrors ?? message ?? 'An error occurred';
}

