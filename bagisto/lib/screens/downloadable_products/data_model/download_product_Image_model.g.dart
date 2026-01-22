// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_product_Image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadLinkDataModel _$DownloadLinkDataModelFromJson(
        Map<String, dynamic> json) =>
    DownloadLinkDataModel(
      string: json['string'] as String?,
      download: json['download'] == null
          ? null
          : DownloadLinkProduct.fromJson(
              json['download'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..graphqlErrors = json['graphqlErrors'] as String?
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..error = json['error'];

Map<String, dynamic> _$DownloadLinkDataModelToJson(
        DownloadLinkDataModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'graphqlErrors': instance.graphqlErrors,
      'status': instance.status,
      'message': instance.message,
      'cartCount': instance.cartCount,
      'error': instance.error,
      'string': instance.string,
      'download': instance.download,
    };

DownloadLinkProduct _$DownloadLinkProductFromJson(Map<String, dynamic> json) =>
    DownloadLinkProduct(
      id: json['id'] as String?,
      fileName: json['fileName'] as String?,
    );

Map<String, dynamic> _$DownloadLinkProductToJson(
        DownloadLinkProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fileName': instance.fileName,
    };
