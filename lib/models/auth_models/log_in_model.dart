/*
 * Najaz Mobile App
 * Log-In Model
 * 
 * This file contains the data model for citizen log-in API response.
 * Follows Bagisto's SignInModel pattern, tailored for Najaz.
 */

import 'package:json_annotation/json_annotation.dart';

import '../base_models/graphql_base_model.dart';
import 'sign_up_model.dart'; // Reuse CitizenData from sign-up model

part 'log_in_model.g.dart';

/// Log-In Response Model
/// 
/// Contains the response data from citizen log-in mutation:
/// - Token information (accessToken, tokenType)
/// - Citizen data (id, phone, email, nationalId, etc.)
@JsonSerializable()
class LogInModel extends GraphQLBaseModel {
  /// Access token for authentication
  @JsonKey(name: 'accessToken')
  final String? token;

  /// Token type (e.g., "Bearer")
  final String? tokenType;

  /// Citizen data
  @JsonKey(name: 'citizen')
  final CitizenData? data;

  LogInModel({
    this.token,
    this.tokenType,
    this.data,
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

  /// Creates a LogInModel instance from JSON
  factory LogInModel.fromJson(Map<String, dynamic> json) =>
      _$LogInModelFromJson(json);

  /// Converts LogInModel instance to JSON
  @override
  Map<String, dynamic> toJson() => _$LogInModelToJson(this);
}

