/*
 * Najaz Mobile App
 * GraphQL Base Model
 * 
 * This file contains the base model class for GraphQL responses.
 * All GraphQL response models should extend this base model.
 */

import 'package:json_annotation/json_annotation.dart';

part 'graphql_base_model.g.dart';

/// Base Model for GraphQL responses
/// 
/// Contains common fields that appear in all GraphQL responses:
/// - success: Boolean indicating if operation was successful
/// - status: Boolean indicating response status
/// - message: Response message string
/// - graphqlErrors: GraphQL error message if any
/// 
/// All GraphQL response models should extend this class.
@JsonSerializable()
class GraphQLBaseModel {
  /// Indicates if the operation was successful
  final bool? success;

  /// Response status (true if successful, false if error)
  final bool? status;

  /// Response message
  final String? message;

  /// GraphQL error message (if any)
  @JsonKey(name: 'graphqlErrors')
  final String? graphqlErrors;

  GraphQLBaseModel({
    this.success,
    this.status,
    this.message,
    this.graphqlErrors,
  });

  /// Creates a GraphQLBaseModel instance from JSON
  factory GraphQLBaseModel.fromJson(Map<String, dynamic> json) =>
      _$GraphQLBaseModelFromJson(json);

  /// Converts GraphQLBaseModel instance to JSON
  Map<String, dynamic> toJson() => _$GraphQLBaseModelToJson(this);

  /// Checks if the response was successful
  bool get isSuccess => status == true || success == true;

  /// Gets the error message if any
  String? get errorMessage => graphqlErrors ?? message;
}

