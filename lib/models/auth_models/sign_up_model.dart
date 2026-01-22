/*
 * Najaz Mobile App
 * Sign-Up Model
 * 
 * This file contains the data model for citizen sign-up API response.
 * Follows Bagisto's SignInModel pattern, tailored for Najaz.
 */

import 'package:json_annotation/json_annotation.dart';

import '../base_models/graphql_base_model.dart';

part 'sign_up_model.g.dart';

/// Sign-Up Response Model
/// 
/// Contains the response data from citizen sign-up mutation:
/// - Token information (accessToken, tokenType)
/// - Citizen data (id, name, phone, email, etc.)
@JsonSerializable()
class SignUpModel extends GraphQLBaseModel {
  /// Access token for authentication
  @JsonKey(name: 'accessToken')
  final String? token;

  /// Token type (e.g., "Bearer")
  final String? tokenType;

  /// Citizen data
  @JsonKey(name: 'citizen')
  final CitizenData? data;

  SignUpModel({
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

  /// Creates a SignUpModel instance from JSON
  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpModelFromJson(json);

  /// Converts SignUpModel instance to JSON
  @override
  Map<String, dynamic> toJson() => _$SignUpModelToJson(this);
}

/// Citizen Data Model
/// 
/// Contains citizen information returned from sign-up API
@JsonSerializable()
class CitizenData {
  /// Citizen ID
  final String? id;

  /// Citizen phone number
  final String? phone;

  /// Citizen email
  final String? email;

  /// Citizen national ID
  @JsonKey(name: 'nationalId')
  final String? nationalId;

  CitizenData({
    this.id,
    this.phone,
    this.email,
    this.nationalId,
  });

  /// Creates a CitizenData instance from JSON
  factory CitizenData.fromJson(Map<String, dynamic> json) =>
      _$CitizenDataFromJson(json);

  /// Converts CitizenData instance to JSON
  Map<String, dynamic> toJson() => _$CitizenDataToJson(this);
}

