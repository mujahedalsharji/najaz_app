// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_configs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoreConfigsModel _$CoreConfigsModelFromJson(Map<String, dynamic> json) =>
    CoreConfigsModel(
      coreConfigs: json['coreConfigs'] == null
          ? null
          : CoreConfigs.fromJson(json['coreConfigs'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CoreConfigsModelToJson(CoreConfigsModel instance) =>
    <String, dynamic>{
      'coreConfigs': instance.coreConfigs,
    };

CoreConfigs _$CoreConfigsFromJson(Map<String, dynamic> json) => CoreConfigs(
      paginatorInfo: json['paginatorInfo'] == null
          ? null
          : PaginatorInfo.fromJson(
              json['paginatorInfo'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ConfigModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CoreConfigsToJson(CoreConfigs instance) =>
    <String, dynamic>{
      'paginatorInfo': instance.paginatorInfo,
      'data': instance.data,
    };

ConfigModel _$ConfigModelFromJson(Map<String, dynamic> json) => ConfigModel(
      id: json['id'] as String?,
      code: json['code'] as String?,
      value: json['value'] as String?,
      channelCode: json['channelCode'] as String?,
      localeCode: json['localeCode'] as String?,
    );

Map<String, dynamic> _$ConfigModelToJson(ConfigModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'value': instance.value,
      'channelCode': instance.channelCode,
      'localeCode': instance.localeCode,
    };
