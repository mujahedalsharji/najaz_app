// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cms_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CmsData _$CmsDataFromJson(Map<String, dynamic> json) => CmsData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..graphqlErrors = json['graphqlErrors'] as String?
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..error = json['error'];

Map<String, dynamic> _$CmsDataToJson(CmsData instance) => <String, dynamic>{
      'success': instance.success,
      'graphqlErrors': instance.graphqlErrors,
      'status': instance.status,
      'message': instance.message,
      'cartCount': instance.cartCount,
      'error': instance.error,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as String?,
      translations: (json['translations'] as List<dynamic>?)
          ?.map((e) => Translations.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'translations': instance.translations,
    };

Translations _$TranslationsFromJson(Map<String, dynamic> json) => Translations(
      id: json['id'] as String?,
      locale: json['locale'] as String?,
      name: json['name'] as String?,
      pageTitle: json['pageTitle'] as String?,
      urlKey: json['urlKey'] as String?,
    );

Map<String, dynamic> _$TranslationsToJson(Translations instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pageTitle': instance.pageTitle,
      'name': instance.name,
      'locale': instance.locale,
      'urlKey': instance.urlKey,
    };
