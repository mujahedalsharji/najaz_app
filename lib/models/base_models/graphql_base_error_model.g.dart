// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphql_base_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GraphQLBaseErrorModel _$GraphQLBaseErrorModelFromJson(
        Map<String, dynamic> json) =>
    GraphQLBaseErrorModel(
      success: json['success'] as String?,
      responseStatus: json['responseStatus'] as bool?,
      message: json['message'] as String?,
      graphqlErrors: json['graphqlErrors'] as String?,
    );

Map<String, dynamic> _$GraphQLBaseErrorModelToJson(
        GraphQLBaseErrorModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseStatus': instance.responseStatus,
      'message': instance.message,
      'graphqlErrors': instance.graphqlErrors,
    };
