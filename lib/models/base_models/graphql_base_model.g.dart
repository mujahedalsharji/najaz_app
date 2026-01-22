// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphql_base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GraphQLBaseModel _$GraphQLBaseModelFromJson(Map<String, dynamic> json) =>
    GraphQLBaseModel(
      success: json['success'] as bool?,
      status: json['status'] as bool?,
      message: json['message'] as String?,
      graphqlErrors: json['graphqlErrors'] as String?,
    );

Map<String, dynamic> _$GraphQLBaseModelToJson(GraphQLBaseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'graphqlErrors': instance.graphqlErrors,
    };
