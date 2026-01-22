// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpModel _$SignUpModelFromJson(Map<String, dynamic> json) => SignUpModel(
      token: json['accessToken'] as String?,
      tokenType: json['tokenType'] as String?,
      data: json['citizen'] == null
          ? null
          : CitizenData.fromJson(json['citizen'] as Map<String, dynamic>),
      success: json['success'] as bool?,
      status: json['status'] as bool?,
      message: json['message'] as String?,
      graphqlErrors: json['graphqlErrors'] as String?,
    );

Map<String, dynamic> _$SignUpModelToJson(SignUpModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'graphqlErrors': instance.graphqlErrors,
      'accessToken': instance.token,
      'tokenType': instance.tokenType,
      'citizen': instance.data,
    };

CitizenData _$CitizenDataFromJson(Map<String, dynamic> json) => CitizenData(
      id: json['id'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      nationalId: json['nationalId'] as String?,
    );

Map<String, dynamic> _$CitizenDataToJson(CitizenData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'email': instance.email,
      'nationalId': instance.nationalId,
    };
