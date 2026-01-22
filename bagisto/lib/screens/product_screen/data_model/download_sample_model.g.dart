// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_sample_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadSampleModel _$DownloadSampleModelFromJson(Map<String, dynamic> json) =>
    DownloadSampleModel(
      string: json['string'] as String?,
    )
      ..success = json['success'] as bool?
      ..graphqlErrors = json['graphqlErrors'] as String?
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..error = json['error'];

Map<String, dynamic> _$DownloadSampleModelToJson(
        DownloadSampleModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'graphqlErrors': instance.graphqlErrors,
      'status': instance.status,
      'message': instance.message,
      'cartCount': instance.cartCount,
      'error': instance.error,
      'string': instance.string,
    };
