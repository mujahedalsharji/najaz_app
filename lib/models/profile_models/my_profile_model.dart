/*
 * Najaz Mobile App
 * My Profile Model
 * 
 * Data models for myProfile GraphQL query.
 */

import 'package:json_annotation/json_annotation.dart';

import '../base_models/graphql_base_model.dart';

part 'my_profile_model.g.dart';

@JsonSerializable()
class MyProfileModel extends GraphQLBaseModel {
  @JsonKey(fromJson: _idFromJson)
  final String? id;

  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? gender;
  final String? email;
  final String? phone;
  final String? nationalId;
  final String? dateOfBirth;
  @JsonKey(name: 'status')
  final bool? profileStatus;
  final bool? isVerified;
  final bool? identityVerificationStatus;

  @JsonKey(fromJson: _idFromJson)
  final String? citizenTypeId;
  final String? citizenTypeName;

  final String? createdAt;
  final String? updatedAt;
  final IdentityVerification? identityVerification;

  MyProfileModel({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.gender,
    this.email,
    this.phone,
    this.nationalId,
    this.dateOfBirth,
    this.profileStatus,
    this.isVerified,
    this.identityVerificationStatus,
    this.citizenTypeId,
    this.citizenTypeName,
    this.createdAt,
    this.updatedAt,
    this.identityVerification,
    bool? success,
    bool? statusFlag,
    String? message,
    String? graphqlErrors,
  }) : super(
          success: success,
          status: statusFlag,
          message: message,
          graphqlErrors: graphqlErrors,
        );

  static String? _idFromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) return json;
    if (json is int) return json.toString();
    return json.toString();
  }

  factory MyProfileModel.fromJson(Map<String, dynamic> json) =>
      _$MyProfileModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MyProfileModelToJson(this);
}

@JsonSerializable()
class IdentityVerification {
  @JsonKey(fromJson: _idFromJson)
  final String? id;

  @JsonKey(fromJson: _idFromJson)
  final String? citizenId;

  final String? status;
  final ProfileCitizen? citizen;

  IdentityVerification({this.id, this.citizenId, this.status, this.citizen});

  static String? _idFromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) return json;
    if (json is int) return json.toString();
    return json.toString();
  }

  factory IdentityVerification.fromJson(Map<String, dynamic> json) =>
      _$IdentityVerificationFromJson(json);

  Map<String, dynamic> toJson() => _$IdentityVerificationToJson(this);
}

@JsonSerializable()
class ProfileCitizen {
  @JsonKey(fromJson: _idFromJson)
  final String? id;

  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? gender;
  final String? email;
  final String? phone;
  final String? nationalId;
  final String? dateOfBirth;
  @JsonKey(name: 'status')
  final bool? profileStatus;
  final bool? isVerified;
  final bool? identityVerificationStatus;

  @JsonKey(fromJson: _idFromJson)
  final String? citizenTypeId;
  final String? citizenTypeName;

  ProfileCitizen({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.gender,
    this.email,
    this.phone,
    this.nationalId,
    this.dateOfBirth,
    this.profileStatus,
    this.isVerified,
    this.identityVerificationStatus,
    this.citizenTypeId,
    this.citizenTypeName,
  });

  static String? _idFromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) return json;
    if (json is int) return json.toString();
    return json.toString();
  }

  factory ProfileCitizen.fromJson(Map<String, dynamic> json) =>
      _$ProfileCitizenFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileCitizenToJson(this);
}

