// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_in_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogInModel _$LogInModelFromJson(Map<String, dynamic> json) => LogInModel(
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

Map<String, dynamic> _$LogInModelToJson(LogInModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'graphqlErrors': instance.graphqlErrors,
      'accessToken': instance.token,
      'tokenType': instance.tokenType,
      'citizen': instance.data,
    };
