// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyProfileModel _$MyProfileModelFromJson(Map<String, dynamic> json) =>
    MyProfileModel(
      id: MyProfileModel._idFromJson(json['id']),
      firstName: json['firstName'] as String?,
      middleName: json['middleName'] as String?,
      lastName: json['lastName'] as String?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      nationalId: json['nationalId'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      profileStatus: json['status'] as bool?,
      isVerified: json['isVerified'] as bool?,
      identityVerificationStatus: json['identityVerificationStatus'] as bool?,
      citizenTypeId: MyProfileModel._idFromJson(json['citizenTypeId']),
      citizenTypeName: json['citizenTypeName'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      identityVerification: json['identityVerification'] == null
          ? null
          : IdentityVerification.fromJson(
              json['identityVerification'] as Map<String, dynamic>),
      success: json['success'] as bool?,
      message: json['message'] as String?,
      graphqlErrors: json['graphqlErrors'] as String?,
    );

Map<String, dynamic> _$MyProfileModelToJson(MyProfileModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'graphqlErrors': instance.graphqlErrors,
      'id': instance.id,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'email': instance.email,
      'phone': instance.phone,
      'nationalId': instance.nationalId,
      'dateOfBirth': instance.dateOfBirth,
      'status': instance.profileStatus,
      'isVerified': instance.isVerified,
      'identityVerificationStatus': instance.identityVerificationStatus,
      'citizenTypeId': instance.citizenTypeId,
      'citizenTypeName': instance.citizenTypeName,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'identityVerification': instance.identityVerification,
    };

IdentityVerification _$IdentityVerificationFromJson(
        Map<String, dynamic> json) =>
    IdentityVerification(
      id: IdentityVerification._idFromJson(json['id']),
      citizenId: IdentityVerification._idFromJson(json['citizenId']),
      status: json['status'] as String?,
      citizen: json['citizen'] == null
          ? null
          : ProfileCitizen.fromJson(json['citizen'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IdentityVerificationToJson(
        IdentityVerification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'citizenId': instance.citizenId,
      'status': instance.status,
    'citizen': instance.citizen,
    };

ProfileCitizen _$ProfileCitizenFromJson(Map<String, dynamic> json) =>
    ProfileCitizen(
      id: ProfileCitizen._idFromJson(json['id']),
      firstName: json['firstName'] as String?,
      middleName: json['middleName'] as String?,
      lastName: json['lastName'] as String?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      nationalId: json['nationalId'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      profileStatus: json['status'] as bool?,
      isVerified: json['isVerified'] as bool?,
      identityVerificationStatus: json['identityVerificationStatus'] as bool?,
      citizenTypeId: ProfileCitizen._idFromJson(json['citizenTypeId']),
      citizenTypeName: json['citizenTypeName'] as String?,
    );

Map<String, dynamic> _$ProfileCitizenToJson(ProfileCitizen instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'email': instance.email,
      'phone': instance.phone,
      'nationalId': instance.nationalId,
      'dateOfBirth': instance.dateOfBirth,
      'status': instance.profileStatus,
      'isVerified': instance.isVerified,
      'identityVerificationStatus': instance.identityVerificationStatus,
      'citizenTypeId': instance.citizenTypeId,
      'citizenTypeName': instance.citizenTypeName,
    };
